import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/banner.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/sliver_custom_header_delegate.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/goods_detail/components/goodMaterialWidget.dart';
import 'package:flutter_app/ui/goods_detail/components/good_detail_comment_widget.dart';
import 'package:flutter_app/ui/goods_detail/model/commondPageModel.dart';
import 'package:flutter_app/ui/goods_detail/model/skuListItem.dart';
import 'package:flutter_app/ui/pin/components/pin_top_widget.dart';
import 'package:flutter_app/ui/pin/components/ruleWidget.dart';
import 'package:flutter_app/ui/pin/model/pinItemDetailModel.dart';
import 'package:flutter_app/ui/pin/model/pinRecommonModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/toast.dart';

class PinPage extends StatefulWidget {
  final Map params;

  const PinPage({Key key, this.params}) : super(key: key);

  @override
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  bool _initLoading = true;

  PinItemDetailModel _detailModel;
  ItemInfo _itemInfo;
  final _scrollController = ScrollController();
  bool _isShowFloatBtn = false;

  int _bannerIndex = 0;

  List<ResultItem> _commentList = [];
  num _commentCount = 0;
  List<PinRecommonModel> _commonList = [];

  ///详情图片
  List<String> _detailImages = [];

  num _itemId = 3991032;
  num _baseId = 2054404;

  @override
  void initState() {
    // TODO: implement initState

    if (widget.params != null) {
      var params = widget.params;
      setState(() {
        _itemId = params['itemId'];
        _baseId = params['baseId'];
      });
    }
    super.initState();
    _pinItemDetail();
    _getCommentList();
    _pinRecommend();
  }

  _pinRecommend() async {
    Map<String, dynamic> params = {'baseId': _baseId};
    var responseData = await pinRecommend(params);
    if (responseData.code == '200') {
      List<PinRecommonModel> commonList = [];
      var data = responseData.data;
      data.forEach((element) {
        commonList.add(PinRecommonModel.fromJson(element));
      });
      setState(() {
        _commonList = commonList;
      });
    }
  }

  _pinItemDetail() async {
    Map<String, dynamic> params = {'baseId': _baseId};
    var responseData = await pinItemDetail(params);
    if (responseData.code == '200') {
      setState(() {
        _detailModel = PinItemDetailModel.fromJson(responseData.data);
        _itemInfo = _detailModel.itemInfo;
        _initLoading = false;
      });

      var html = _detailModel.itemDetail['detailHtml'];
      RegExp exp = new RegExp(r'[a-z|A-Z|0-9]{32}.jpg');
      List<String> imageUrls = [];
      Iterable<Match> mobiles = exp.allMatches(html);
      for (Match m in mobiles) {
        String match = m.group(0);
        String imageUrl = 'https://yanxuan-item.nosdn.127.net/$match';
        if (!imageUrls.contains(imageUrl)) {
          print(imageUrl);
          imageUrls.add(imageUrl);
        }
      }

      setState(() {
        _detailImages = imageUrls;
      });
    }
  }

  ///评价列表
  void _getCommentList() async {
    Map<String, dynamic> params = {
      'itemId': _itemId,
      'page': 1,
      'size': 1,
      'tag': '',
    };
    var responseData = await commentListData(params);
    setState(() {
      var commondPageModel = CommondPageModel.fromJson(responseData.data);
      _commentList = commondPageModel.result;
      _commentCount = commondPageModel.pagination.total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: _initLoading
          ? Loading()
          : Stack(
              children: <Widget>[
                _buildContent(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: _buildFoot(),
                  ),
                )
              ],
            ),
      floatingActionButton:
          _isShowFloatBtn ? floatingAB(_scrollController) : Container(),
    );
  }

