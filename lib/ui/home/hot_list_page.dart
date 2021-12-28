import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/home/components/cart_tablayout.dart';
import 'package:flutter_app/ui/home/components/hot_list_item.dart';
import 'package:flutter_app/ui/sort/model/currentCategory.dart';
import 'package:flutter_app/ui/sort/model/hotListModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/ui/home/components/verical_text_scoller.dart';

class HotListPage extends StatefulWidget {
  final Map? param;

  const HotListPage({Key? key, this.param}) : super(key: key);

  @override
  _HotListPageState createState() => _HotListPageState();
}

class _HotListPageState extends State<HotListPage>
    with TickerProviderStateMixin {
  final _streamController = StreamController<bool>.broadcast();

  final _scrollController = ScrollController();

  String _currentCategoryId = '0';

  late TabController _tabController;
  bool _isFirstLoading = true;
  int pageSize = 10;

  String _bannerUrl =
      "https://yanxuan.nosdn.127.net/294b914321c27e2490b257b5b6be6fa5.png";

  late Timer _timer;
  int _randomIndex = 0;

  String? _categoryId = '0';

  ///头部
  List<CurrentCategory> _subCateList = [];
  List<CurrentCategory> _moreCategories = [];

  ///数据
  List<ItemListItem> _dataList = [];

  List<dynamic>? _seller = [];

  @override
  void initState() {
    setState(() {
      _tabController = TabController(length: _subCateList.length, vsync: this);
      _categoryId = widget.param!['categoryId'];
    });
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        _randomIndex++;
        if (_randomIndex >= 18) {
          _randomIndex = 0;
        }
      });
    });
    _scrollController.addListener(_scrollListener);
    _getData();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels > 140) {
      _streamController.sink.add(true);
    } else {
      _streamController.sink.add(false);
    }
  }

  void _getData() async {
    _getCat();
    _getItemList(false);
    _submitOrderInfo();
  }

  _submitOrderInfo() async {
    var responseData = await submitOrderInfo();
    if (mounted) {
      if (responseData.code == '200') {
        setState(() {
          _seller = responseData.data;
        });
      }
    }
  }

  _getCat() async {
    Map<String, dynamic> params = {
      "categoryId": _categoryId,
      "subCategoryId": 0
    };

    var responseData = await hotListCat(params);
    if (mounted) {
      var oData = responseData.OData;
      var hotListModel = HotListModel.fromJson(oData);

      ///tab列表
      List<CurrentCategory> cateList = [];
      var currentCategory = hotListModel.currentCategory!;
      currentCategory.name = '全部';
      var subCateList = currentCategory.subCateList!;
      cateList.add(currentCategory);
      cateList.addAll(subCateList);
      setState(() {
        _moreCategories = hotListModel.moreCategories ?? [];
        _subCateList = cateList;
        _tabController =
            TabController(length: _subCateList.length, vsync: this);
        _isFirstLoading = false;
        _bannerUrl = currentCategory.bannerUrl!;
      });
      _tabController.addListener(() {
        setState(() {
          if (_tabController.index == _tabController.animation!.value) {
            _currentCategoryId =
                _subCateList[_tabController.index].id.toString();
            _getItemList(true);
          }
        });
      });
    }
  }

  ///列表数据
  _getItemList(bool showLoading) async {
    Map<String, dynamic> params = {
      "categoryId": _categoryId,
      "subCategoryId": _currentCategoryId,
      "userBusId": '',
    };
    var responseData = await hotList(params, showLoading);
    if (mounted) {
      List<ItemListItem> dataList = [];
      var data = responseData.data['itemList'];
      data.forEach((element) {
        dataList.add(ItemListItem.fromJson(element));
      });
      setState(() {
        _dataList = dataList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: _isFirstLoading ? Loading() : _buildBody(),
    );
  }

  bool isScroll = false;

  _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: [
              _topBack(),
              Column(
                children: [
                  Container(height: 180),
                  Stack(
                    children: [
                      _buildGoodItem(),
                      CartTabLayout(
                        subCateList: _subCateList,
                        tabController: _tabController,
                        indexChange: (index) {
                          setState(() {
                            _tabController.index = index;
                          });
                        },
                        isTabScroll: isScroll,
                        scrollPress: (isScroll) {
                          setState(() {
                            this.isScroll = isScroll;
                          });
                        },
                      ),
                    ],
                  ),
                  _buildCategories(),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: StreamBuilder<bool>(
            stream: _streamController.stream,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return snapshot.data!
                  ? Container(
                      decoration: BoxDecoration(
                        color: backWhite,
                        border: Border(
                            bottom: BorderSide(color: lineColor, width: 1)),
                      ),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: CartTabLayout(
                        subCateList: _subCateList,
                        tabController: _tabController,
                        indexChange: (index) {
                          setState(() {
                            _tabController.index = index;
                          });
                        },
                        isTabScroll: isScroll,
                        scrollPress: (isScroll) {
                          setState(() {
                            this.isScroll = isScroll;
                          });
                        },
                      ),
                    )
                  : Container();
            },
          ),
        ),
      ],
    );
  }

  _topBack() {
    return Container(
      height: 270,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_bannerUrl),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: VerticalSliderText(
          dateList: _seller,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              color: Color(0x1A000000),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  _buildGoodItem() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 45),
      padding: EdgeInsets.only(top: 5),
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return HotListItem(
            item: _dataList[index],
            index: index,
          );
        },
        itemCount: _dataList.length,
      ),
    );
  }

  _buildCategories() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: backWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              '更多榜单',
              style: t14blackBold,
            ),
          ),
          GridView.count(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 2.2,
            children: _moreCategories
                .map<Widget>((e) => _buildMoreCatItem(e))
                .toList(),
          )
        ],
      ),
    );
  }

  _buildMoreCatItem(CurrentCategory item) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Color(0xFFF3F8FE), borderRadius: BorderRadius.circular(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.name}榜',
                  style: t14blackBold,
                ),
                SizedBox(height: 5),
                Text(
                  '进入榜单>',
                  style: t12black,
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: CachedNetworkImage(
                  imageUrl: '${item.showItem!.picUrl}',
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.hotList, context,
            {'categoryId': item.id.toString(), 'name': item.name});
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _scrollController.dispose();
    _streamController.close();
    _timer.cancel();
    super.dispose();
  }
}
