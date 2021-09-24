import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/component/count.dart';
import 'package:flutter_app/component/dashed_decoration.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/loading.dart';
import 'package:flutter_app/component/page_loading.dart';
import 'package:flutter_app/component/sliver_custom_header_delegate.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/globle/scrollState.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/goods_detail/components/brandInfo_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/coupon_item_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/coupon_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/delivery_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/detail_prom_banner_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/dialog.dart';
import 'package:flutter_app/ui/goods_detail/components/diaolog_title_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/freight_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/full_refund_policy_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/goodMaterialWidget.dart';
import 'package:flutter_app/ui/goods_detail/components/good_detail_banner.dart';
import 'package:flutter_app/ui/goods_detail/components/good_detail_comment_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/good_price_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/good_select_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/good_title.dart';
import 'package:flutter_app/ui/goods_detail/components/pro_vip_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/promotion_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/recommend_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/service_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/shopping_reward_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/skulimit_widget.dart';
import 'package:flutter_app/ui/goods_detail/model/commondPageModel.dart';
import 'package:flutter_app/ui/goods_detail/model/couponModel.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetailDownData.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetailPre.dart';
import 'package:flutter_app/ui/goods_detail/model/hdrkDetailVOListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/shoppingReward.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';
import 'package:flutter_app/ui/goods_detail/model/skuSpecListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/skuSpecValue.dart';
import 'package:flutter_app/ui/goods_detail/model/wapitemDeliveryModel.dart';
import 'package:flutter_app/ui/mine/model/locationItemModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopingcart/model/carItem.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/eventbus_constans.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';
import 'package:flutter_app/utils/renderBoxUtil.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';

const _toolbarHeight = 70.0;

class GoodsDetailPage extends StatefulWidget {
  final Map params;

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();

  GoodsDetailPage({this.params});
}

