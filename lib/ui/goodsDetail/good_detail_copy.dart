import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/utils/widget_util.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_custom_header_delegate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GoodsDetail extends StatefulWidget {
  final Map arguments;

  @override
  _GoodsDetailState createState() => _GoodsDetailState();

  GoodsDetail({this.arguments});
}

class _GoodsDetailState extends State<GoodsDetail> {
  List imgList = [];

  bool initLoading = true;

  int goodsCount = 0; //购物车商品数量

  Map goodsMsgs;

  List chooseSizeIndex; // 当前所选的规格下标

  String chooseSizeStr; // 当前所选的规格名称

  Map goodsStockPrice; // 当前所选的规格商品信息(库存、价格等)

  int goodsNumber = 0; //商品数量

  int goodsMin = 0; //商品最少

  int goodsMax = 0; //商品最多

  String userToken; //用户token

  int userHasCollect; //用户是否收藏0：否；1：是

  ScrollController _scrollController = ScrollController();

  bool isShowFloatBtn = false;
  Map goodDetail = {};
  Map goodDetailPre = {};
  List rmdList = [];

  var actvity = {
    "bannerTitleUrl": "https://yanxuan.nosdn.127.net/d71e2460d062eaa21d5bdf97eba9da89.png",
    "bannerContentUrl": "https://yanxuan.nosdn.127.net/c168892ef76f29971032dc1c12613720.png",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData();
    _getDetail();
    _getDetailPageUp();
    _getRMD();

    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.position.pixels > 500) {
          isShowFloatBtn = true;
        } else {
          isShowFloatBtn = false;
        }
      });
    });
  }

  void _getDetail() async {
    //获取详情 页面下半部分详情数据
//    https://m.you.163.com/xhr/item/detail.json
    Response response = await Dio().post('https://m.you.163.com/xhr/item/detail.json',
        queryParameters: {'id': widget.arguments['id']});
    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    setState(() {
      goodDetail = dataMap['data'];
    });
  }

  void _getDetailPageUp() async {
    //获取详情 页面上半部分详情数据
    Response response = await Dio().post('https://you.163.com/item/detail.json',
        queryParameters: {'id': widget.arguments['id']});
    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    setState(() {
      goodDetailPre = dataMap;
    });
  }

  void _getRMD() async {
    //获取推荐
//    https://m.you.163.com/xhr/item/detail.json
    Response response = await Dio().post('https://m.you.163.com/xhr/wapitem/rcmd.json',
        queryParameters: {'id': widget.arguments['id']});
    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    setState(() {
      rmdList = dataMap['data']['items'];
    });
  }

  _getInitData() async {
    var id = widget.arguments['id'];
    print(id);

    Response data = await Api.getGoodMSG(id: id, token: null);
    var goodsMsg = data.data;
    var specificationList = goodsMsg['specificationList'];
    List<int> sizeIndex = [];
    List<String> sizeNameList = [];
    List<int> sizeId = [];
    for (var i = 0; i < specificationList.length; i++) {
      if (specificationList[i]['valueList'].length > 0) {
        sizeIndex.add(0);
        sizeId.add(specificationList[i]['valueList'][0]['id']);
        sizeNameList.add(specificationList[i]['valueList'][0]['value']);
      }
    }
    Map goodsStockPriceAny = getGoodsMsgById(goodsMsg['productList'], sizeId.join('_'));
    setState(() {
      imgList = goodsMsg['gallery'];
      goodsMsgs = goodsMsg;
      userHasCollect = goodsMsg['userHasCollect'];
      initLoading = false;
      goodsMax = goodsStockPriceAny['goods_number'];
      chooseSizeIndex = sizeIndex;
      chooseSizeStr = sizeNameList.join('、');
      goodsStockPrice = goodsStockPriceAny;
      userToken = null;
      goodsCount = 0;
    });
  }

  // 获取某规格的商品信息
  getGoodsMsgById(List productList, String id) {
    for (int i = 0; i < productList.length; i++) {
      if (productList[i]['goods_specification_ids'] == id) {
        return productList[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: buildContent(),
            ),
            buildFoot(),
          ],
        ),
        floatingActionButton: !isShowFloatBtn
            ? Container()
            : GestureDetector(
                child: Container(
                  height: 44,
                  width: 44,
                  margin: EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Color(0xD9D6D6D6),
                  ),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.black38,
                  ),
                ),
                onTap: () {
                  _scrollController.position.jumpTo(0);
                },
              ));
  }

  Widget buildFoot() {
    return Container(
      height: 45,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          //收藏
          Container(
            width: 50,
            child: Column(
              children: <Widget>[
                Expanded(child: Icon(Icons.star_border)),
                Text(
                  '收藏',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

          //购物车
//          Container(
//            width: 50,
//            child: Column(
//              children: <Widget>[
//                Expanded(child: Icon(Icons.shopping_cart)),
//                Text(
//                  '购物车',
//                  style: TextStyle(fontSize: 12),
//                ),
//              ],
//            ),
//          ),

          Expanded(
            flex: 1,
            child: Container(
              height: 45,
              decoration: BoxDecoration(color: Colors.red),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  '马上购买',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 45,
              decoration: BoxDecoration(color: Colors.orange),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  '加入购物车',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 1, spreadRadius: 0.2)]),
    );
  }

  //内容
  Widget buildContent() {
    if (initLoading) {
      return Loading();
    } else {
      return CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
              title: initLoading ? 'loading...' : '${goodsMsgs['info']['name']}',
              collapsedHeight: 50,
              expandedHeight: 350,
              paddingTop: MediaQuery.of(context).padding.top,
              child: buildSwiper(context, imgList),
            ),
          ),
          //banner底部活动
          WidgetUtil.buildASingleSliver(buildActivity()),
          //简述
          WidgetUtil.buildASingleSliver(buildDescription()),
          //选择属性
          WidgetUtil.buildASingleSliver(buildSelectProperty()),
          //评论
          WidgetUtil.buildASingleSliver(buildComment()),
          //详情title
          WidgetUtil.buildASingleSliver(builddetailTitle()),
          //成分
          buildIntro(),
          //商品详情
          WidgetUtil.buildASingleSliver(goodDetail.isEmpty ? Container() : buildGoodDetail()),
          //报告
          buildReport(),
          //常见问题
          WidgetUtil.buildASingleSliver(
              goodDetail.isEmpty ? Container() : buildIssuTitle('-- 常见问题 --')),
          buildIssueList(),
          //推荐
          WidgetUtil.buildASingleSliver(
              goodDetail.isEmpty ? Container() : buildIssuTitle('-- 你可能还喜欢 --')),
          buildrecommond(),
        ],
      );
    }
  }

  Widget buildSwiper(BuildContext context, List imgList) {
    if (imgList.isEmpty) {
      return Container(
        color: Colors.grey,
        child: Center(
          child: Text(
            '暂无图片',
            style: TextStyle(fontSize: 16, color: Colors.black38),
          ),
        ),
      );
    }
    return Swiper(
      itemCount: imgList.length,
      itemBuilder: (BuildContext context, int index) {
        return CachedNetworkImage(
          imageUrl: imgList[index]['img_url'],
          fit: BoxFit.cover,
        );
      },
      controller: SwiperController(),
      scrollDirection: Axis.horizontal,
      autoplay: true,
      autoplayDelay: 4000,
      onTap: (index) => Toast.show('$index', context),
    );
  }

  buildActivity() {
    return Container(
      width: double.infinity,
      height: 35,
      child: Stack(
        children: <Widget>[
          Container(
            height: 35,
            decoration: BoxDecoration(color: Colors.red),
          ),
          Container(
            width: 70,
            height: 35,
            child: CachedNetworkImage(
              imageUrl: actvity['bannerTitleUrl'],
              fit: BoxFit.fill,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 70,
                height: 35,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      goodsMsgs['info']['promotion_desc'],
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '￥${goodsMsgs['info']['retail_price']}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    goodsMsgs['info']['goods_brief'],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOneTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      color: Color.fromARGB(255, 244, 244, 244),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(Icons.star, color: Colors.red), Text('活动活动')],
              )),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(Icons.star, color: Colors.red), Text('活动活动')],
              )),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(Icons.star, color: Colors.red), Text('活动活动')],
              )),
        ],
      ),
    );
  }

  Widget buildDescription() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              goodsMsgs['info']['name'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              '推荐理由',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Container(
            width: double.infinity,
            decoration:
                BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(2)),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              goodsMsgs['brand'].isEmpty
                  ? goodsMsgs['info']['goods_brief']
                  : goodsMsgs['brand']['simple_desc'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '￥${goodsMsgs['info']['retail_price']}',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '已售${goodsMsgs['info']['sell_volume']}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              )),
          Container(
            decoration:
                BoxDecoration(border: Border(top: BorderSide(width: 0.5, color: Colors.grey[100]))),
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text('服务:'),
                ),
                Expanded(
                    child: Container(
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: buildSerVice(),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectProperty() {
    return InkResponse(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              child: Text(
                '已选',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      '${chooseSizeStr.length > 0 ? chooseSizeStr : '该商品没有size'}',
                      overflow: TextOverflow.ellipsis,
                    )),
                    Text('x$goodsNumber'),
                  ],
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
      onTap: () {
        buildSizeModel(context);
      },
    );
  }

  Widget buildComment() {
    var comment = goodsMsgs['comment'];
    List<Widget> imgs = [];
    if (comment['count'] > 0) {
      var imgList = comment['data']['pic_list'];
      for (int i = 0; i < imgList.length; i++) {
        imgs.add(Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
          child: CachedNetworkImage(
            imageUrl: imgList[i]['pic_url'],
            fit: BoxFit.cover,
          ),
        ));
      }
    }

    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            InkResponse(
              highlightColor: Colors.transparent,
              radius: 0,
              onTap: () {
                Router.push(Util.comment, context, {'id': widget.arguments['id']});
                print(widget.arguments['id']);
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Text(
                        '评论',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text('99+ 条'),
                    ),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[200],
            ),
            comment['count'] > 0
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text('匿名用户')),
                        Text('${comment['data']['add_time']}')
                      ],
                    ),
                  )
                : Container(),
            comment['count'] > 0
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${comment['data']['content']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : Container(),
            comment['count'] > 0
                ? Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: double.infinity,
                    child: Wrap(
                      children: imgs,
                    ),
                  )
                : Container(),
          ],
        ));
  }

  Widget buildGoodDetail() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: <Widget>[
          Html(
            data: goodDetail['html'].replaceAll('<p><br/></p>', ''),
          )
        ],
      ),
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  buildSizeModel(BuildContext context) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context1, setstate1) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
//                定位右侧
                Align(
                  alignment: Alignment.topRight,
                  child: InkResponse(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                ),
                //商品描述
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: CachedNetworkImage(
                          imageUrl: goodsMsgs['info']['list_pic_url'],
                          fit: BoxFit.cover,
                        ),
                        height: 100,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            //右上角图标
                            Container(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '￥${goodsMsgs['info']['retail_price']}',
                                  style: TextStyle(color: Colors.red, fontSize: 24),
                                ),
                              ),
                            ),
                            // 商品描述
                            Container(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '${goodsMsgs['info']['name']}',
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Wrap(
                    children: <Widget>[],
                  ),
                ),
                //数量
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '数量',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              '马上购买',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              '加入购物车',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  SliverList buildIntro() {
    return goodDetail.isEmpty
        ? WidgetUtil.buildASingleSliver(Container())
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            width: 0.5, color: Colors.grey[200], style: BorderStyle.solid))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('${goodDetail['attrList'][index]['attrName']}'),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '${goodDetail['attrList'][index]['attrValue']}',
                        ),
                      ),
                    )
                  ],
                ),
              );
            }, childCount: goodDetail['attrList'] == null ? 0 : goodDetail['attrList'].length),
          );
  }

  Widget builddetailTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '商品详情',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.bold),
      ),
    );
  }

  SliverList buildReport() {
    return goodDetail.isEmpty
        ? WidgetUtil.buildASingleSliver(Container())
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: goodDetail['reportPicList'][index],
                  fit: BoxFit.cover,
                ),
              );
            }, childCount: goodDetail['reportPicList'].length),
          );
  }

  SliverList buildIssueList() {
    return goodDetail.isEmpty
        ? WidgetUtil.buildASingleSliver(Container())
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
            var issueList = goodDetail['issueList'];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      issueList[index]['question'],
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      issueList[index]['answer'],
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          }, childCount: goodDetail['issueList'].length));
  }

  buildIssuTitle(String title) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  SliverGrid buildrecommond() {
    return rmdList.isEmpty
        ? WidgetUtil.buildASingleSliverGrid(Container(), 2)
        : SliverGrid(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              Widget widget = Container(
                padding: EdgeInsets.only(bottom: 5),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Stack(
                          overflow: Overflow.clip,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: rmdList[index]['primaryPicUrl'],
                              fit: BoxFit.fill,
                            ),
                            rmdList[index]['listPromBanner']['promoTitle'] != null
                                ? buildImage(index)
                                : buildBottomText(index)
                          ],
                        ),
                        decoration: BoxDecoration(color: Colors.grey[200]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        child: Text(
                          rmdList[index]['name'],
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            '￥${rmdList[index]['retailPrice']}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        rmdList[index]['itemTagList'] == null
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.red, width: 0.5)),
                                child: Text(
                                  '${rmdList[index]['itemTagList'][0]['name'] == null ? '年货特惠' : rmdList[index]['itemTagList'][0]['name']}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16, color: Colors.red),
                                ),
                              ),
                        Expanded(child: Container())
                      ],
                    ),
                  ],
                ),
              );
              return GestureDetector(
                child: widget,
                onTap: () {
                  _getDetail();
                },
              );
            }, childCount: rmdList.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.65, mainAxisSpacing: 3, crossAxisSpacing: 3),
          );
  }

  buildImage(int index) {
    return Positioned(
        bottom: 0,
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5),
                height: 30,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: CachedNetworkImage(
                        imageUrl: rmdList[index]['listPromBanner']['bannerContentUrl'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    Center(
                      child: Text(rmdList[index]['listPromBanner']['content']),
                    ),
                  ],
                ),
              ),
              Container(
                width: 70,
                height: 35,
                child: CachedNetworkImage(
                  imageUrl: rmdList[index]['listPromBanner']['bannerTitleUrl'],
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                  width: 70,
                  height: 35,
                  child: Center(
                    child: Stack(
                      alignment: const FractionalOffset(0.5, 0.5),
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              rmdList[index]['listPromBanner']['promoTitle'],
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              rmdList[index]['listPromBanner']['promoSubTitle'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              Positioned(
                left: 75,
                height: 30,
                child: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Center(
                      child: Text(rmdList[index]['listPromBanner']['content'],
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    )),
              ),
            ],
          ),
        ));
  }

  buildBottomText(int index) {
    return Positioned(
      bottom: 0,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Text(
          rmdList[index]['simpleDesc'],
          style: TextStyle(color: Color(0XFF875D2A), fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  List service = ['不支持无忧退换货', '48小时快速退款', '满88包邮', '网易自营品牌', '国内部分地区无法配送'];

  List<Widget> buildSerVice() => List.generate(service.length, (index) {
        return Container(
          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              border: Border.all(width: 0.5, color: Colors.grey[200])),
          child: Text(
            '${service[index]}',
            style: TextStyle(color: Colors.grey),
          ),
        );
      });
}
