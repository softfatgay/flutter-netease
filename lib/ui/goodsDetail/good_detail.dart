import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/utils/toast.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData();
  }

  _getInitData() async {
    var id = widget.arguments['id'];
    Response data = await Api.getGoodMSG(id: id, token: null);
    var goodsMsg = data.data;

//    LogUtil.e(data);

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
    Map goodsStockPriceAny =
        getGoodsMsgById(goodsMsg['productList'], sizeId.join('_'));
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
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: buildContent(),
          ),
          buildFoot(),
        ],
      ),
    );
  }

  Widget buildFoot() {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
          Container(
            width: 50,
            child: Column(
              children: <Widget>[
                Expanded(child: Icon(Icons.shopping_cart)),
                Text(
                  '购物车',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  '马上购买',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey[300], blurRadius: 1, spreadRadius: 0.2)
      ]),
    );
  }

  //内容
  Widget buildContent() {
    if (initLoading) {
      return Loading();
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
              title:
                  initLoading ? 'loading...' : '${goodsMsgs['info']['name']}',
              collapsedHeight: 50,
              expandedHeight: 350,
              paddingTop: MediaQuery.of(context).padding.top,
              child: buildSwiper(context, imgList),
            ),
          ),
          WidgetUtil.buildASingleSliver(buildOneTab()), //banner底部活动
          WidgetUtil.buildASingleSliver(buildDescription()), //简述
          WidgetUtil.buildASingleSliver(buildSelectProperty()), //选择属性
          WidgetUtil.buildASingleSliver(buildComment()), //评论
          WidgetUtil.buildASingleSliver(buildTextTitle('商品详情')), //商品详情标题
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
                children: <Widget>[
                  Icon(Icons.star, color: Colors.red),
                  Text('活动活动')
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star, color: Colors.red),
                  Text('活动活动')
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star, color: Colors.red),
                  Text('活动活动')
                ],
              )),
        ],
      ),
    );
  }

  Widget buildDescription() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              goodsMsgs['info']['name'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              goodsMsgs['info']['goods_brief'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              '￥${goodsMsgs['info']['retail_price']}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20, color: Colors.red),
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
                if (comment['count'] > 0) {}
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
                      child: Text('${comment['count']}条'),
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

  Widget buildTextTitle(String s) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Text(
              s,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Html(
            data:
                goodsMsgs['info']['goods_desc'].replaceAll('<p><br/></p>', ''),
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
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 24),
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
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
}
