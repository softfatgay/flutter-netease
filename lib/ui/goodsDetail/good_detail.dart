import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/sort/good_item.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/count.dart';
import 'package:flutter_app/widget/floatingActionButton.dart';
import 'package:flutter_app/widget/global.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_custom_header_delegate.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/start_widget.dart';

class GoodsDetail extends StatefulWidget {
  final Map arguments;

  @override
  _GoodsDetailState createState() => _GoodsDetailState();

  GoodsDetail({this.arguments});
}

class _GoodsDetailState extends State<GoodsDetail> {
  int skuId = 0; //属性id
  int goodCount = 1; //商品数量
  String price = ''; //商品价格
  String counterPrice = ''; //商品价格
  String skuLimit; //商品限制规则
  String promoTip = ''; //商品活动介绍
  List couponShortNameList = []; //券活动/标签等
  List hdrkDetailVOList; //促销

  var skuFreight; //邮费
  var monthlySavingCard; //省钱月卡

  bool initLoading = true;
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();

  bool isShowFloatBtn = false;
  Map goodDetail = {};
  List<String> detailImages = List<String>();
  Map goodDetailPre = {};
  List rmdList = [];

  List banner = [];

  ///商品属性规格等
  List skuSpecList = [];
  var skuMap;
  var skuMapItem;

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
    print("获取详情 页面下半部分详情数据");
    String dataStr = json.encode(response.data);
    print(dataStr);
    RegExp exp = new RegExp(r'[a-z|A-Z|0-9]{32}.jpg');
    List<String> imageUrls = List<String>();
    Iterable<Match> mobiles = exp.allMatches(dataStr);
    for (Match m in mobiles) {
      String match = m.group(0);
      String imageUrl = 'https://yanxuan-item.nosdn.127.net/${match}';
      if (!imageUrls.contains(imageUrl)) {
        print(imageUrl);
        imageUrls.add(imageUrl);
      }
    }
    setState(() {
      detailImages = imageUrls;
    });

    ///商品详情数据
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
      //选择属性id
      var goodData = goodDetailPre['item'];

      var skuList = goodData['skuList'];
      monthlySavingCard = goodData["monthlySavingCard"];
      price = goodData["retailPrice"].toString();
      counterPrice = goodData["counterPrice"].toString();

      skuLimit = goodData['itemLimit'];

