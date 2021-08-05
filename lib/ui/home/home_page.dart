import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/home/components/gift_dialog.dart';
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
import 'package:flutter_app/ui/home/model/versionModel.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/widget/floating_action_button.dart';
import 'package:flutter_app/widget/home_page_header.dart';
import 'package:flutter_app/widget/round_net_image.dart';
import 'package:flutter_app/widget/sliver_refresh_indicator.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();

  bool _isLoading = true;

  ///banner数据
  List<FocusItem> _focusList;

  ///banner下面tag
  List<PolicyDescItem> _policyDescList;

  ///kingkong
  List<KingKongItem> _kingKongList;

  ///活动大图
  List<FloorItem> _floorList;

  ///新人礼包
  List<IndexActivityModule> _indexActivityModule;

  ///类目热销榜
  CategoryHotSellModule _categoryHotSellModule;

  List<Category> _categoryList;

  ///限时购
  FlashSaleModule _flashSaleModule;
  List<FlashSaleModuleItem> _flashSaleModuleItemList;

  ///新品首发
  List<NewItemModel> _newItemList;

  ///底部数据
  List<SceneLightShoppingGuideModule> _sceneLightShoppingGuideModule;

  var toolbarHeight = 0;

  //动画控制器
  AnimationController _animalController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 110) {
        // 如果下拉的当前位置到scroll的最下面
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (_hasMore) {}
        }
      } else {}
    });
    _getData();
    // _checkLogin();
    _newUserGift();
    _checkVersion();
    _initAnimal();
  }

  void _incrementCounter() {
    _getData();
    _animalController.forward();
  }

  void _getData() async {
    var responseData = await homeData();
    var data = responseData.data;
    if (data != null) {
      var homeModel = HomeModel.fromJson(data['data']);
      setData(homeModel);
    }
  }

  void setData(HomeModel homeModel) {
    setState(() {
      _focusList = homeModel.focusList;
      _policyDescList = homeModel.policyDescList;
      _kingKongList = homeModel.kingKongModule.kingKongList;
      if (homeModel.bigPromotionModule != null) {
        _floorList = homeModel.bigPromotionModule.floorList;
      } else {
        _floorList = [];
      }
      _indexActivityModule = homeModel.indexActivityModule;
      _categoryHotSellModule = homeModel.categoryHotSellModule;
      if (_categoryHotSellModule != null) {
        _categoryList = _categoryHotSellModule.categoryList;
      }
      _flashSaleModule = homeModel.flashSaleModule;
      if (_flashSaleModule != null) {
        _flashSaleModuleItemList = _flashSaleModule.itemList;
      }
      _newItemList = homeModel.newItemList;
      _sceneLightShoppingGuideModule = homeModel.sceneLightShoppingGuideModule;

      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton:
          floatingABRefresh(context, _animalController, _incrementCounter),
      body: _isLoading ? _loadingView() : _contentBody(),
    );
  }

  _refresh() {
    return RefreshIndicator(
        child: _contentBody(),
        onRefresh: () async {
          _getData();
        });
  }

  _contentBody() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverRefreshIndicator(
          refresh: _getData,
        ),
        _appBar(),

        _buildSwiper(),
        _topTags(context), //标签
        _kingkong(context), //
        _bigPromotion(context), //活动
        _splitLine(),
        _newcomerPack(context), //新人礼包
        _splitLine(),
        _categoryHotSell(context), //类目热销榜
        _categoryHotSellItem(context), //类目热销榜条目

        _normalTitle(context, '限时购'), //限时购
        _flashSaleItem(context), //类目热销榜条目

        _normalTitle(context, '新品首发'), //新品首发
        _newModulItem(context), //新品首发条目

        _splitLine(),
        _bottomView(context),
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
        collapsedHeight: 50,
        expandedHeight: 100 + MediaQuery.of(context).padding.top,
        paddingTop: MediaQuery.of(context).padding.top,
      ),
    );
  }

  _buildSwiper() {
    return singleSliverWidget(
      Container(
        height: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: backWhite),
        child: CarouselSlider(
          items: _focusList.map<Widget>((e) {
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: backWhite),
                child: RoundNetImage(
                  url: e.picUrl,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Routers.push(Routers.webView, context, {'url': e.targetUrl});
              },
            );
          }).toList(),
          options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              viewportFraction: 1.0,
              // enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                // setState(() {});
              }),
        ),
      ),
    );
  }

  _topTags(BuildContext context) {
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
                          imageUrl: item.icon,
                        ),
                        Text(
                          item.desc,
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
  _kingkong(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, childAspectRatio: 1),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Widget widget = Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.white),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: CachedNetworkImage(
                      imageUrl: _kingKongList[index].picUrl ?? "",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: 4,
                      ),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          _kingKongList[index].text ?? "",
                          style: t12black,
                        ),
                      ),
                    )),
              ],
            ),
          );
          return Routers.link(widget, Routers.kingKong, context,
              {"schemeUrl": _kingKongList[index].schemeUrl});
        },
        childCount: _kingKongList == null ? 0 : _kingKongList.length,
      ),
    );
  }

  _bigPromotion(BuildContext context) {
    return singleSliverWidget(Column(
      children: _floorList
          .map(
            (item) => Container(
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: 180),
              margin: EdgeInsets.symmetric(vertical: 2),
              child: _huoDong(item),
            ),
          )
          .toList(),
    ));
  }

  _huoDong(FloorItem item) {
    if (item.cells != null && item.cells.length > 1) {
      return Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: 170),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: item.cells.map((e) {
            return Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: item.cells.length > 1 ? e.picUrl : e.picUrl,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Routers.push(
                        Routers.webView, context, {'url': e.schemeUrl});
                  },
                ),
              ),
            );
          }).toList(),
        ),
      );
    } else if (item.cells != null && item.cells.isNotEmpty) {
      return Container(
        width: double.infinity,
        child: GestureDetector(
          child: CachedNetworkImage(
            imageUrl: item.cells[0].picUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Routers.push(
                Routers.webView, context, {'url': item.cells[0].schemeUrl});
          },
        ),
      );
    } else {
      return Container();
    }
  }

  _splitLine() {
    return singleSliverWidget(Container(
      height: 10,
      color: Color(0xFFF5F5F5),
    ));
  }

  _newcomerPack(BuildContext context) {
    return singleSliverWidget(Column(children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "- 新人专享礼包 -",
                style: t14black,
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 200,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 3),
                    color: Color(0xFFF6E5C4),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 60, 20, 20),
                          height: 197,
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "http://yanxuan.nosdn.127.net/352b0ea9b2d058094956efde167ef852.png"),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            '新人专享礼包',
                            style: t14blackBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _goWebview(
                        'https://act.you.163.com/act/pub/qAU4P437asfF.html');
                  },
                )),
            Container(
              width: 3,
              color: Colors.white,
            ),
            Expanded(
              flex: 1,
              child: Container(
                  height: 200,
                  child: Column(
                      children: _indexActivityModule.map((item) {
                    return GestureDetector(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity / 2,
                            height: 97,
                            color: Color(0xFFF9DCC9),
                            margin: EdgeInsets.only(top: 3),
                            child: CachedNetworkImage(
                              alignment: Alignment.bottomRight,
                              fit: BoxFit.fitHeight,
                              imageUrl: item.showPicUrl,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: t14blackBold,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    item.subTitle == ""
                                        ? item.tag
                                        : item.subTitle,
                                    style: t12grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (item.targetUrl.contains('pin/item/list')) {
                          Routers.push(Routers.mineItems, context, {'id': 2});
                        } else {
                          _goWebview(item.targetUrl);
                        }
                      },
                    );
                  }).toList())),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]));
  }

  _categoryHotSell(BuildContext context) {
    if (_categoryHotSellModule == null) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 7, 15, 0),
      sliver: singleSliverWidget(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 12, 12),
              child: Text(
                _categoryHotSellModule.title,
                style: t14black,
              ),
            ),
            Container(
              child: Row(
                children: [
                  _hotTopCell(0),
                  SizedBox(
                    width: 5,
                  ),
                  _hotTopCell(1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _hotTopCell(int index) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          _goHotList(index, context);
        },
        child: Container(
          color: index == 0 ? Color(0xFFF7F1DD) : Color(0xFFE4E8F0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _categoryList[index].categoryName,
                      style: t12blackbold,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 2,
                      width: 30,
                      color: Colors.black,
                    )
                  ],
                ),
                flex: 2,
              ),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: _categoryList[index].picUrl,
                ),
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _categoryHotSellItem(BuildContext context) {
    if (_categoryHotSellModule == null) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _goHotList(index, context);
              },
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 4,
                        ),
                        color: Color(0xFFF2F2F2),
                        child: Center(
                          child: Text(
                            _categoryList[index].categoryName,
                            style: TextStyle(
                                color: textBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: Color(0xFFF2F2F2),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: _categoryList[index].picUrl,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )),
                ],
              ),
            );
          },
          childCount: _categoryList.length > 8 ? 8 : _categoryList.length,
        ),
      ),
    );
  }

  void _goHotList(int index, BuildContext context) {
    String categoryId = '0';
    var categoryList = _categoryList[index];
    var targetUrl = categoryList.targetUrl;
    if (categoryList.targetUrl != null &&
        categoryList.targetUrl.contains('categoryId=')) {
      var split = targetUrl.split("categoryId=");
      if (split != null && split.isNotEmpty && split.length > 1) {
        categoryId = split[1];
      }
    }
    Routers.push(Routers.hotList, context,
        {'categoryId': categoryId, 'name': categoryList.categoryName});
  }

  _normalTitle(BuildContext context, String title) {
    if (_flashSaleModule == null && title == '限时购') {
      return singleSliverWidget(Container());
    } else if ((_newItemList == null || _newItemList.isEmpty) &&
        title == '新品首发') {
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
              "$title",
              style: t14black,
            ),
          ),
        ],
      ),
    );
  }

  _flashSaleItem(BuildContext context) {
    if (_flashSaleModuleItemList == null || _flashSaleModuleItemList.isEmpty) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.8),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            Widget widget = Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: _flashSaleModuleItemList[index].picUrl,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "¥${_flashSaleModuleItemList[index].activityPrice}",
                        style: t14red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "¥${_flashSaleModuleItemList[index].originPrice}",
                        style: TextStyle(
                          fontSize: 12,
                          color: textGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
            return Routers.link(widget, Routers.goodDetailTag, context,
                {'id': _flashSaleModuleItemList[index].itemId});
          },
          childCount: _flashSaleModuleItemList.length,
        ),
      ),
    );
  }

  _newModulItem(BuildContext context) {
    if (_newItemList == null || _newItemList.isEmpty) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.58),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              var item = _newItemList[index];
              Widget widget = Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: CachedNetworkImage(
                          height: 210,
                          imageUrl: item.scenePicUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "${item.simpleDesc}",
                        style: t12black,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "¥${item.retailPrice}",
                      style: t14red,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      constraints: BoxConstraints(minHeight: 18),
                      child: _newItemsTags(item),
                    )
                  ],
                ),
              );
              return Routers.link(
                  widget, Routers.goodDetailTag, context, {'id': item.id});
            },
            childCount: _newItemList.length > 6 ? 6 : _newItemList.length,
          ),
        ));
  }

  _newItemsTags(NewItemModel item) {
    var itemTagList = item.itemTagList;
    if (itemTagList != null && itemTagList.length > 1) {
      var itemD = itemTagList[itemTagList.length - 1];
      return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(width: 0.5, color: redColor)),
        child: Text(
          itemD.name,
          style: t12red,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      return Container();
    }
  }

  _bottomView(BuildContext context) {
    if (_sceneLightShoppingGuideModule == null ||
        _sceneLightShoppingGuideModule.isEmpty) {
      return singleSliverWidget(Container());
    }

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(10, 15, 15, 15),
      sliver: singleSliverWidget(Row(
        children: _sceneLightShoppingGuideModule.map((item) {
          Widget widget = Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                _goWebview(item.styleItem.targetUrl);
              },
              child: Container(
                color: Color(0xFFF2F2F2),
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.styleItem.title,
                            style: t14blackBold,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            item.styleItem.desc,
                            style: t12warmingRed,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Row(
                        children: [
                          Expanded(
                              child: CachedNetworkImage(
                            imageUrl: item.styleItem.picUrlList[0] ?? '',
                          )),
                          Expanded(
                              child: CachedNetworkImage(
                            imageUrl: item.styleItem.picUrlList[1] ?? '',
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
          return widget;
        }).toList(),
      )),
    );
  }

  _goWebview(String url) {
    Routers.push(Routers.webView, context, {'url': url});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _animalController.dispose();
    super.dispose();
  }

  ///好物推荐
  _buildRCM(BuildContext context) {}
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
    var param = {
      '_api_key': pgy_api_key,
      'buildVersion': packageInfo.version,
      'appKey': pgy_appKey,
    };

    var responseData = await checkVersion(param);
    if (responseData.code == 0) {
      var data = responseData.data;
      var versionModel = VersionModel.fromJson(data);
      if (packageInfo.version != versionModel.buildVersion) {
        _versionDialog(versionModel);
      }
    }
  }

  void _versionDialog(VersionModel versionModel) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${versionModel.buildName}'),
            content: Text('有新版本更新，是否更新?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消', style: t14grey),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  if (Platform.isAndroid) {
                    _launchURL(versionModel.downloadURL);
                  }
                },
                child: Text('确定', style: t14red),
              ),
            ],
          );
        });
  }

  _launchURL(apkUrl) async {
    if (await canLaunch(apkUrl)) {
      await launch(apkUrl);
    } else {
      throw 'Could not launch $apkUrl';
    }
  }

  _newUserGift() async {
    var responseData = await newUserGift();
    if (responseData.code == '200') {
      var newUserGift = NewUserGift.fromJson(responseData.data);
      if (newUserGift != null && newUserGift.newUserGift != null) {
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