  _buildFoot() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: backWhite,
          border: Border(top: BorderSide(color: lineColor, width: 1))),
      height: 50,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: double.infinity,
              child: Image.asset(
                'assets/images/pin_home.png',
                width: 25,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: double.infinity,
              child: Image.asset(
                'assets/images/kefu.png',
                width: 25,
              ),
            ),
            onTap: () {
              Routers.push(Routers.webView, context,
                  {'url': 'https://cs.you.163.com/client?k=$kefuKey'});
            },
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: textGrey, width: 1),
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '¥${_itemInfo.originPrice}',
                      style: t14blackBold,
                    ),
                    Text(
                      '单独购买',
                      style: t12black,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Routers.push(Routers.goodDetail, context, {'id': _itemId});
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: backRed),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '¥${_itemInfo.price}',
                      style: t14whiteBold,
                    ),
                    Text(
                      '发起拼团',
                      style: t12white,
                    ),
                  ],
                ),
              ),
              onTap: () {
                var itemInfo = SkuListItem();
                var skuList = _itemInfo.skuList;
                for (var item in skuList) {
                  if (_itemInfo.id == item.baseId) {
                    itemInfo = item;
                    break;
                  }
                }

                _pinTuanCheck(itemInfo);

                // Toast.show('暂未开发', context);
              },
            ),
          ),
        ],
      ),
    );
  }

  _pinTuanCheck(SkuListItem itemInfo) async {
    Map<String, dynamic> params = {
      'huoDongId': 0,
      'baseId': itemInfo.baseId,
      'skuId': itemInfo.skuId
    };
    var responseData = await pinTuanCheck(params);
    Routers.push(Routers.sendPinPage, context, {'skuItem': itemInfo});
  }

  _buildContent() {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverCustomHeaderDelegate(
            title: '拼团',
            collapsedHeight: 50,
            expandedHeight: MediaQuery.of(context).size.width,
            paddingTop: MediaQuery.of(context).padding.top,
            child: _buildSwiper(context),
          ),
        ),
        singleSliverWidget(PinTopWidget(itemInfo: _itemInfo)),
        singleSliverWidget(_titleWidget()),
        singleSliverWidget(_ruleWidget()),
        singleSliverWidget(_buildComment()),
        singleSliverWidget(Container(height: 10)),
        _recommonData(),

        ///详情title
        singleSliverWidget(_buildDetailTitle()),
        singleSliverWidget(GoodMaterialWidget(attrList: _detailModel.attrList)),

        ///商品详情
        singleSliverWidget(_buildGoodDetail()),
        singleSliverWidget(Container(height: 50)),
      ],
    );
  }

  _buildGoodDetail() {
    final imgWidget = _detailImages
        .map<Widget>((e) => GestureDetector(
              child: CachedNetworkImage(
                imageUrl: e,
                fit: BoxFit.cover,
              ),
              onTap: () {
                // Routers.push(Util.image, context, {'images': _detailImages});
              },
            ))
        .toList();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: imgWidget,
      ),
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  _buildDetailTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        '商品参数',
        style: t16black,
      ),
    );
  }

  _buildComment() {
    return GoodDetailCommentWidget(
      comments: _commentList,
      goodId: _itemId,
      commentCount: _commentCount,
    );
  }

  _buildSwiper(BuildContext context) {
    List<String> banner = [];
    var itemDetail = _detailModel.itemDetail;
    List<dynamic> bannerList = List<dynamic>.from(itemDetail.values);
    bannerList.forEach((image) {
      if (image.toString().startsWith('https://')) {
        banner.add(image);
      }
    });
    return Stack(
      children: [
        BannerCacheImg(
          height: MediaQuery.of(context).size.width,
          imageList: banner,
          onIndexChanged: (index) {
            setState(() {
              _bannerIndex = index;
            });
          },
          onTap: (index) {
            Routers.push(
                Routers.image, context, {'images': banner, 'page': index});
          },
        ),
        Positioned(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                color: Color(0x80FFFFFF),
                borderRadius: BorderRadius.circular(2)),
            child: Text(
              '$_bannerIndex/${banner.length}',
              style: t12black,
            ),
          ),
          right: 15,
          bottom: 10,
        ),
      ],
    );
  }

  _titleWidget() {
    return Container(
      color: backWhite,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: backRed,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_itemInfo.userNum}人团',
                    style: TextStyle(
                      color: textWhite,
                      height: 1.1,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${_itemInfo.joinUsers}人已拼',
                  style: t14red,
                )
              ],
            ),
          ),
          Text(
            '${_itemInfo.name}',
            style: t16blackbold,
          )
        ],
      ),
    );
  }

  _ruleWidget() {
    return RuleWidget();
  }

  _recommonData() {
    return SliverGrid.count(
      childAspectRatio: 0.67,
      crossAxisCount: 3,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      children: _commonList
          .map((item) => GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: backWhite, borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RoundNetImage(
                          width: double.infinity / 3 - 10,
                          height: double.infinity / 3 - 10,
                          url: item.picUrl,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          '${item.name}',
                          style: t14black,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Text(
                          '¥${item.price}',
                          style: t14red,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Routers.push(Routers.pinPage, context,
                      {'itemId': item.itemId, 'baseId': item.id});
                },
              ))
          .toList(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}