      ///选择属性/规格等
      skuSpecList = goodData['skuSpecList'];
      skuMap = goodData['skuMap'];
      promoTip = goodData['promoTip'];
      couponShortNameList = goodData['couponShortNameList'];
      hdrkDetailVOList = goodData['hdrkDetailVOList'];
      skuFreight = goodData['skuFreight'];

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
        body: Stack(
          children: <Widget>[
            buildContent(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: buildFoot(),
              ),
            )
          ],
        ),
        floatingActionButton:
            !isShowFloatBtn ? Container() : floatingAB(_scrollController));
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
              paddingTop: MediaQuery.of(context).padding.top,
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
              // goodDetail.isEmpty ? Container() : buildGoodDetail()),
              detailImages.isEmpty ? Container() : buildGoodDetail()),
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
          GoodItemWidget(dataList: rmdList),
          singleSliverWidget(Container(
            height: 100,
          )),
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
              promoTip ?? '',
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
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                    color: redLightColor,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  hdrkDetailVOList[0]['activityType'],
                                  style: t12white,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: Text(
                                      hdrkDetailVOList[0]['name'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),Container(
                                    child: Text(
                                      hdrkDetailVOList[0]['promLimitDesc'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                          Expanded(
                              child:
                                  Text('$selectedDecLeft $selectedDecRight')),
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
          (skuLimit == null || skuLimit == '')
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
              color: lineColor,
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
                            '${DateUtil.formatDateMs(comments[0]['createTime']) + '   ' + comments[0]['skuInfo'][0]}',
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
    // return Container(
    //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    //   child: Html(
    //     data: goodDetail['html'].replaceAll('<p><br/></p>', ''),
    //   ),
    //   color: Colors.white,
    //   width: double.infinity,
    //   alignment: Alignment.center,
    // );
    final imgWidgts = detailImages
        .map<Widget>((e) => CachedNetworkImage(
              imageUrl: e,
              fit: BoxFit.cover,
            ))
        .toList();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: imgWidgts,
      ),
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.center,
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        Container(
                          child: Text(
                            policyList[index]['content'],
                            style: TextStyle(color: Colors.grey, fontSize: 14),
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
                    .map<Widget>((item) => Column(
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
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      Container(
                        child: Text(
                          shoppingRewardRuleDetail['content'],
                          style: TextStyle(color: Colors.grey, fontSize: 14),
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
    List attrList = goodDetail['attrList'];
    print("===============================");
    print(attrList);
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
                        child: Text('${attrList[index]['attrName']}'),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '${attrList[index]['attrValue']}',
                        ),
                      ),
                    )
                  ],
                ),
              );
            }, childCount: attrList == null ? 0 : attrList.length),
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
        '商品参数',
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
                      '￥$price',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${counterPrice == 'null' ? '' : '￥$counterPrice'}',
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
                        .map<Widget>((item) => Container(
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

  ///属性选择底部弹窗
  buildSizeModel(BuildContext context) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          child: StatefulBuilder(builder: (context, setstate) {
            return Container(
              constraints: BoxConstraints(maxHeight: 800),
              child: Stack(
                children: [
                  SingleChildScrollView(
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
                          Container(
                              child: Align(
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
                          )),
                          //商品描述
                          _selectGoodDetail(context),
                          _modelAndSize(context, setstate),
                          //数量
                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 10),
                            child: Text(
                              '数量',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
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
                          SizedBox(
                            height: 45,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: buildFoot(),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  _modelAndSize(BuildContext context, setstate) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var skuSpecItem = skuSpecList[index];
          var skuSpecItemNameList = skuSpecItem['skuSpecValueList'];
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(skuSpecItem['name']),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Wrap(
                    ///商品属性
                    spacing: 5,
                    runSpacing: 10,
                    children: _skuSpecItemNameList(
                        context, setstate, skuSpecItemNameList, index),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: skuSpecList.length,
      ),
    );
  }

  var property = {
    'leftId': '',
    'rightId': '',
  };

  var selectedDecLeft = '';
  var selectedDecRight = '';

  int selectedLId = 0;
  int selectedRId = 0;

  _skuSpecItemNameList(
      BuildContext context, setstate, List skuSpecItemNameList, int index) {
    return skuSpecItemNameList.map((item) {
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              border: Border.all(
                  width: 1,
                  color:
                      (selectedLId == item['id'] || selectedRId == item['id'])
                          ? redColor
                          : textGrey)),
          child: Text(
            '${item['value']}',
            style: TextStyle(
                color: (selectedLId == item['id'] || selectedRId == item['id'])
                    ? redColor
                    : textGrey),
            textAlign: TextAlign.center,
          ),
        ),
        onTap: () {
          print(property);
          print(index);

          setstate(() {
            if (skuSpecList.length > 1) {
              if (index == 0) {
                selectedLId = item['id'];
                property['leftId'] = item['id'].toString();
                selectedDecLeft = item['value'];
                print('leftId=================${item['id']}');
              } else {
                selectedRId = item['id'];
                property['rightId'] = item['id'].toString();
                selectedDecRight = item['value'];
                print('rightId----------${item['id']}');
              }
              skuMapItem = skuMap['${property['leftId']};${property['rightId']}'];
              if (skuMapItem!=null) {
                price = skuMapItem['retailPrice'].toString();
                counterPrice = skuMapItem['counterPrice'].toString();
              }
            } else {
              selectedLId = item['id'];
              selectedDecLeft = item['value'];
              skuMapItem = skuMap[item['id'].toString()];
            }
          });
          setState(() {
            if (skuSpecList.length > 1) {
              if (index == 0) {
                selectedLId = item['id'];
                property['leftId'] = item['id'].toString();
                selectedDecLeft = item['value'];
                print('leftId=================${item['id']}');
              } else {
                selectedRId = item['id'];
                property['rightId'] = item['id'].toString();
                selectedDecRight = item['value'];
                print('rightId----------${item['id']}');
              }
              skuMapItem =
                  skuMap['${property['leftId']};${property['rightId']}'];
              if (skuMapItem!=null) {
                price = skuMapItem['retailPrice'].toString();
                counterPrice = skuMapItem['counterPrice'].toString();
              }
            } else {
              selectedLId = item['id'];
              selectedDecLeft = item['value'];
              skuMapItem = skuMap[item['id'].toString()];
            }
          });
        },
      );
    }).toList();
  }

  _selectGoodDetail(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            child: CachedNetworkImage(
              imageUrl: (skuMapItem == null || skuMapItem['pic'] == null)
                  ? goodDetailPre['item']['primaryPicUrl']
                  : skuMapItem['pic'],
              fit: BoxFit.cover,
            ),
            height: 100,
            width: 100,
            color: Color(0x80F1F1F1),
          ),
          SizedBox(
            width: 10,
          ),
          skuMapItem == null
              ? Container()
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      skuMapItem['promotionDesc'] == null
                          ? Container()
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xFFEF7C15)),
                              child: Text(
                                skuMapItem['promotionDesc'],
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
                              '￥${skuMapItem['retailPrice']}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              child: Text(
                                '￥${skuMapItem['counterPrice']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textGrey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // 商品描述
                      Container(
                        child: Text(
                          '已选择：$selectedDecLeft $selectedDecRight',
                          overflow: TextOverflow.clip,
                          style: TextStyle(color: textBlack, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  ///底部展示
  Widget buildFoot() {
    if (skuMapItem == null) {
      return _defaultBottomBtns();
    } else {
      int sellVolume = skuMapItem['sellVolume'];
      int purchaseAttribute = skuMapItem['purchaseAttribute'];
      if (sellVolume > 0) {
        return _activityBtns(purchaseAttribute);
      } else {
        return _noGoodsSell();
      }
    }
  }

  ///默认展示形式
  _defaultBottomBtns() {
    return Container(
      height: 45,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          //客服
          _kefuWidget(),
          _buyButton(0),
          _putCarShop(0)
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: lineColor, blurRadius: 1, spreadRadius: 0.2)
      ]),
    );
  }

  _activityBtns(int purchaseAttribute) {
    return Container(
      height: 45,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          //客服
          _kefuWidget(),
          _buyButton(purchaseAttribute),
          _putCarShop(purchaseAttribute)
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: lineColor, blurRadius: 1, spreadRadius: 0.2)
      ]),
    );
  }

  _kefuWidget() {
    return GestureDetector(
      child: Container(
        width: 80,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Image.asset(
              'assets/images/mine/kefu.png',
              width: 30,
              height: 30,
            )),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Util.webView, context,
            {'id': 'https://cs.you.163.com/client?k=$kefuKey'});
      },
    );
  }

  _buyButton(int purchaseAttribute) {
    String text = '立即购买';
    if (skuMapItem != null &&
        skuMapItem['buyTitle'] != null &&
        purchaseAttribute == 1) {
      var buyTitle = skuMapItem['buyTitle'];
      text = '${buyTitle['title']}${buyTitle['subTitle']}';
    }
    return Expanded(
      flex: 1,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            border: Border(left: BorderSide(color: lineColor, width: 1))),
        child: FlatButton(
          onPressed: () {
            if (skuMapItem == null) {
              buildSizeModel(context);
            } else {
              //加入购物车
              _buyGoods();
            }
          },
          child: Text(
            '$text',
            style: purchaseAttribute == 0 ? t16blackbold : t16white,
          ),
          color: purchaseAttribute == 0 ? Colors.white : redColor,
        ),
      ),
    );
  }

  _putCarShop(int purchaseAttribute) {
    return purchaseAttribute == 1
        ? Container()
        : Expanded(
            flex: 1,
            child: Container(
              height: 45,
              child: FlatButton(
                onPressed: () {
                  if (skuMapItem == null) {
                    buildSizeModel(context);
                  } else {
                    //加入购物车
                    _addShoppingCart();
                  }
                },
                child: Text(
                  '加入购物车',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                color: redColor,
              ),
            ),
          );
  }

  ///不可售
  _noGoodsSell() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: lineColor, width: 1)),
              height: 45,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  '到货提醒',
                  style: t16black,
                ),
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 45,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  '售罄',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                color: lineColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///加入购物车
  void _addShoppingCart() async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "cnt": goodCount,
      "skuId": skuMapItem['id']
    };
    Map<String, dynamic> header = {"Cookie": cookie};
    await addCart(params, header: header).then((value) {
      Toast.show('添加成功', context);
      // _getDetailPageUp();
    });
  }

  ///购买
  void _buyGoods() {

  }
}
