import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/sort/model/hotListModel.dart';
import 'package:flutter_app/ui/sort/model/subCateListItem.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/MyUnderlineTabIndicator.dart';
import 'package:flutter_app/widget/SliverTabBarDelegate.dart';
import 'package:flutter_app/widget/back_loading.dart';

class HotListPage extends StatefulWidget {
  @override
  _HotListPageState createState() => _HotListPageState();
}

class _HotListPageState extends State<HotListPage>
    with TickerProviderStateMixin {
  int currentCategoryId = 0;
  int currentSubCategoryId = 0;

  TabController _tabController;
  bool isFirstLoading = true;
  bool isLoading = true;
  bool bodyLoading = true;
  int pageSize = 10;
  int page = 1;

  Timer timer;
  int rondomIndex = 0;

  ///头部
  List<SubCateListItem> _subCateList;

  ///数据
  List<ItemListItem> _dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        rondomIndex++;
        if (rondomIndex >= 18) {
          rondomIndex = 0;
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
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}",
      "categoryId": 0,
      "subCategoryId": 0,
    };
    Map<String, dynamic> header = {"Cookie": cookie};

    var responseData = await hotListCat(params, header: header);
    var oData = responseData.OData;
    var hotListModel = HotListModel.fromJson(oData);

    setState(() {
      _subCateList = hotListModel.currentCategory.subCateList;
      _tabController = TabController(length: _subCateList.length, vsync: this);
      isFirstLoading = false;
      _tabController.addListener(() {
        setState(() {
          if (_tabController.index == _tabController.animation.value) {
            bodyLoading = true;
            page = 1;
            currentCategoryId = _subCateList[_tabController.index].id;
            currentSubCategoryId =
                _subCateList[_tabController.index].superCategoryId;
            _getItemList();
          }
        });
      });
    });
  }

  _getItemList() async {
    setState(() {
      bodyLoading = true;
    });
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "categoryId": currentCategoryId,
      "subCategoryId": currentSubCategoryId,
    };
    Map<String, dynamic> header = {"Cookie": cookie};

    var responseData = await hotList(params, header: header);
    List<ItemListItem> dataList = [];
    List data = responseData.data['itemList'];
    data.forEach((element) {
      dataList.add(ItemListItem.fromJson(element));
    });

    setState(() {
      _dataList = dataList;
      bodyLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        title: Text(
          '热销榜',
          style: t16white,
        ),
      ),
      body: isFirstLoading ? Loading() : _buildBody(),
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
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: redColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '网易严选热销榜',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 35),
                    ),
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
                        '${seller[rondomIndex]}',
                        style: t12white,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: new SliverTabBarDelegate(
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
      if (!isLoading) {
        setState(() {
          this.isLoading = true;
          setState(() {
            page += 1;
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
        itemBuilder: (context, index) {
          return _buildItem(index);
        },
        itemCount: _dataList.length,
      ),
    );
  }

  Widget _buildItem(int index) {
    var item = _dataList[index];
    Widget widget = Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 140,
                child: Row(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      child: CachedNetworkImage(
                        imageUrl: item.scenePicUrl,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (item.promTag == null || item.promTag == '')
                                ? Container()
                                : Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: redColor, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      '${item.promTag}',
                                      style: t12red,
                                    ),
                                  ),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: Text(
                                '${item.name}',
                                style: TextStyle(
                                    color: textBlack,
                                    fontSize: 16,
                                    height: 1.1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            item.goodCmtRate == null
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text('${item.goodCmtRate}好评率'),
                                  ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                      child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '¥${item.retailPrice}',
                                        style: TextStyle(
                                            color: textRed,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      (item.counterPrice == item.retailPrice ||
                                              item.counterPrice == 0)
                                          ? Container()
                                          : Text(
                                              '¥${item.counterPrice}',
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: textGrey),
                                            )
                                    ],
                                  )),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: redColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      '马上抢',
                                      style: t16whiteblod,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              item.hotSaleListBottomInfo == null
                  ? Container()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              '${item.hotSaleListBottomInfo.iconUrl ?? ''}',
                              height: 20,
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                              child: Text(
                            '${item.hotSaleListBottomInfo.content ?? ''}',
                            style: t12grey,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: textGrey,
                          )
                        ],
                      ),
                    ),
            ],
          ),
          Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFFD2D3D2)),
            child: Text(
              '${index + 1}',
              style: t14white,
            ),
          )
        ],
      ),
    );
    return Routers.link(widget, Util.goodDetailTag, context, {'id': item.id});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    timer.cancel();
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
