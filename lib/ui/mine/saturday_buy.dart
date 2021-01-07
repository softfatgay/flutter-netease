import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/MyUnderlineTabIndicator.dart';
import 'package:flutter_app/widget/SliverTabBarDelegate.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/footer.dart';

class SaturdayTBuy extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<SaturdayTBuy> with TickerProviderStateMixin {
  TabController _tabController;

  var tabTitle = List();
  bool isLoading = true;
  bool bodyLoading = true;
  bool isFirstLoading = true;
  int pageSize = 10;
  int page = 1;
  int tabId = 0;
  String tabIdType = 'tabId';
  var pagination;
  int total = 999999999;

  List dataList = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      body: isFirstLoading
          ? Loading()
          : NestedScrollView(
              headerSliverBuilder: (context, bool) {
                return [
                  SliverAppBar(
                    expandedHeight: 100.0,
                    floating: true,
                    pinned: true,
                    toolbarHeight: 0,
                    automaticallyImplyLeading: false,
                    shadowColor: Colors.transparent,
                    title: Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.keyboard_backspace,
                              color: textBlack,
                              size: 28,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '拼团',
                            style: TextStyle(color: textBlack),
                          )
                        ],
                      ),
                    ),
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                        // centerTitle: true,
                        background: Image(
                      image: AssetImage("assets/images/stadurday_buy.png"),
                      fit: BoxFit.fitHeight,
                    )),
                  ),
                  SliverPersistentHeader(
                    delegate: new SliverTabBarDelegate(
                        TabBar(
                          controller: _tabController,
                          tabs: tabTitle
                              .map((f) => Tab(text: f['name']))
                              .toList(),
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
              body: bodyLoading
                  ? Loading()
                  : Container(
                      child: NotificationListener(
                        onNotification: (ScrollNotification scrollInfo) =>
                            _onScrollNotification(scrollInfo),
                        child: Column(
                          children: [
                            Expanded(child: _buildGrid()),
                            isLoading ? Loading() : Container(),
                          ],
                        ),
                      ),
                    ),
            ),
    );
  }

  _buildGrid() {
    return Container(
      child: GridView.count(
        padding: EdgeInsets.all(10),

        ///这两个属性起关键性作用，列表嵌套列表一定要有Container
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65,
        children: dataList.map<Widget>((item) {
          Widget widget;
          if (item['bottomType'] != null) {
            widget = Container(
              height: 20,
            );
          } else {
            widget = _buildItem(item);
          }
          return Routers.link(
            widget,
            Util.webView,
            context,
            {
              'id':
                  'https://m.you.163.com/pin/static/index.html#/pages/pin/detail/goods?pinBaseId=${item['id']}'
            },
          );
        }).toList(),
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
        _getPinDataList(); //加载数据
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabTitle.length, vsync: this);

    _getCategoryList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void _getCategoryList() async {
    Map<String, dynamic> params = {"csrf_token": csrf_token};
    var responseData = await getPinCategoryList(params);
    var data = responseData.data;
    var allList = List();
    List tabList = data["tabList"];
    tabList.forEach((element) {
      Map tab = element;
      tab['type'] = 'tabId';
      allList.add(element);
    });

    List categoryList = data["categoryList"];

    categoryList.forEach((element) {
      allList.add(element);
    });

    setState(() {
      tabTitle = allList;
      _tabController = TabController(length: tabTitle.length, vsync: this);
      _tabController.addListener(() {
        setState(() {
          if (_tabController.index == _tabController.animation.value) {
            bodyLoading = true;
            page = 1;
            if (tabTitle[_tabController.index]['type'] != null) {
              tabIdType = 'tabId';
            } else {
              tabIdType = 'categoryId';
            }
            tabId = tabTitle[_tabController.index]['id'];
            print(tabId);

            dataList.clear();
            _getPinDataList();
          }
        });
      });
      isFirstLoading = false;
      _getPinDataList();
    });
  }

  _getPinDataList() async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      tabIdType: tabId,
      'page': page,
      'pageSize': pageSize
    };
    var responseData = await getPinDataList(params);
    print(responseData.data);

    setState(() {
      bodyLoading = false;
      isLoading = false;
      pagination = responseData.data['pagination'];
      total = pagination['total'];
      if (dataList.length == 0) {
        // dataList.add({'bottomType': 'bottom'});
      }
      dataList.insertAll(dataList.length, responseData.data['result']);
    });
  }

  _buildItem(var item) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 130,
            child: CachedNetworkImage(
              imageUrl: item['picUrl'],
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                      color: redColor, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    '降! ¥${(NumUtil.getNumByValueDouble(item['originPrice'] - item['price'], 1)).toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                  child: Text(
                    item['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: Text(
                        '${item['userNum']}人团',
                        style: TextStyle(fontSize: 12, color: textGrey),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          ClipOval(
                              child: Image.network(
                            item['recentUsers'] == null
                                ? ''
                                : item['recentUsers'][0],
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          )),
                          ClipOval(
                              child: Image.network(
                            item['recentUsers'] == null
                                ? ''
                                : item['recentUsers'][1],
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          )),
                          Expanded(
                            child: Text(
                              '${item['joinUsers']}人已拼',
                              style: TextStyle(fontSize: 12, color: textGrey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "¥${item["price"]}",
                          style: TextStyle(
                              color: textRed,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Expanded(
                            child: Text(
                          "¥${item["originPrice"]}",
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    )),
                    Container(
                      margin: EdgeInsets.only(right: 6),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        '去开团',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
