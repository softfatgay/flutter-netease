import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/home/components/hot_list_item.dart';
import 'package:flutter_app/ui/sort/model/currentCategory.dart';
import 'package:flutter_app/ui/sort/model/hotListModel.dart';
import 'package:flutter_app/ui/sort/model/subCateListItem.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/my_under_line_tabindicator.dart';
import 'package:flutter_app/widget/sliver_tabbar_delegate.dart';
import 'package:flutter_app/widget/back_loading.dart';

class HotListPage extends StatefulWidget {
  final Map param;

  const HotListPage({Key key, this.param}) : super(key: key);

  @override
  _HotListPageState createState() => _HotListPageState();
}

class _HotListPageState extends State<HotListPage>
    with TickerProviderStateMixin {
  String _currentCategoryId = '0';
  int _currentSubCategoryId = 0;

  TabController _tabController;
  bool _isFirstLoading = true;
  bool _isLoading = true;
  bool _bodyLoading = true;
  int pageSize = 10;
  int _page = 1;

  String _bannerUrl =
      "https://yanxuan.nosdn.127.net/294b914321c27e2490b257b5b6be6fa5.png";

  Timer _timer;
  int _rondomIndex = 0;

  String _categoryId = '0';
  String _categoryName = '';

  ///头部
  List<CurrentCategory> _subCateList;

  ///数据
  List<ItemListItem> _dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _categoryId = widget.param['categoryId'];
      _categoryName = widget.param['name'];
    });
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        _rondomIndex++;
        if (_rondomIndex >= 18) {
          _rondomIndex = 0;
        }
      });
    });
    _getData();
  }

  void _getData() async {
    _getCat();
    _getItemList();
  }

  _getCat() async {
    Map<String, dynamic> params = {
      "categoryId": _categoryId,
      "subCategoryId": 0,
    };

    var responseData = await hotListCat(params);
    var oData = responseData.OData;
    var hotListModel = HotListModel.fromJson(oData);

    ///tab列表
    List<CurrentCategory> cateList = [];
    var currentCategory = hotListModel.currentCategory;
    currentCategory.name = '全部';
    var subCateList = currentCategory.subCateList;
    cateList.add(currentCategory);
    cateList.addAll(subCateList);
    setState(() {
      _subCateList = cateList;
      _tabController = TabController(length: _subCateList.length, vsync: this);
      _isFirstLoading = false;
      _bannerUrl = currentCategory.bannerUrl;
    });
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == _tabController.animation.value) {
          _bodyLoading = true;
          _page = 1;
          _currentCategoryId = _subCateList[_tabController.index].id.toString();
          _currentSubCategoryId =
              _subCateList[_tabController.index].superCategoryId;
          _getItemList();
        }
      });
    });
  }

  ///列表数据
  _getItemList() async {
    setState(() {
      _bodyLoading = true;
    });
    Map<String, dynamic> params = {
      "categoryId": _categoryId,
      "subCategoryId": _currentCategoryId,
      "userBusId": '',
    };
    var responseData = await hotList(params);
    List<ItemListItem> dataList = [];
    List data = responseData.data['itemList'];
    data.forEach((element) {
      dataList.add(ItemListItem.fromJson(element));
    });

    setState(() {
      _dataList = dataList;
      _bodyLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: _isFirstLoading ? Loading() : _buildBody(),
    );
  }

  _buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (context, bool) {
        return [
          SliverAppBar(
            expandedHeight: 160.0,
            floating: true,
            pinned: true,
            toolbarHeight: 0,
            automaticallyImplyLeading: true,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_bannerUrl),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(child: Text('★官方销售数据', style: t12white)),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('★官方销售数据', style: t12white)),
                          Container(child: Text('★官方销售数据', style: t12white)),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Color(0x4DB3423A),
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        '${seller[_rondomIndex]}',
                        style: t12white,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: SliverTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  tabs: _subCateList.map((f) => Tab(text: f.name)).toList(),
                  indicator: MyUnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: redColor),
                  ),
                  indicatorColor: Colors.red,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.red,
                  isScrollable: true,
                ),
                color: Colors.white,
                back: Icon(Icons.keyboard_backspace)),
            pinned: true,
          ),
        ];
      },
      body: Container(
        child: NotificationListener(
          onNotification: (ScrollNotification scrollInfo) =>
              _onScrollNotification(scrollInfo),
          child: _buildGrid(),
        ),
      ),
    );
  }

  _onScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      if (!_isLoading) {
        setState(() {
          this._isLoading = true;
          setState(() {
            _page += 1;
          });
        });
        _getItemList(); //加载数据
      }
    }
  }

  _buildGrid() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
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

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }

  List seller = [
    "6***撵刚刚下单啦！",
    "馁**1刚刚下单啦！",
    "凯***z刚刚下单啦！",
    "5**9刚刚下单啦！",
    "柿***f刚刚下单啦！",
    "7*****9刚刚下单啦！",
    "棚*y刚刚下单啦！",
    "秸****9刚刚下单啦！",
    "3**战刚刚下单啦！",
    "召*8刚刚下单啦！",
    "咏****C刚刚下单啦！",
    "溢*****9刚刚下单啦！",
    "2***6刚刚下单啦！",
    "1*认刚刚下单啦！",
    "聊*****f刚刚下单啦！",
    "4*它刚刚下单啦！",
    "崭*****3刚刚下单啦！",
    "9**1刚刚下单啦！",
    "5*雁刚刚下单啦！",
    "E****5刚刚下单啦！"
  ];
}
