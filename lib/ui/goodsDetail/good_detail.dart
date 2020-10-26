import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/count.dart';
import 'package:flutter_app/widget/global.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_custom_header_delegate.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/start_widget.dart';
import 'package:flutter_html/flutter_html.dart';

class GoodsDetail extends StatefulWidget {
  final Map arguments;

  @override
  _GoodsDetailState createState() => _GoodsDetailState();

  GoodsDetail({this.arguments});
}

class _GoodsDetailState extends State<GoodsDetail> {
  int skuId = 0; //属性id
  int goodCount = 1; //商品数量
  double price = 0; //商品价格
  double counterPrice = 0; //商品价格
  String skuDec = '规格'; //商品属性简介
  String skuLimit; //商品限制规则
  String promoTip = ''; //商品活动介绍
  String promotionDesc = ''; //商品活动介绍
  String skuTitle = ''; //选择描述
  List couponShortNameList,
      itemTagList = []; //券活动/标签等
  List hdrkDetailVOList; //促销

  var skuFreight; //邮费
  var monthlySavingCard; //省钱月卡

  bool initLoading = true;
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();

  bool isShowFloatBtn = false;
  Map goodDetail = {};
  Map goodDetailPre = {};
  List rmdList = [];

  List banner = [];

  var actvity = {
    "bannerTitleUrl":
    "https://yanxuan.nosdn.127.net/d71e2460d062eaa21d5bdf97eba9da89.png",
    "bannerContentUrl":
    "https://yanxuan.nosdn.127.net/c168892ef76f29971032dc1c12613720.png",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.arguments['id']);
    _getDetailPageUp();
    _getDetail();
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