class _GoodsDetailPageState extends State<GoodsDetailPage>
    with TickerProviderStateMixin {
  ///红色选中边框
  var redBorder = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(3)),
    border: Border.all(width: 0.5, color: redColor),
  );

  ///黑色边框
  var blackBorder = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      border: Border.all(width: 0.5, color: textBlack));

  ///虚线边框
  var blackDashBorder = DashedDecoration(
    gap: 2,
    dashedColor: textLightGrey,
    borderRadius: BorderRadius.all(Radius.circular(3)),
  );

  final _scrollController = ScrollController();
  final _textEditingController = TextEditingController();

  ///--------------------------------------------------------------------------------------
  bool _initLoading = true;
  GoodDetailPre _goodDetailPre;

  ///视频
  VideoInfo _videoInfo;

  ///商品详情
  GoodDetail _goodDetail;

  ///下半部分数据
  GoodDetailDownData _goodDetailDownData;

  ///详情图片
  List<String> _detailImages = [];

  ///商品属性规格等
  List<SkuSpecListItem> _skuSpecList;

  ///规格集合
  Map<String, SkuMapValue> _skuMap;

  ///选择的规格
  SkuMapValue _skuMapItem;

  ///商品活动介绍
  String _promoTip = '';

  ///banner下面图片
  FeaturedSeries _featuredSeries;
  WelfareCardVO _welfareCardVO;

  ///推荐理由下面//促销
  List<HdrkDetailVOListItem> _hdrkDetailVOList;

  ///邮费
  SkuFreight _skuFreight;

  ///规则
  FullRefundPolicy _fullRefundPolicy;

  ///券活动/标签等
  List<String> _couponShortNameList = [];

  List<CouponModel> _couponList = [];

  ///商品数量
  int _goodCount = 1;

  ///商品价格（真实价格）
  String _price = '';

  ///banner下面活动
  DetailPromBanner _detailPromBanner;

  ///商品价格（原始价格）
  String _counterPrice = '';

  ///商品限制规则
  String _skuLimit;

  ///配送信息
  WapitemDeliveryModel _wapitemDeliveryModel;

  BrandInfo _brandInfo;

  ///底部推荐列表
  List<ItemListItem> _rmdList = [];

  ///banner
  List<String> _banner = [];

  num _goodId;

  ///skuMap key键值
  var _selectSkuMapKey = [];

  ///skuMap 描述信息
  var _selectSkuMapDec = [];
  var _selectStrDec = '';
  TabController _tabController;
  int _tabIndex = 0;

  final _scrollState = ValueNotifier<ScrollState>(ScrollState.shoppingCart);
  final _tabState = ValueNotifier<int>(0);

  final _commentKey = GlobalKey();
  final _detailKey = GlobalKey();
  final _RCMKey = GlobalKey();

  var _commentH = 0.0;
  var _detailH = 0.0;
  var _RCMKeyH = 0.0;

  final topTabs = ['商品', '评价', '详情', '推荐'];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _goodId = num.parse(widget.params['id'].toString());
    });
    super.initState();
    print(widget.params['id']);
    _getDetail();
    _getDetailPageUp();
    _getRMD();

    ///配送信息
    // _wapitemDelivery();

    _scrollController.addListener(_scrollerListener);

    _textEditingController.addListener(() {
      _textEditingController.text = _goodCount.toString();
    });

    _tabController =
        TabController(length: 2, vsync: this, initialIndex: _tabIndex);
  }

  void _scrollerListener() {
    if (_scrollController.position.pixels > 500) {
      if (_scrollState.value == ScrollState.shoppingCart) {
        _scrollState.value = ScrollState.toTop;
      }
    } else {
      if (_scrollState.value == ScrollState.toTop) {
        _scrollState.value = ScrollState.shoppingCart;
      }
    }
    var scrollY = _scrollController.position.pixels;
    if (scrollY < _commentH) {
      if (_tabState.value != 0) {
        _tabState.value = 0;
      }
      print('滑动到头部区域');
    } else if (scrollY >= _commentH && scrollY < _detailH) {
      if (_tabState.value != 1) {
        _tabState.value = 1;
      }
      print('滑动到评论区');
    } else if (scrollY >= _detailH && scrollY < _RCMKeyH) {
      if (_tabState.value != 2) {
        _tabState.value = 2;
      }

      print('滑动到详情区');
    } else if (scrollY >= _RCMKeyH) {
      if (_tabState.value != 3) {
        _tabState.value = 3;
      }
      print('滑动到推荐区');
    } else {}
  }

  void _getDetail() async {
    Map<String, dynamic> param = {'id': _goodId};
    var responseData = await goodDetailDownApi(param);
    var data = responseData.data;

    ///商品详情数据
    var goodDetailDownData = GoodDetailDownData.fromJson(data);
    var html = goodDetailDownData.html;
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
      _goodDetailDownData = goodDetailDownData;
      _detailImages = imageUrls;
    });
  }

  void _getLocations() async {
    var responseData = await getLocationList();
    if (responseData.code == '200' &&
        responseData.data != null &&
        responseData.data.isNotEmpty) {
      List data = responseData.data;
      List<LocationItemModel> dataList = [];
      data.forEach((element) {
        dataList.add(LocationItemModel.fromJson(element));
      });
      _wapitemDelivery(dataList[0]);
    }
  }

  _wapitemDelivery(LocationItemModel item) async {
    var params;
    if (item == null) {
      params = {
        'type': 1,
        'provinceId': 110000,
        'cityId': 110100,
        'districtId': 110105,
        'townId': 110105004000,
        'provinceName': '北京市',
        'cityName': '北京市',
        'districtName': '朝阳区',
        'townName': '三里屯街道',
        'address': '三里屯',
        'skuId': _skuMapItem.id,
      };
    } else {
      params = {
        'type': 1,
        'provinceId': item.provinceId,
        'cityId': item.cityId,
        'districtId': item.districtId,
        'townId': item.townId,
        'provinceName': item.provinceName,
        'cityName': item.cityName,
        'districtName': item.districtName,
        'townName': item.townName,
        'address': item.address,
        'skuId':
            _skuMapItem == null ? _goodDetail.primarySkuId : _skuMapItem.id,
      };
    }

    var responseData = await wapitemDelivery(params);
    if (responseData.code == '200') {
      setState(() {
        _wapitemDeliveryModel =
            WapitemDeliveryModel.fromJson(responseData.data);
      });
    }
    _calculateAfterLayout();
    Future.delayed(const Duration(milliseconds: 500), () {
      _calculateAfterLayout();
    });
  }

  void _calculateAfterLayout() {
    var top = MediaQuery.of(context).padding.top;
    setState(() {
      _commentH =
          RenderBoxUtil.offsetY(context, _commentKey) - _toolbarHeight - top;
      _detailH =
          RenderBoxUtil.offsetY(context, _detailKey) - _toolbarHeight - top;
      _RCMKeyH = RenderBoxUtil.offsetY(context, _RCMKey) - _toolbarHeight - top;
    });
  }

  void _getDetailPageUp() async {
    var param = {'id': _goodId};
    var response = await goodDetail(param);
    var oData = response.OData;

    setState(() {
      _goodDetailPre = GoodDetailPre.fromJson(oData);
      // _goodDetailPre = GoodDetailPre.fromJson(dataMap);

      _goodDetail = _goodDetailPre.item;
      _detailPromBanner = _goodDetail.detailPromBanner;
      _welfareCardVO = _goodDetail.welfareCardVO;
      _price = _goodDetail.retailPrice.toString();
      _counterPrice = _goodDetail.counterPrice.toString();
      _skuLimit = _goodDetail.itemLimit;
      _skuSpecList = _goodDetail.skuSpecList;

      _selectSkuMapKey = List.filled(_skuSpecList.length, '');
      _selectSkuMapDec = List.filled(_skuSpecList.length, '');
      _skuMap = _goodDetail.skuMap;
      _promoTip = _goodDetail.promoTip;
      _featuredSeries = _goodDetail.featuredSeries;
      _couponShortNameList = _goodDetail.couponShortNameList;
      _hdrkDetailVOList = _goodDetail.hdrkDetailVOList;

      _skuFreight = _goodDetail.skuFreight;

      _brandInfo = _goodDetail.brandInfo;

      _fullRefundPolicy = _goodDetail.fullRefundPolicy;

      var itemDetail = _goodDetail.itemDetail;
      _videoInfo = VideoInfo.fromJson(itemDetail['videoInfo']);
      List<dynamic> bannerList = List<dynamic>.from(itemDetail.values);
      bannerList.forEach((image) {
        if (image.toString().startsWith('https://')) {
          _banner.add(image);
        }
      });
      _initLoading = false;
      if (_couponShortNameList != null && _couponShortNameList.isNotEmpty) {
        _getCoupon();
      }
    });

    _getLocations();
  }

  void _getRMD() async {
    Map<String, dynamic> params = {'id': _goodId};
    var responseData = await wapitemRcmdApi(params);
    List item = responseData.data['items'];
    List<ItemListItem> rmdList = [];
    item.forEach((element) {
      rmdList.add(ItemListItem.fromJson(element));
    });
    setState(() {
      _rmdList = rmdList;
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
      backgroundColor: backColor,
      body: Stack(
        children: <Widget>[
          _buildContent(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: _buildFoot(1),
            ),
          ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: _scrollState,
          builder: (BuildContext context, ScrollState value, Widget child) {
            return _scrollState.value == ScrollState.toTop
                ? floatingAB(_scrollController)
                : floatingABCart(context);
          }),
    );
  }

  //内容
  _buildContent() {
    if (_initLoading) {
      return Loading();
    } else {
      return CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          _sliverHeader(),
          // banner底部活动
          singleSliverWidget(DetailPromBannerWidget(
            banner: _goodDetail.banner,
            price: _price,
            counterPrice: _counterPrice,
          )),
          singleSliverWidget(_buildActivity()),

          ///banner下面图片
          singleSliverWidget(_featuredSeriesWidget()),

          ///商品价格，showPrice字段控制
          singleSliverWidget(_promBanner()),

          ///pro会员
          singleSliverWidget(ProVipWidget(spmcBanner: _goodDetail.spmcBanner)),

          ///商品名称
          singleSliverWidget(GoodTitleWidget(
            name: _goodDetail.name,
            goodCmtRate: _goodDetail.goodCmtRate,
            goodId: _goodId,
          )),

          ///网易严选
          singleSliverWidget(_buildYanxuanTitle()),

          ///推荐理由
          singleSliverWidget(_buildOnlyText('推荐理由')),
          RecommendWidget(
            recommendReason: _goodDetail.recommendReason,
            simpleDesc: _goodDetail.simpleDesc,
          ),
          singleSliverWidget(Container(
            height: 15,
            color: Colors.white,
          )),

          ///活动卡
          singleSliverWidget(_buildWelfareCardVO()),

          ///选择属性
          singleSliverWidget(_buildSelectProperty()),

          ///addbanners
          singleSliverWidget(_addBanners()),

          ///用户评价
          singleSliverWidget(_buildComment()),

          ///_brandInfo
          singleSliverWidget(_brandInfoWidget()),

          ///甄选家测评
          // if (_tryOutEventReport != null) singleSliverWidget(_detailTab()),

          ///商品详情
          singleSliverWidget(_buildGoodDetail()),

          ///常见问题
          singleSliverWidget(_goodDetailDownData == null
              ? Container()
              : _buildIssueTitle(' 常见问题 ', null)),
          singleSliverWidget(_buildIssueList()),

          ///推荐
          singleSliverWidget(Container(key: _RCMKey)),
          singleSliverWidget(_buildIssueTitle(' 你可能还喜欢 ', null)),
          GoodItemWidget(dataList: _rmdList),
          singleSliverWidget(Container(height: 45)),
        ],
      );
    }
  }

  ValueListenableBuilder<int> _sliverHeader() {
    return ValueListenableBuilder(
        valueListenable: _tabState,
        builder: (BuildContext context, int value, Widget child) {
          return SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
                index: _tabState.value,
                // title:
                //     _initLoading ? 'loading...' : '${_goodDetail.name ?? ''}',
                collapsedHeight: _toolbarHeight,
                tabs: topTabs,
                expandedHeight: MediaQuery.of(context).size.width,
                paddingTop: MediaQuery.of(context).padding.top,
                child: _buildSwiper(context, _banner),
                onPress: (index) {
                  if (index == 0) {
                    _scrollT0(null, 0.0);
                  } else if (index == 1) {
                    _scrollT0(_commentKey, _commentH);
                  } else if (index == 2) {
                    _scrollT0(_detailKey, _detailH);
                  } else if (index == 3) {
                    _scrollT0(_RCMKey, _RCMKeyH);
                  }
                }),
          );
        });
  }

  _scrollT0(GlobalKey key, double dy) {
    // if (key == null) {
    //   _scrollController.animateTo(dy,
    //       duration: Duration(milliseconds: 1000), curve: Curves.ease);
    // } else {
    //   Scrollable.ensureVisible(key.currentContext);
    // }

    _scrollController.animateTo(dy,
        duration: Duration(milliseconds: 1000), curve: Curves.ease);
  }

  _promBanner() {
    if (_goodDetail.showPrice) {
      return GoodPriceWidget(
        detailPromBanner: _detailPromBanner,
        price: _price,
        counterPrice: _counterPrice,
      );
    }
    return Container();
  }

  double narbarHeight = 40;
  final tabs = ['商品详情', '甄选家评测'];

  _buildSwiper(BuildContext context, List imgList) {
    return GoodDetailBanner(
      imgList: imgList,
      videoInfo: _videoInfo,
    );
  }

  ///活动
  _buildWelfareCardVO() {
    return _welfareCardVO == null
        ? Container()
        : Container(
            decoration: BoxDecoration(color: Color(0xFFFFF0DD)),
            child: GestureDetector(
              child: CachedNetworkImage(
                imageUrl: _welfareCardVO.picUrl,
              ),
              onTap: () {
                Routers.push(Routers.webView, context,
                    {'url': _welfareCardVO.schemeUrl});
              },
            ),
          );
  }

  _buildActivity() {
    return _promoTip == null
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(color: Color(0xFFFFF0DD)),
            child: Text(
              _promoTip ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(color: Color(0xFFF48F57), fontSize: 12),
            ),
          );
  }

  _featuredSeriesWidget() {
    return _featuredSeries == null
        ? Container()
        : Container(
            child: GestureDetector(
            child: CachedNetworkImage(
              imageUrl: _featuredSeries.detailPicUrl,
            ),
            onTap: () {
              Routers.push(Routers.webView, context, {
                'url':
                    '${NetContants.baseUrl}featuredSeries/detail?id=${_featuredSeries.id}'
              });
            },
          ));
  }

  _buildSelectProperty() {
    ShoppingReward shoppingReward = _goodDetail.shoppingReward;
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          ///规则
          FullRefundPolicyWidget(
            fullRefundPolicy: _fullRefundPolicy,
            showDialog: () {
              fullRefundPolicyDialog(context, _fullRefundPolicy);
            },
          ),

          ///领券
          CouponWidget(
            couponShortNameList: _couponShortNameList,
            id: _goodId,
            onPress: () {
              _showCouponDialog();
            },
          ),

          ///邮费
          FreightWidget(
            skuFreight: _skuFreight,
            showDialog: () {
              var title = _skuFreight.title;
              List policyList = _skuFreight.policyList;
              _buildSkuFreightDialog(context, title, policyList);
            },
          ),

          ///促销
          PromotionWidget(
            hdrkDetailVOList: _hdrkDetailVOList,
            onPress: () {
              _showPromotionDialog();
            },
          ),

          ///购物反
          ShoppingRewardWidget(
            shoppingReward: shoppingReward,
            showDialog: () {
              var shoppingRewardRule = _goodDetail.shoppingRewardRule;
              _buildSkuFreightDialog(context, shoppingRewardRule.title,
                  shoppingRewardRule.ruleList);
            },
          ),

          Container(height: 10, color: backColor),

          ///选择属性
          GoodSelectWidget(
            skuMapItem: _skuMapItem,
            selectedStrDec: _selectStrDec,
            goodCount: _goodCount,
            onPress: () {
              _buildSizeModel(context);
            },
          ),

          ///限制
          SkulimitWidget(
            skuLimit: _skuLimit,
          ),

          ///配送
          DeliveryWidget(
            wapitemDelivery: _wapitemDeliveryModel,
            onPress: () {
              Routers.push(Routers.selectAddressPage, context, {}, (value) {
                _wapitemDelivery(value);
              });
            },
          ),

          ///服务
          ServiceWidget(
            policyList: _goodDetailPre.policyList,
            showDialog: () {
              List<PolicyListItem> policyList = _goodDetailPre.policyList;
              _buildSkuFreightDialog(context, '服务', policyList);
            },
          )
        ],
      ),
    );
  }

  _addBanners() {
    var adBanners = _goodDetail.adBanners;
    return adBanners == null || adBanners.isEmpty
        ? Container()
        : Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: backWhite),
            child: CarouselSlider(
              items: adBanners.map<Widget>((e) {
                return GestureDetector(
                  child: Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: CachedNetworkImage(
                      imageUrl: '${e.picUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Routers.push(
                        Routers.webView, context, {'url': e.targetUrl});
                  },
                );
              }).toList(),
              options: CarouselOptions(
                  height: 100,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  viewportFraction: 1.0,
                  // enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    // setState(() {});
                  }),
            ),
          );
  }

  _buildComment() {
    var commentCount = _goodDetailPre.commentCount;
    List<ResultItem> comments = _goodDetail.comments;
    var goodCmtRate = _goodDetail.goodCmtRate;
    return GoodDetailCommentWidget(
        key: _commentKey,
        commentCount: commentCount,
        comments: comments,
        goodCmtRate: goodCmtRate,
        goodId: _goodId);
  }

  _brandInfoWidget() {
    return BrandInfoWidget(
      brandInfo: _brandInfo,
      onPress: () {
        Routers.push(Routers.brandInfoPage, context,
            {'brandInfo': _brandInfo, 'id': _goodId});
      },
    );
  }

  _buildGoodDetail() {
    final List<Widget> imgWidget = [];
    final imgList = _detailImages.isEmpty
        ? List.filled(0, Container())
        : _detailImages
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
    imgWidget.add(_buildDetailTitle());
    imgWidget.add(_buildIntro());
    imgWidget.add(Container(height: 20));
    imgWidget.addAll(imgList);
    return Container(
      key: _detailKey,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: imgWidget,
      ),
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  ///成分
  _buildIntro() {
    List<AttrListItem> attrList = [];
    if (_goodDetailDownData != null) {
      attrList = _goodDetailDownData.attrList;
    }
    return GoodMaterialWidget(
      attrList: attrList,
    );
  }

  _buildDetailTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '商品参数',
        style: t16black,
      ),
    );
  }

  _buildIssueList() {
    var issueList = _goodDetailDownData.issueList;
    return _goodDetailDownData == null
        ? Container()
        : Column(
            children: issueList
                .map((item) => Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '• ${item.question}',
                              style: t14black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '${item.answer}',
                              style: t12grey,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList());
  }

  _buildIssueTitle(String title, GlobalKey key) {
    return Container(
      key: key,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _titleLine(),
          Text(
            title,
            style: TextStyle(
              color: textBlack,
              fontSize: 16,
              height: 1,
            ),
          ),
          _titleLine(),
        ],
      ),
    );
  }

  _titleLine() {
    return Container(
      width: 20,
      color: lineColor,
      height: 1,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollState.dispose();
    _tabState.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  _buildYanxuanTitle() {
    var simpleBrandInfo = _goodDetail.simpleBrandInfo;
    return simpleBrandInfo == null
        ? Container()
        : Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  height: 16,
                  imageUrl:
                      '${simpleBrandInfo.logoUrl ?? 'https://yanxuan.nosdn.127.net/9f91c012a7a42c776d785c09f6ed85b4.png'}',
                ),
                SizedBox(
                  width: 3,
                ),
                Text('${simpleBrandInfo.title ?? ''}',
                    style: TextStyle(color: Color(0xFF7F7F7F), fontSize: 14)),
              ],
            ),
          );
  }

  _buildOnlyText(String text) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        '$text',
        overflow: TextOverflow.ellipsis,
        style: t14black,
      ),
    );
  }

  ///属性选择底部弹窗
  _buildSizeModel(BuildContext context) {
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
                          Stack(
                            children: [
                              ///商品描述
                              _selectGoodDetail(context),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, right: 5),
                                    child: Image.asset(
                                      'assets/images/close.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///颜色，规格等参数
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
                              number: _goodCount,
                              min: 1,
                              max: _skuMapItem == null
                                  ? 1
                                  : _skuMapItem.sellVolume,
                              onChange: (index) {
                                setstate(() {
                                  _goodCount = index;
                                });
                                setState(() {
                                  _goodCount = index;
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
                    child: _buildFoot(0),
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
          SkuSpecListItem skuSpecItem = _skuSpecList[index];
          List<SkuSpecValue> skuSpecItemNameList = skuSpecItem.skuSpecValueList;
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(skuSpecItem.name),
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
        itemCount: _skuSpecList.length,
      ),
    );
  }

  _skuSpecItemNameList(BuildContext context, setstate,
      List<SkuSpecValue> skuSpecItemNameList, int index) {
    return skuSpecItemNameList.map((item) {
      var isModelSizeValue = _isModelSizeValue(index, item);
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.5),
          padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
          decoration: isModelSizeValue[0],
          child: Text(
            '${item.value}',
            style: isModelSizeValue[1],
            textAlign: TextAlign.center,
          ),
        ),
        onTap: () {
          ///弹窗内
          setstate(() {
            _selectModelDialogSize(context, index, item);
          });
          // setState(() {
          //   _selectModelDialogSize(context, index, item);
          // });
        },
      );
    }).toList();
  }

  _isModelSizeValue(int index, SkuSpecValue item) {
    List value = [blackBorder, t12black];

    if (_selectSkuMapKey.contains(item.id.toString())) {
      value[0] = redBorder;
      value[1] = t12red;
      return value;
    } else {
      bool isEmpty = true;
      for (var value in _selectSkuMapKey) {
        if (value != '') {
          isEmpty = false;
          break;
        }
      }

      if (_selectSkuMapKey.length > 1 && isEmpty) {
        value[0] = blackBorder;
        value[1] = t12black;
        return value;
      }

      bool isAllselect = true;
      for (var value in _selectSkuMapKey) {
        if (value == '') {
          isAllselect = false;
          break;
        }
      }

      if (isAllselect) {
        return _allSelect(value, index, item);
      } else {
        if (_selectSkuMapKey.length == 2) {
          if (_selectSkuMapKey[index] != '') {
            value[0] = blackBorder;
            value[1] = t12black;
            return value;
          } else {
            return _allSelect(value, index, item);
          }
        } else {
          return _allSelect(value, index, item);
        }
      }
    }
  }

  _allSelect(List value, int index, SkuSpecValue item) {
    value[0] = _modelSizeDe(index, item);
    value[1] = _modelSizeTextSty(index, item);
    return value;
  }

  _modelSizeDe(int index, SkuSpecValue item) {
    if (_modelSizeValue(index, item)) {
      return blackBorder;
    } else {
      return blackDashBorder;
    }
  }

  _modelSizeTextSty(int index, SkuSpecValue item) {
    if (_modelSizeValue(index, item)) {
      return t12black;
    } else {
      return t12lightGrey;
    }
  }

  _modelSizeValue(int index, SkuSpecValue item) {
    var selectSkuMapKey = List.filled(_selectSkuMapKey.length, '');
    for (var i = 0; i < _selectSkuMapKey.length; i++) {
      selectSkuMapKey[i] = _selectSkuMapKey[i];
    }
    selectSkuMapKey[index] = item.id.toString();
    var keys = _skuMap.keys;
    bool isMatch = false;

    var isValue = false;
    for (var element in keys) {
      var split = element.split(';');
      for (var spitElement in selectSkuMapKey) {
        if (spitElement == null || spitElement == '') {
          isMatch = true;
        } else {
          if (split.indexOf(spitElement) == -1) {
            isMatch = false;
            break;
          } else {
            isMatch = true;
          }
        }
      }
      if (isMatch) {
        SkuMapValue skuMapItem = _skuMap['$element'];
        if (skuMapItem.sellVolume != 0) {
          isValue = true;
          break;
        } else {
          isValue = false;
          break;
        }
      } else {
        isValue = false;
      }
    }
    return isValue;
  }

  ///选择属性，查询skuMap
  void _selectModelDialogSize(
      BuildContext context, int index, SkuSpecValue item) {
    if (_selectSkuMapKey[index] == item.id.toString()) {
      _selectSkuMapKey[index] = '';
      _selectSkuMapDec[index] = '';
    } else {
      _selectSkuMapKey[index] = item.id.toString();
      _selectSkuMapDec[index] = item.value;
    }

    ///被选择的skuMap
    String skuMapKey = '';
    _selectSkuMapKey.forEach((element) {
      skuMapKey += ';$element';
    });

    skuMapKey = skuMapKey.replaceFirst(';', '');
    SkuMapValue skuMapItem = _skuMap['$skuMapKey'];

    ///描述信息
    String selectStrDec = '';
    _selectSkuMapDec.forEach((element) {
      selectStrDec += '$element ';
    });
    _selectStrDec = selectStrDec;
    _skuMapItem = skuMapItem;
    if (_skuMapItem == null) {
      ///顺序不同，导致选择失败
      var keys = _skuMap.keys;
      for (var element in keys) {
        var split = element.split(';');
        bool isMatch = false;
        for (var spitElement in split) {
          if (_selectSkuMapKey.indexOf(spitElement) == -1) {
            isMatch = false;
            break;
          } else {
            isMatch = true;
          }
        }
        if (isMatch) {
          _skuMapItem = _skuMap['$element'];
          break;
        }
      }
    }

    if (_skuMapItem != null) {
      _price = _skuMapItem.retailPrice.toString();
      _counterPrice = _skuMapItem.counterPrice.toString();

      setState(() {
        _price = _skuMapItem.retailPrice.toString();
        _counterPrice = _skuMapItem.counterPrice.toString();
      });
    }
  }

  _selectGoodDetail(BuildContext context) {
    String img = (_skuMapItem == null || _skuMapItem.pic == null)
        ? _goodDetail.primaryPicUrl
        : _skuMapItem.pic;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(top: 8),
              child: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
              ),
              height: 100,
              width: 100,
            ),
            onTap: () {
              Routers.push(Routers.image, context, {
                'images': [img]
              });
            },
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _skuMapItem == null ||
                        _skuMapItem.promotionDesc == null ||
                        _skuMapItem.promotionDesc == ''
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFEF7C15)),
                        child: Text(
                          '${_skuMapItem.promotionDesc ?? ''}',
                          style: t12white,
                        ),
                      ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "价格：",
                        style: t14red,
                      ),
                      Text(
                        '￥$_price',
                        overflow: TextOverflow.ellipsis,
                        style: t14red,
                      ),
                      _price == _counterPrice
                          ? Container()
                          : Container(
                              child: Text(
                                '￥$_counterPrice',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textGrey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                // 商品描述
                Container(
                  child: Text(
                    '已选择：$_selectStrDec',
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

  ///------------------------------------------领券弹窗------------------------------------------
  _getCoupon() async {
    Map<String, dynamic> params = {
      'itemId': _goodId,
      'skuId': _goodDetail.primarySkuId,
    };
    var responseData = await queryByItemAndUser(params);
    if (responseData.code == '200') {
      List data = responseData.data;
      List<CouponModel> couponList = [];
      data.forEach((element) {
        couponList.add(CouponModel.fromJson(element));
      });
      setState(() {
        _couponList = couponList;
      });
    }
  }

  _showCouponDialog() {
    List<CouponModel> couponList = _couponList;
    print(_couponList);
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(maxHeight: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(5.0),
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DialogTitleWidget(title: '领券'),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: couponList
                      .map(
                        (item) => Container(
                          child: _buildCouponItem(item),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildCouponItem(CouponModel item) {
    return CouponItemWidget(
      couponItem: item,
      receiveClick: (albeToActivated) {
        if (albeToActivated) {
          ///领券
          _getItemCoupon(item);
        } else {
          ///已领取，去凑单
          Routers.push(Routers.makeUpPage, context,
              {'from': Routers.goodDetail, 'id': -1});
        }
      },
    );
  }

  _getItemCoupon(CouponModel item) async {
    Map<String, dynamic> params = {'token': item.activationCode};
    var responseData = await getItemCoupon(params);
    if (responseData.code == '200') {
      Toast.show('领取成功', context);
      setState(() {
        item.albeToActivated = false;
      });
      _getCoupon();
    }
  }

  ///------------------------------------------促销弹窗------------------------------------------
  _showPromotionDialog() {
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(maxHeight: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(5.0),
            ),
          ),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DialogTitleWidget(title: '${_hdrkDetailVOList.length}个促销'),
                DetailCuxiaoItems(
                  hdrkDetailVOList: _hdrkDetailVOList,
                  itemClick: (item) {
                    if (item.huodongUrlWap.contains('cart/itemPool')) {
                      _getMakeUpCartInfo(item);
                      //
                      // Routers.push(Routers.makeUpPage, context,
                      //     {'id': item.id, 'from': 'cart-item'});
                    } else {
                      String url = '';
                      if (item.huodongUrlWap.startsWith('http')) {
                        url = item.huodongUrlWap;
                      } else {
                        url = '${NetContants.baseUrl_}${item.huodongUrlWap}';
                      }
                      Routers.push(Routers.webView, context, {'url': url});
                    }
                  },
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _getMakeUpCartInfo(HdrkDetailVOListItem item) async {
    Map<String, dynamic> params = {
      'promotionId': item.canUseCoupon ? -1 : item.id,
    };
    var responseData = await getMakeUpCartInfo(params, showProgress: true);
    if (responseData.code == '200') {
      var makeUpCartInfoModel = CarItem.fromJson(responseData.data);
      if (item.huodongUrlWap.contains('giftView')) {
        Routers.push(Routers.getCarsPage, context, {
          'data': makeUpCartInfoModel,
          'from': Routers.goodDetail,
          'promotionId': item.canUseCoupon ? -1 : item.id
        });
      } else {
        Routers.push(Routers.makeUpPage, context, {
          'data': makeUpCartInfoModel,
          'from': Routers.goodDetail,
          'id': item.canUseCoupon ? -1 : item.id
        });
      }
    }
  }

  ///------------------------------------------邮费-购物反-服务综合弹窗------------------------------------------
  _buildSkuFreightDialog(
      BuildContext context, String title, List<PolicyListItem> contentList) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(maxHeight: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(5.0),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              DialogTitleWidget(title: '$title'),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: contentList
                      .map<Widget>((item) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(
                                  item.title,
                                  style: t14black,
                                ),
                              ),
                              Container(
                                child: Text(
                                  item.content,
                                  style: t14grey,
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),
              ))
            ],
          ),
        );
      },
    );
  }

  ///------------------------------------------底部按钮------------------------------------------------------------------------------------------------------
  ///底部展示
  Widget _buildFoot(int type) {
    if (_skuMapItem == null) {
      return _defaultBottomBtns(type);
    } else {
      int sellVolume = _skuMapItem.sellVolume;
      int purchaseAttribute = _skuMapItem.purchaseAttribute;
      if (sellVolume > 0) {
        return _activityBtns(purchaseAttribute, type);
      } else {
        return _noGoodsSell();
      }
    }
  }

  ///默认展示形式
  _defaultBottomBtns(int type) {
    return Container(
      height: 45,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          //客服
          _kefuWidget(),
          _buyButton(0, type),
          _putCarShop(0, type)
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: lineColor, blurRadius: 1, spreadRadius: 0.2)
      ]),
    );
  }

  _activityBtns(int purchaseAttribute, int type) {
    return Container(
      height: 45,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          //客服
          _kefuWidget(),
          _buyButton(purchaseAttribute, type),
          _putCarShop(purchaseAttribute, type)
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
        Routers.push(Routers.webView, context,
            {'url': 'https://cs.you.163.com/client?k=$kefuKey'});
      },
    );
  }

  _buyButton(int purchaseAttribute, int type) {
    String text = '立即购买';
    if (_skuMapItem != null &&
        _skuMapItem.buyTitle != null &&
        purchaseAttribute == 1) {
      var buyTitle = _skuMapItem.buyTitle;
      text = '${buyTitle.title}${buyTitle.subTitle}';
    }
    return Expanded(
      flex: 1,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            border: Border(left: BorderSide(color: lineColor, width: 1))),
        child: FlatButton(
          onPressed: () {
            if (_skuMapItem == null) {
              if (type == 1) {
                _buildSizeModel(context);
              } else {
                Toast.show('请选择参数规格', context);
              }
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

  _putCarShop(int purchaseAttribute, int type) {
    return purchaseAttribute == 1
        ? Container()
        : Expanded(
            flex: 1,
            child: Container(
              height: 45,
              child: FlatButton(
                onPressed: () {
                  _selectSkuMapKey.forEach((element) {
                    if (element == '') {
                      var indexOf = _selectSkuMapKey.indexOf(element);
                      var name = _skuSpecList[indexOf].name;
                      Toast.show('请选择$name', context);
                      return;
                    }
                  });
                  if (_skuMapItem == null) {
                    if (type == 1) {
                      _buildSizeModel(context);
                    }
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
    Map<String, dynamic> params = {"cnt": _goodCount, "skuId": _skuMapItem.id};
    await addCart(params).then((value) {
      Toast.show('添加成功', context);
      HosEventBusUtils.fire(REFRESH_CART_NUM);
      // _getDetailPageUp();
    });
  }

  ///购买
  void _buyGoods() {
    Toast.show('暂未开发', context);
    return;
    // List cartItemList = [];
    // Map<String, dynamic> cartItem = {
    //   'uniqueKey': null,
    //   'skuId': _skuMapItem['itemSkuSpecValueList'][0]['skuId'],
    //   'count': _goodCount,
    //   'source': 0,
    //   'sources': [],
    //   'isPreSell': false,
    //   'extId': "{\"proDiscountExtId\":\"1\",\"cartExtId\":\"0\"}",
    //   'type': 0,
    //   'cartDepositVO': null,
    //   'services': [],
    //   'checkExt': "{\"firstOrderRefundExtId\":\"true\"}",
    // };
    // cartItemList.add(cartItem);
    //
    // Map<String, dynamic> goodItems = {
    //   'promId': _skuMapItem['promId'],
    //   'promSatisfy': false,
    //   'giftItemList': null,
    //   'addBuyItemList': null,
    //   'cartItemList': cartItemList,
    // };
    //
    // Routers.push(Util.orderInit, context, goodItems);
  }
}
