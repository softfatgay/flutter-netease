import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/model/saturdayBuyModel.dart';
import 'package:flutter_app/model/tabGroupModel.dart';
import 'package:flutter_app/model/tabModel.dart';
import 'package:flutter_app/ui/pin/components/cart_tablayout_stu.dart';
import 'package:flutter_app/ui/mine/components/stu_buy_List_item_widget.dart';
import 'package:flutter_app/ui/mine/components/stu_buy_grid_item_widget.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/normal_footer.dart';

class PinMainPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<PinMainPage> with TickerProviderStateMixin {
  String _topBackImg =
      'http://yanxuan.nosdn.127.net/18522f8bd4b81e454eee3317f0b77bdc.png';

  TabController _tabController;

  List<TabModel> _tabTitle = [];
  bool _isLoading = true;
  bool _isFirstLoading = true;
  int _pageSize = 10;
  int _page = 1;
  int tabId = 0;
  String _tabIdType = 'tabId';
  Pagination _pagination;
  bool _hasMore = true;

  List<Result> _dataList = [];
  List<Result> _moreDataList = [];

  final _scrollController = ScrollController();
  final _streamController = StreamController<bool>.broadcast();
  final _upStreamController = StreamController<bool>.broadcast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabTitle.length, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 95) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!_isLoading) {
            setState(() {
              this._isLoading = true;
              _page += 1;
            });
            _getPinDataList(false); //加载数据
          }
        }
        _streamController.sink.add(true);
        if (_scrollController.position.pixels > 700) {
          _upStreamController.sink.add(true);
        } else {
          _upStreamController.sink.add(false);
        }
      } else {
        _streamController.sink.add(false);
      }
    });
    _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: _isFirstLoading ? Loading() : _buildBody(),
      floatingActionButton: StreamBuilder(
          stream: _upStreamController.stream,
          initialData: false,
          builder: (context, snapshot) {
            return snapshot.data ? floatingAB(_scrollController) : Container();
          }),
    );
  }

  bool isScroll = false;

  _buildBody() {
    return Stack(
      children: [_bodyContent(), _topTab()],
    );
  }

  _bodyContent() {
    print('重新绘制---->');
    return SingleChildScrollView(
      controller: _scrollController,
      child: Stack(
        children: [
          _topBack(),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 130),
              Stack(
                children: [
                  Column(
                    children: [
                      // _buildList(),
                      _buildGrid(),
                      NormalFooter(hasMore: _hasMore),
                    ],
                  ),
                  StuBuyTabLayout(
                    subCateList: _tabTitle,
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
            ],
          ),
        ],
      ),
    );
  }

  _topTab() {
    return Container(
      child: StreamBuilder<bool>(
        stream: _streamController.stream,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data
              ? Container(
                  decoration: BoxDecoration(
                    color: backWhite,
                    border:
                        Border(bottom: BorderSide(color: lineColor, width: 1)),
                  ),
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: StuBuyTabLayout(
                    subCateList: _tabTitle,
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
    );
  }

  _topBack() {
    return Container(
      height: 165,
      width: double.infinity,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage('$_topBackImg'),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '全场包邮 拼到就是赚到',
            style: t14white,
          ),
          SizedBox(height: 10),
          Text(
            '11450人正在拼团',
            style: t14white,
          )
        ],
      ),
    );
  }

  _buildList() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 45),
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return StuBuyListItemWidget(item: _dataList[index]);
        },
        itemCount: _dataList.length,
      ),
    );
  }

  _buildGrid() {
    return _dataList.isEmpty
        ? Container()
        : Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 55),
            child: GridView.count(
              padding: EdgeInsets.all(0),
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 0.6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  _dataList.map((e) => StuBuyGridItemWidget(item: e)).toList(),
            ),
          );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _streamController.close();
    _upStreamController.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _getCategoryList() async {
    var responseData = await getPinCategoryList();
    var data = responseData.data;

    var tabGroupModel = TabGroupModel.fromJson(data);
    var tabList = tabGroupModel.tabList;
    List<TabModel> dataList = [];
    tabList.forEach((element) {
      element.type = 'tabId';
      dataList.add(element);
    });
    var categoryList = tabGroupModel.categoryList;
    dataList.addAll(categoryList);

    if (_tabTitle.isEmpty) {
      setState(() {
        _tabTitle = dataList;
        _tabController = TabController(length: _tabTitle.length, vsync: this)
          ..addListener(() {
            setState(() {
              if (_tabController.index == _tabController.animation.value) {
                _hasMore = true;
                _page = 1;
                if (_tabTitle[_tabController.index].type != null) {
                  _tabIdType = 'tabId';
                } else {
                  _tabIdType = 'categoryId';
                }
                tabId = _tabTitle[_tabController.index].id;
                _getPinDataList(true);
              }
            });
          });
        _isFirstLoading = false;
        _getPinDataList(false);
      });
    }
  }

  _getPinDataList(bool showLoading) async {
    Map<String, dynamic> params = {
      _tabIdType: tabId,
      'page': _page,
      'pageSize': _pageSize
    };
    var responseData = await getPinDataList(params, showLoading);
    var saturdayBuyModel = SaturdayBuyModel.fromJson(responseData.data);

    // setState(() {
    //   _isLoading = false;
    //   _pagination = saturdayBuyModel.pagination;
    //   if (_page >= _pagination.totalPage) {
    //     _hasMore = false;
    //   }
    //   if (_page == 1) {
    //     _dataList.clear();
    //     _moreDataList.clear();
    //     _dataList.insertAll(_dataList.length, saturdayBuyModel.result);
    //     _scrollController.position.jumpTo(0);
    //   } else {
    //     _moreDataList.insertAll(_moreDataList.length, saturdayBuyModel.result);
    //   }
    // });

    setState(() {
      _isLoading = false;
      _pagination = saturdayBuyModel.pagination;
      if (_page >= _pagination.totalPage) {
        _hasMore = false;
      }
      if (_page == 1) {
        _dataList.clear();
        _moreDataList.clear();
        _dataList.insertAll(_dataList.length, saturdayBuyModel.result);
        _scrollController.position.jumpTo(0);
      } else {
        _dataList.insertAll(_dataList.length, saturdayBuyModel.result);
      }
    });
  }
}