    _textEditingController.addListener(() {
      _textEditingController.text = goodCount.toString();
    });
  }

  void _getDetail() async {
    //获取详情 页面下半部分详情数据
//    https://m.you.163.com/xhr/item/detail.json
    Response response = await Dio().post(
        'https://m.you.163.com/xhr/item/detail.json',
        queryParameters: {'id': widget.arguments['id']});
    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    setState(() {
      goodDetail = dataMap['data'];
    });
  }

  void _getDetailPageUp() async {
    //3996494
    //获取详情 页面上半部分详情数据
    Response response = await Dio().get(
        'https://m.you.163.com/item/detail.json',
        queryParameters: {'id': widget.arguments['id']});
    Map<String, dynamic> dataMap = Map<String, dynamic>.from(response.data);
    setState(() {
      goodDetailPre = dataMap;
//      LogUtil.e(json.encode(goodDetailPre));
      //选择属性id
      var skuList = goodDetailPre['item']['skuList'];
      monthlySavingCard = goodDetailPre['item']["monthlySavingCard"];

      if (skuList != null && skuList.isNotEmpty) {
        skuId = skuList[0]['id'];
        skuList.forEach((item) {
          if (skuId == item['id']) {
            price = double.parse(item['retailPrice'].toString());
            counterPrice = double.parse(item['counterPrice'].toString());

            List itemSkuSpecValueList = item['itemSkuSpecValueList'];

            String skuDecL = "";
            itemSkuSpecValueList.forEach((element) {
              skuDecL += element['skuSpecValue']['value'];
            });
            skuDec = skuDecL;
            // skuDec = item['itemSkuSpecValueList'][0]['skuSpecValue']['value']+;
            skuLimit = item['skuLimit'];
            promoTip = item['promoTip'];
            promotionDesc = item['promotionDesc'];
            skuTitle = item['skuTitle'];
            couponShortNameList = item['couponShortNameList'];
            hdrkDetailVOList = item['hdrkDetailVOList'];
            itemTagList = item["itemTagList"];
            skuFreight = item["skuFreight"];
          }
        });
      } else {
        price = goodDetailPre['item']['retailPrice'];
        skuDec = goodDetailPre['item']['name'];
      }

      //默认属性

      ///banner
      var itemDetail = goodDetailPre['item']['itemDetail'];
      List<dynamic> bannerList = List<dynamic>.from(itemDetail.values);
      bannerList.forEach((image) {
        if (image.toString().startsWith('https://')) {
          banner.add(image);
        }
      });
      initLoading = false;
    });
  }

  void _getRMD() async {
    //获取推荐
//    https://m.you.163.com/xhr/item/detail.json
    Response response = await Dio().post(
        'https://m.you.163.com/xhr/wapitem/rcmd.json',
        queryParameters: {'id': widget.arguments['id']});
    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    setState(() {
      rmdList = dataMap['data']['items'];
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
          Expanded(
            flex: 1,
            child: Container(
              height: 45,
              decoration: BoxDecoration(color: Colors.red),
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
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                color: Colors.orange,
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
        controller: _scrollController,
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
              title: initLoading
                  ? 'loading...'
                  : '${goodDetailPre['item']['name']}',
              collapsedHeight: 50,
              expandedHeight: 250,
              paddingTop: MediaQuery
                  .of(context)
                  .padding
                  .top,
              child: buildSwiper(context, banner),
            ),
          ),
          // banner底部活动
          singleSliverWidget(buildActivity()),
          //商品名称
          singleSliverWidget(buildTitle()),
          //推荐理由
          singleSliverWidget(buildOnlyText()),
          buildRecommondReason(),
          //选择属性
          singleSliverWidget(buildSelectProperty()),
          // //服务
          singleSliverWidget(buildDescription()),
          //评论
          singleSliverWidget(buildComment()),
          //详情title
          singleSliverWidget(builddetailTitle()),
          //成分
          buildIntro(),
          //商品详情
          singleSliverWidget(
              goodDetail.isEmpty ? Container() : buildGoodDetail()),
          //报告
          buildReport(),
          //常见问题
          singleSliverWidget(
              goodDetail.isEmpty ? Container() : buildIssuTitle('-- 常见问题 --')),
          buildIssueList(),
          //推荐
          singleSliverWidget(goodDetail.isEmpty
              ? Container()
              : buildIssuTitle('-- 你可能还喜欢 --')),
          buildrecommond(),
        ],
      );
    }
  }

  Widget buildSwiper(BuildContext context, List imgList) {
    return BannerCacheImg(
      imageList: imgList,
      onTap: (index) {
        Routers.push(Util.image, context, {'id': '${imgList[index]}'});
      },
    );
  }

  buildActivity() {
    return promoTip == null
        ? Container()
        : Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(color: Color(0xFFFFF0DD)),
        child: Text(
          promoTip == null ? '' : promoTip,
          textAlign: TextAlign.start,
          style: TextStyle(color: Color(0xFFF48F57)),
        ));
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
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      '服务:',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: buildSerVice(),
                        ),
                      )),
                  Container(child: arrowRightIcon)
                ],
              ),
            ),
            onTap: () {
              buildServiceDialog(context);
            },
          )
        ],
      ),
    );
  }

  Widget buildSelectProperty() {
    var shoppingReward = goodDetailPre['item']['shoppingReward'];
    List skuList = goodDetailPre['item']['skuList'];
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[

          ///省钱月卡
          monthlySavingCard == null
              ? Container()
              : Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: backGrey),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFF8E4DF),
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: redColor,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    monthlySavingCard["title"],
                    style: TextStyle(
                        color: textRed, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Container(
                    color: redColor,
                    height: 15,
                    width: 1,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Text(
                      monthlySavingCard["desc"],
                      style: TextStyle(
                        color: textRed,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //领券
          (couponShortNameList == null || couponShortNameList.isEmpty)
              ? Container()
              : InkResponse(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Text(
                      '领券:',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFFBBB65))),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              couponShortNameList[0],
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      )),
                  arrowRightIcon,
                ],
              ),
            ),
            onTap: () {
              Toast.show('您还没有登录', context);
            },
          ),

          ///邮费
          skuFreight == null
              ? Container()
              : InkResponse(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '${skuFreight['title']}:',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        skuFreight['freightInfo'],
                        style: TextStyle(color: textBlack),
                      ),
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onTap: () {
              buildskuFreightDialog(context);
            },
          ),

          ///促销限制
          (hdrkDetailVOList == null || hdrkDetailVOList.isEmpty)
              ? Container()
              : Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: bottomBorder,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '促销',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 6),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              hdrkDetailVOList[0]['activityType'],
                              style: TextStyle(color: Colors.red,fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              hdrkDetailVOList[0]['name'],
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),

          ///购物反
          shoppingReward == null
              ? Container()
              : InkResponse(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '${shoppingReward['name']}:',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      shoppingReward['rewardDesc'],
                      style: TextStyle(color: textBlack),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        shoppingReward['rewardValue'],
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onTap: () {
              buildActivityDialog(context);
            },
          ),

          Container(height: 10, color: backGrey),

          ///选择属性
          InkResponse(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '已选:',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('$skuDec')),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'x$goodCount',
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onTap: () {
              buildSizeModel(context);
            },
          ),

          ///服务
          skuLimit == null
              ? Container()
              : Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: bottomBorder,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '限制:',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    skuLimit,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComment() {
    var commentCount = goodDetailPre['commentCount'];
    List comments = goodDetailPre['item']['comments'];
    var goodCmtRate = goodDetailPre['item']['goodCmtRate'];
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            InkResponse(
              highlightColor: Colors.transparent,
              radius: 0,
              onTap: () {
                Routers.push(
                    Util.comment, context, {'id': widget.arguments['id']});
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '用户评论($commentCount)',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              goodCmtRate == null ? "" : goodCmtRate,
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(goodCmtRate == null ? '查看全部' : '好评率'),
                          ],
                        )),
                    arrowRightIcon
                  ],
                ),
              ),
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              margin: EdgeInsets.only(left: 10),
              color: Colors.grey[100],
            ),
            comments.length > 0
                ? Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          width: 30,
                          height: 30,
                          child: CachedNetworkImage(
                            imageUrl:
                            comments[0]['frontUserAvatar'] == null
                                ? ''
                                : comments[0]['frontUserAvatar'],
                            errorWidget: (context, url, error) {
                              return ClipOval(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration:
                                  BoxDecoration(color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(comments[0]['frontUserName']),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Color(0xFFB19C6D),
                            borderRadius: BorderRadius.circular(2)),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                letterSpacing: -2),
                            children: [
                              TextSpan(
                                text: 'V',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: '${comments[0]['memberLevel']}',
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 8,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: StaticRatingBar(
                          size: 15,
                          rate: double.parse(
                              comments[0]['memberLevel'].toString()),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '${DateUtil.getDateStrByMs(comments[0]['createTime']) +
                          '   ' + comments[0]['skuInfo'][0]}',
                      style: TextStyle(color: Colors.grey),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(comments[0]['content']),
                  ),
                  Wrap(
                    spacing: 2,
                    runSpacing: 5,
                    children: commentPic(comments[0]['picList'] == null
                        ? []
                        : comments[0]['picList']),
                  )
                ],
              ),
            )
                : Container(),
          ],
        ));
  }

  List<Widget> commentPic(List commentList) =>
      List.generate(commentList.length, (indexC) {
        Widget widget = Container(
          width: 100,
          height: 100,
          child: CachedNetworkImage(
            imageUrl: commentList[indexC],
            fit: BoxFit.cover,
          ),
        );
        return Routers.link(
            widget, Util.image, context, {'id': '${commentList[indexC]}'});
      });

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

  ///属性选择底部弹窗
  buildSizeModel(BuildContext context) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setstate) {
          return Container(
            constraints: BoxConstraints(maxHeight: 600),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5.0),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //最小包裹高度
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //定位右侧
                    Align(
                      alignment: Alignment.topRight,
                      child: InkResponse(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.close,
                            color: redColor,
                          ),
                        ),
                      ),
                    ),
                    //商品描述
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: goodDetailPre['item']['primaryPicUrl'],
                              fit: BoxFit.cover,
                            ),
                            height: 100,
                            width: 100,
                            color: Color(0x80F1F1F1),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                (promotionDesc == null || promotionDesc == '')
                                    ? Container()
                                    : Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(4),
                                      color: Color(0xFFEF7C15)),
                                  child: Text(
                                    promotionDesc,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "价格：",
                                        style: TextStyle(color: textRed),
                                      ),
                                      Text(
                                        '￥${price.toString()}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      price.toString() ==
                                          counterPrice.toString()
                                          ?
                                          Container(): Container(
                                        child: Text(
                                          '￥${counterPrice.toString()}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: textGrey,
                                            decoration:
                                            TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // 商品描述
                                Container(
                                  child: Text(
                                    '已选择：$skuDec',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: textBlack, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                      child: Text('规格'),
                    ),
                    goodDetailPre['item']['skuList'].isEmpty
                        ? Container()
                        : Container(
                      alignment: Alignment.centerLeft,
                      child: Wrap(

                        ///商品属性
                        spacing: 5,
                        runSpacing: 10,
                        children: buildSkuList(context, setstate),
                      ),
                    ),
                    //数量
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(
                        '数量',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 25),
                      child: Count(
                        number: goodCount,
                        min: 1,
                        max: 100,
                        onChange: (index) {
                          setstate(() {
                            goodCount = index;
                          });
                          setState(() {
                            goodCount = index;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
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
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  ///服务弹窗
  buildServiceDialog(BuildContext context) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setstate) {
          List policyList = goodDetailPre['policyList'];
          return Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(5.0),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 2),
                              child: Text(
                                policyList[index]['title'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Container(
                              child: Text(
                                policyList[index]['content'],
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      );
                    }, childCount: policyList.length))
              ],
            ),
          );
        });
      },
    );
  }

  ///邮费
  buildskuFreightDialog(BuildContext context) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    List skuFreightList = skuFreight['policyList'];
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(maxHeight: 350),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: 250),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(5.0),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: skuFreightList
                    .map<Widget>((item) =>
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 3),
                          child: Text(
                            item['title'],
                            style: TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                        Container(
                          child: Text(
                            item['content'],
                            style:
                            TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        )
                      ],
                    ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  ///活动规则
  buildActivityDialog(BuildContext context) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    var shoppingRewardRule = goodDetailPre['item']['shoppingRewardRule'];
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        List shoppingRewardRuleList = shoppingRewardRule['ruleList'];
        return Container(
          height: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(5.0),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomScrollView(
            slivers: <Widget>[
              singleSliverWidget(
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${shoppingRewardRule['title']}',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    var shoppingRewardRuleDetail = shoppingRewardRuleList[index];
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 2),
                            child: Text(
                              shoppingRewardRuleDetail['title'],
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                          Container(
                            child: Text(
                              shoppingRewardRuleDetail['content'],
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    );
                  }, childCount: shoppingRewardRuleList.length)),
            ],
          ),
        );
      },
    );
  }

  Widget buildIntro() {
    return goodDetail.isEmpty
        ? singleSliverWidget(Container())
        : SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: topBorder,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                      '${goodDetail['attrList'][index]['attrName']}'),
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
      },
          childCount: goodDetail['attrList'] == null
              ? 0
              : goodDetail['attrList'].length),
    );
  }

  Widget builddetailTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        '产品参数',
        style: TextStyle(
            fontSize: 16, color: textBlack, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildReport() {
    return goodDetail['reportPicList'] == null
        ? singleSliverWidget(Container())
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

  Widget buildIssueList() {
    return goodDetail.isEmpty
        ? singleSliverWidget(Container())
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
        ? buildASingleSliverGrid(Container(), 2)
        : SliverGrid(
      delegate:
      SliverChildBuilderDelegate((BuildContext context, int index) {
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
                      rmdList[index]['listPromBanner'] != null
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
                  padding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: 2),
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
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
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
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: Colors.red, width: 0.5)),
                    child: Text(
                      '${rmdList[index]['itemTagList'][0]['name'] == null
                          ? '年货特惠'
                          : rmdList[index]['itemTagList'][0]['name']}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16, color: Colors.red),
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
            Routers.pop(context);
            Routers.push(Util.goodDetailTag, context,
                {'id': rmdList[index]['id']});
          },
        );
      }, childCount: rmdList.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3),
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
                        imageUrl: rmdList[index]['listPromBanner']
                        ['bannerContentUrl'],
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              rmdList[index]['listPromBanner']['promoSubTitle'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
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
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
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
    _textEditingController.dispose();
  }

  List<Widget> buildSerVice() =>
      List.generate(goodDetailPre['policyList'].length, (index) {
        List policyList = goodDetailPre['policyList'];
        return Container(
          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              border: Border.all(width: 0.5, color: Colors.grey[200])),
          child: Text(
            '${policyList[index]['title']}',
            style: TextStyle(color: Colors.black54),
          ),
        );
      });

  Widget buildRecommondR() {
    var recommendReason = this.goodDetailPre['item']['recommendReason'];
    return recommendReason.isEmpty
        ? Container(
      child: Text(this.goodDetailPre['item']['simpleDesc']),
    )
        : Wrap(
      spacing: 5,
      runSpacing: 5,
      children: List.generate(recommendReason.length, (index) {
        return Container(
          child: Text(recommendReason[index]),
        );
      }),
    );
  }

  ///推荐理由
  buildRecommondReason() {
    var recommendReason = this.goodDetailPre['item']['recommendReason'];
    return recommendReason.isEmpty
        ? singleSliverWidget(
      Container(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey[100]),
        child: Text(this.goodDetailPre['item']['simpleDesc']),
      ),
    )
        : SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey[100]),
                child: Text('${index + 1} ${recommendReason[index]}'),
              ));
        }, childCount: recommendReason.length));
  }

  Widget buildTitle() {
    var goodCmtRate = goodDetailPre['item']['goodCmtRate'];
    List itemTagListGood = goodDetailPre['item']['itemTagList'];
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '￥${price.toString()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        '￥${counterPrice.toString()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: textGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                )),
            itemTagListGood == null
                ? Container()
                : Row(
              children: itemTagListGood
                  .map<Widget>((item) =>
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                        Border.all(color: redColor, width: 0.5)),
                    child: Text(
                      item["name"],
                      style: TextStyle(fontSize: 12, color: redColor),
                    ),
                  ))
                  .toList(),
            ),

            /// itemTagList
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    goodDetailPre['item']['name'],
                    style: TextStyle(
                        fontSize: 18,
                        color: textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Container(
                      child: Row(
                        children: <Widget>[
                          goodCmtRate == null
                              ? Text('查看评价')
                              : Column(
                            children: <Widget>[
                              Text(goodCmtRate,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              Text('好评率',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12))
                            ],
                          ),
                          arrowRightIcon,
                        ],
                      )),
                  onTap: () {
                    Routers.push(
                        Util.comment, context, {'id': widget.arguments['id']});
                  },
                )
              ],
            ),
          ],
        ));
  }

  Widget buildOnlyText() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 5),
      child: Text(
        '推荐理由',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }

  List<Widget> buildSkuList(BuildContext context, setstate) =>
      List.generate(goodDetailPre['item']['skuList'].length, (index) {
        var skuList = this.goodDetailPre['item']['skuList'];
        var itemSkuSpecValueList = skuList[index]['itemSkuSpecValueList'];
        var skuListDetail = skuList[index]['itemSkuSpecValueList'][0];
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.only(right: 5),
            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                border: Border.all(
                    width: 1,
                    color:
                    skuId == skuList[index]['id'] ? redColor : textBlack)),
            child: Text(
              '${_getSkuItemText(itemSkuSpecValueList)}',
              style: TextStyle(
                  color: skuId == skuList[index]['id'] ? redColor : textBlack),
            ),
          ),
          onTap: () {
            setstate(() {
              skuId = skuList[index]['id'];
              price = double.parse(skuList[index]['retailPrice'].toString());
              counterPrice =
                  double.parse(skuList[index]['counterPrice'].toString());

              skuDec = _getSkuItemText(itemSkuSpecValueList);

              skuLimit = skuList[index]['skuLimit'];
              promoTip = skuList[index]['promoTip'];
              promotionDesc = skuList[index]['promotionDesc'];
              skuTitle = skuList[index]['skuTitle'];
              couponShortNameList = skuList[index]['couponShortNameList'];
              hdrkDetailVOList = skuList[index]['hdrkDetailVOList'];
            });
            setState(() {
              skuId = skuList[index]['id'];
              price = double.parse(skuList[index]['retailPrice'].toString());
              counterPrice =
                  double.parse(skuList[index]['counterPrice'].toString());
              // skuDec = skuList[index]['itemSkuSpecValueList'][0]['skuSpecValue']['value'];

              List itemSkuSpecValueList =
              skuList[index]['itemSkuSpecValueList'];

              skuDec = _getSkuItemText(itemSkuSpecValueList);

              // String  skuDecL = "" ;
              // itemSkuSpecValueList.forEach((element) {
              //   skuDecL += element['skuSpecValue']['value'];
              // });
              // skuDec = skuDecL;

              skuLimit = skuList[index]['skuLimit'];
              promoTip = skuList[index]['promoTip'];
              promotionDesc = skuList[index]['promotionDesc'];
              skuTitle = skuList[index]['skuTitle'];
              couponShortNameList = skuList[index]['couponShortNameList'];
              hdrkDetailVOList = skuList[index]['hdrkDetailVOList'];
            });
          },
        );
      });

  _getSkuItemText(List itemSkuSpecValueList) {
    String skuDecL = "";
    itemSkuSpecValueList.forEach((element) {
      skuDecL += element['skuSpecValue']['value'];
    });
    skuDec = skuDecL;

    return skuDec;
  }
}
