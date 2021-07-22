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
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/verical_text_scoller.dart';

class HotListPage extends StatefulWidget {
  final Map param;

  const HotListPage({Key key, this.param}) : super(key: key);

  @override
  _HotListPageState createState() => _HotListPageState();
}

class _HotListPageState extends State<HotListPage>
    with TickerProviderStateMixin {
  final StreamController<bool> _streamController =
      StreamController<bool>.broadcast();

  var _scrollController = ScrollController();

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
  List<CurrentCategory> _subCateList = [];
  List<CurrentCategory> _moreCategories = [];

  ///数据
  List<ItemListItem> _dataList = [];

  bool _isShowTop = false;

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

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 140) {
        _streamController.sink.add(true);
      } else {
        _streamController.sink.add(false);
      }
    });
    _getData();
  }

  void _getData() async {
    _getCat();
    _getItemList(false);
    _submitOrderInfo();
  }

  _submitOrderInfo() async {
    var responseData = await submitOrderInfo();
    if (responseData.code == '200') {
      setState(() {
        _seller = responseData.data;
      });
    }
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
      _moreCategories = hotListModel.moreCategories;
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
          _getItemList(true);
        }
      });
    });
  }

  ///列表数据
  _getItemList(bool showLoading) async {
    setState(() {
      _bodyLoading = true;
    });
    Map<String, dynamic> params = {
      "categoryId": _categoryId,
      "subCategoryId": _currentCategoryId,
      "userBusId": '',
    };
    var responseData = await hotList(params, showLoading);
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
                  Container(
                    height: 180,
                  ),
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
              return snapshot.data
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

  bool isTabScroll = false;

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
                  imageUrl: '${item.showItem.picUrl}',
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

  List<String> _seller = [
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
