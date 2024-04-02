import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/indicator_banner.dart';
import 'package:flutter_app/component/net_image.dart';
import 'package:flutter_app/component/sliver_refresh_indicator.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/component/home_page_header.dart';
import 'package:flutter_app/ui/home/components/gift_dialog.dart';
import 'package:flutter_app/ui/home/components/home_bottom_view.dart';
import 'package:flutter_app/ui/home/components/home_category_hot_items.dart';
import 'package:flutter_app/ui/home/components/home_category_hot_sell.dart';
import 'package:flutter_app/ui/home/components/home_flash_sale_item.dart';
import 'package:flutter_app/ui/home/components/home_new_comer_package.dart';
import 'package:flutter_app/ui/home/components/home_new_first_sell.dart';
import 'package:flutter_app/ui/home/model/categoryHotSellModule.dart';
import 'package:flutter_app/ui/home/model/flashSaleModule.dart';
import 'package:flutter_app/ui/home/model/flashSaleModuleItem.dart';
import 'package:flutter_app/ui/home/model/floorItem.dart';
import 'package:flutter_app/ui/home/model/focusItem.dart';
import 'package:flutter_app/ui/home/model/homeModel.dart';
import 'package:flutter_app/ui/home/model/indexActivityModule.dart';
import 'package:flutter_app/ui/home/model/kingKongModule.dart';
import 'package:flutter_app/ui/home/model/newItemModel.dart';
import 'package:flutter_app/ui/home/model/newUserGiftModel.dart';
import 'package:flutter_app/ui/home/model/policyDescItem.dart';
import 'package:flutter_app/ui/home/model/sceneLightShoppingGuideModule.dart';
import 'package:flutter_app/ui/home/model/versionFirModel.dart';
import 'package:flutter_app/ui/mine/check_info.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/eventbus_constans.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';
import 'package:flutter_app/utils/local_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final _scrollController = ScrollController();

  bool _isLoading = true;

  ///banner数据
  List<FocusItem> _focusList = [];

  ///banner下面tag
  List<PolicyDescItem> _policyDescList = [];

  ///kingkong
  List<KingKongItem> _kingKongList = [];

  ///活动大图
  List<FloorItem> _floorList = [];

  ///新人礼包
  List<IndexActivityModule> _indexActivityModule = [];

  ///类目热销榜
  CategoryHotSellModule? _categoryHotSellModule;

  ///限时购
  FlashSaleModule? _flashSaleModule;
  List<FlashSaleModuleItem> _flashSaleModuleItemList = [];

  ///新品首发
  List<NewItemModel> _newItemList = [];

  ///底部数据
  List<SceneLightShoppingGuideModule> _sceneLightShoppingGuideModule = [];

  //动画控制器
  late AnimationController _animalController;

  num _totalNum = 0;

  Color _backGroundColor = backWhite;

  bool _isFirst = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {});
    HosEventBusUtils.on((dynamic event) {
      if (event == REFRESH_CART) {
        _getData();
      }
    });
    _getData();
    _newUserGift();
    _checkVersion();
    _initAnimal();
    _totalNumbersOfProducts();
  }

  _totalNumbersOfProducts() async {
    var responseData = await totalNumbersOfProducts();
    if (responseData.code == '200') {
      setState(() {
        _totalNum = responseData.data ?? 0;
      });
      var sp = await LocalStorage.sp;
      sp!.setInt(LocalStorage.totalNum, responseData.data);
    }
  }

  void _incrementCounter() {
    _getData();
    _animalController.forward();
  }

  void _getData() async {
    if (_isFirst) {
      await homeData();
      _isFirst = false;
    }

    var responseData = await homeData();
    var data = responseData.data;
    if (data != null) {
      var homeModel = HomeModel.fromJson(data['data']);
      setData(homeModel);
      try {
        var sp = await LocalStorage.sp;
        var noticeList = data['noticeList'];
        if (noticeList != null && noticeList.isNotEmpty) {
          sp!.setString(LocalStorage.noticeList, json.encode(noticeList));
        } else {
          sp!.remove(LocalStorage.noticeList);
        }
      } catch (e) {}
    }
  }

  void setData(HomeModel homeModel) {
    setState(() {
      _focusList = homeModel.focusList ?? [];
      _policyDescList = homeModel.policyDescList ?? [];
      _kingKongList = homeModel.kingKongModule!.kingKongList ?? [];
      if (homeModel.bigPromotionModule != null) {
        _floorList = homeModel.bigPromotionModule!.floorList ?? [];
      } else {
        _floorList = [];
      }
      _indexActivityModule = homeModel.indexActivityModule ?? [];
      _categoryHotSellModule = homeModel.categoryHotSellModule;

      _flashSaleModule = homeModel.flashSaleModule;
      if (_flashSaleModule != null) {
        _flashSaleModuleItemList = _flashSaleModule!.itemList ?? [];
      }
      _newItemList = homeModel.newItemList ?? [];
      _sceneLightShoppingGuideModule =
          homeModel.sceneLightShoppingGuideModule ?? [];

      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: _backGroundColor,
      floatingActionButton:
          floatingABRefresh(context, _animalController, _incrementCounter),
      body: _isLoading ? _loadingView() : _contentBody(),
    );
  }

  _contentBody() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverRefreshIndicator(refresh: _getData),
        _appBar(),

        _buildSwiper(),
        _topTags(), //标签
        _kingkong(), //
        _bigPromotion(), //活动
        _newcomerPack(), //新人礼包
        _splitLine(),
        _categoryHotSell(), //类目热销榜
        _categoryHotSellItem(), //类目热销榜条目

        _normalTitle('限时购'), //限时购
        _flashSaleItem(), //限时购

        _normalTitle('新品首发'), //新品首发
        _newModelItem(), //新品首发条目

        _splitLine(),
        _bottomView(),
      ],
    );
  }

  _loadingView() {
    return Container(
      child: Image.asset('assets/images/home_loading.png'),
    );
  }

  _appBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: HomeHeader(
        showBack: false,
        title: '',
        totalNum: _totalNum,
        backGroundColor: _backGroundColor,
        collapsedHeight: 50,
        expandedHeight: 100 + MediaQuery.of(context).padding.top,
        paddingTop: MediaQuery.of(context).padding.top,
      ),
    );
  }

  _buildSwiper() {
    List<String> banner = [];
    for (var item in _focusList) {
      banner.add(item.picUrl ?? '');
    }
    return singleSliverWidget(
      IndicatorBanner(
          dataList: banner,
          fit: BoxFit.cover,
          height: 175,
          margin: EdgeInsets.symmetric(horizontal: 10),
          indicatorType: IndicatorType.line,
          onPress: (index) {
            Routers.push(
                Routers.webView, context, {'url': _focusList[index].targetUrl});
          }),
    );
  }

  _topTags() {
    return singleSliverWidget(
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _policyDescList
              .map((item) => Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          width: 20,
                          height: 20,
                          imageUrl: item.icon ?? '',
                        ),
                        Text(
                          '${item.desc}',
                          style: t12black,
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  ///  分类
  _kingkong() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, childAspectRatio: 1),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var kingKongItem = _kingKongList[index];
          Widget widget = GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: NetImage(
                        imageUrl: '${kingKongItem.picUrl ?? ""}',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 4),
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            '${kingKongItem.text ?? ''}',
                            style: t12black,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            onTap: () {
              print(kingKongItem.schemeUrl);
              Routers.push(Routers.kingKong, context,
                  {"schemeUrl": Uri.decodeFull("${Uri.decodeFull("${kingKongItem.schemeUrl}")}")});
            },
          );
          return widget;
        },
        childCount: _kingKongList.length,
      ),
    );
  }

  _bigPromotion() {
    return singleSliverWidget(Container(
      padding: EdgeInsets.only(bottom: 8),
      color: backColor,
      child: Column(
        children: _floorList
            .map(
              (item) => Container(
                width: double.infinity,
                child: _huoDong(item),
              ),
            )
            .toList(),
      ),
    ));
  }

  _huoDong(FloorItem item) {
    var cells = item.cells;
    var layout = item.layout;
    var itemHeight = item.height! / 2.7;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: layout == 5 ? 11 : 0),
      child: Row(
        children: cells!
            .map<Widget>(
              (e) => Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 2, right: 2, top: layout == 5 ? 6 : 0),
                    height: double.parse(itemHeight.toString()),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${e.picUrl ?? ''}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Row(
                      children: e.itemList!
                          .map<Widget>((ee) => Expanded(
                                flex: 1,
                                child: Container(
                                  height: itemHeight,
                                  alignment: Alignment.bottomCenter,
                                  child: CachedNetworkImage(
                                    height: itemHeight / 1.5,
                                    imageUrl: ee.picUrl ?? '',
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  onTap: () {
                    Routers.push(
                        Routers.webView, context, {'url': e.schemeUrl});
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  _splitLine() {
    return singleSliverWidget(Container(
      height: 10,
      color: Color(0xFFF5F5F5),
    ));
  }

  _newcomerPack() {
    return HomeNewComerPackage(indexActivityModule: _indexActivityModule);
  }

  _categoryHotSell() {
    return HomeCategoryHotSell(categoryHotSellModule: _categoryHotSellModule);
  }

  _categoryHotSellItem() {
    return HomeCategoryHotItems(categoryHotSellModule: _categoryHotSellModule);
  }

  _normalTitle(String title) {
    if (_flashSaleModule == null && title == '限时购') {
      return singleSliverWidget(Container());
    } else if (_newItemList.isEmpty && title == '新品首发') {
      return singleSliverWidget(Container());
    }
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: 10,
            color: Color(0xFFF5F5F5),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 12, 15, 4),
            alignment: Alignment.centerLeft,
            child: Text(
              '$title',
              style: t16black,
            ),
          ),
        ],
      ),
    );
  }

  _flashSaleItem() {
    return HomeFlashSaleItem(flashSaleModuleItemList: _flashSaleModuleItemList);
  }

  _newModelItem() {
    return HomeNewFirstSell(newItemList: _newItemList);
  }

  _bottomView() {
    return HomeBottomView(dataList: _sceneLightShoppingGuideModule);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    HosEventBusUtils.off();
    _scrollController.dispose();
    _animalController.dispose();
    super.dispose();
  }

  ///好物推荐
  List<ItemListItem> _rcmDataList = [];
  var _pagination;
  bool _hasMore = true;
  int _page = 1;
  int _size = 10;

  void _getRcmd() async {
    Map<String, dynamic> params = {
      "page": _page,
      "size": _size,
    };

    await rewardRcmd(params).then((responseData) {
      List result = responseData.data['result'];
      List<ItemListItem> dataList = [];

      result.forEach((element) {
        dataList.add(ItemListItem.fromJson(element));
      });

      setState(() {
        _rcmDataList.addAll(dataList);
        _pagination = responseData.data['pagination'];
        _hasMore = !_pagination['lastPage'];
        _page = _pagination['page'] + 1;
      });
    });
  }

  void _checkVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    var paramFir = {
      'api_token': '68c6b9bc36bc9cfd3572dd1c903cb176',
    };
    var responseData = await lastVersionFir(paramFir);
    try {
      var versionFirModel = VersionFirModel.fromJson(responseData.OData);
      if (packageInfo.version != versionFirModel.versionShort) {
        _versionDialog(versionFirModel);
      }
    } catch (e) {}
  }

  void _versionDialog(VersionFirModel versionModel) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AppVersionChecker(
            versionFirModel: versionModel,
          );
        });
  }

  _newUserGift() async {
    var responseData = await newUserGift();
    if (responseData.code == '200' && responseData.data != null) {
      var newUserGift = NewUserGift.fromJson(responseData.data);
      if (newUserGift.newUserGift != null) {
        showGiftDialog(context, newUserGift);
      }
    }
  }

  void _initAnimal() {
    _animalController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animalController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animalController.reset();
        //动画从 controller.forward() 正向执行 结束时会回调此方法
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
      } else if (status == AnimationStatus.forward) {
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
      }
    });
  }
}
