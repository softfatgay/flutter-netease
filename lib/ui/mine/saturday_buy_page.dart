import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/my_under_line_tabindicator.dart';
import 'package:flutter_app/widget/sliver_tabbar_delegate.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/sliver_footer.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/top_round_net_image.dart';

class SaturdayTBuyPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<SaturdayTBuyPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  var _tabTitle = [];
  bool _isLoading = true;
  bool _bodyLoading = true;
  bool _isFirstLoading = true;
  int _pageSize = 10;
  int _page = 1;
  int tabId = 0;
  String _tabIdType = 'tabId';
  var _pagination;
  bool _hasMore = true;

  List _dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: _isFirstLoading
          ? Loading()
          : NestedScrollView(
              headerSliverBuilder: (context, bool) {
                return [
                  SliverAppBar(
                    expandedHeight: 100.0,
                    floating: true,
                    pinned: true,
                    toolbarHeight: 40,
                    brightness: Brightness.light,
                    automaticallyImplyLeading: false,
                    title: Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 20,
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
                            style: t16blackbold,
                          )
                        ],
                      ),
                    ),
                    backgroundColor: backWhite,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                        image: AssetImage("assets/images/stadurday_buy.png"),
                        fit: BoxFit.cover,
                      ))),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: new SliverTabBarDelegate(
                        TabBar(
                          controller: _tabController,
                          tabs: _tabTitle
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
                        back: Icon(Icons.arrow_back_ios)),
                    pinned: true,
                  ),
                ];
              },
              body: _bodyLoading
                  ? Loading()
                  : Container(
                      child: NotificationListener(
                        onNotification: (ScrollNotification scrollInfo) =>
                            _onScrollNotification(scrollInfo),
                        child: CustomScrollView(
                          slivers: [
                            singleSliverWidget(_buildGrid()),
                            SliverFooter(hasMore: _hasMore)
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
        padding: EdgeInsets.all(5),

        ///这两个属性起关键性作用，列表嵌套列表一定要有Container
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.65,
        children: _dataList.map<Widget>((item) {
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
            Routers.webView,
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
      if (!_isLoading) {
        setState(() {
          this._isLoading = true;
          setState(() {
            _page += 1;
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
    _tabController = TabController(length: _tabTitle.length, vsync: this);

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
      _tabTitle = allList;
      _tabController = TabController(length: _tabTitle.length, vsync: this);
      _tabController.addListener(() {
        setState(() {
          if (_tabController.index == _tabController.animation.value) {
            _bodyLoading = true;
            _hasMore = true;
            _page = 1;
            if (_tabTitle[_tabController.index]['type'] != null) {
              _tabIdType = 'tabId';
            } else {
              _tabIdType = 'categoryId';
            }
            tabId = _tabTitle[_tabController.index]['id'];
            print(tabId);

            _dataList.clear();
            _getPinDataList();
          }
        });
      });
      _isFirstLoading = false;
      _getPinDataList();
    });
  }

  _getPinDataList() async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      _tabIdType: tabId,
      'page': _page,
      'pageSize': _pageSize
    };
    var responseData = await getPinDataList(params);
    print(responseData.data);

    setState(() {
      _bodyLoading = false;
      _isLoading = false;
      _pagination = responseData.data['pagination'];
      if (_page >= _pagination['totalPage']) {
        _hasMore = false;
      }
      _dataList.insertAll(_dataList.length, responseData.data['result']);
    });
  }

  _buildItem(var item) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 130,
              child: TopRoundNetImage(
                url: item['picUrl'],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                    color: redColor, borderRadius: BorderRadius.circular(12)),
                child: Text(
                  '降! ¥${(NumUtil.getNumByValueDouble(item['originPrice'] - item['price'], 1)).toStringAsFixed(0)}',
                  style: t12white,
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
                          width: 16,
                          height: 16,
                          fit: BoxFit.cover,
                        )),
                        SizedBox(width: 2),
                        ClipOval(
                            child: Image.network(
                          item['recentUsers'] == null
                              ? ''
                              : item['recentUsers'][1],
                          width: 16,
                          height: 16,
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
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      style: t14white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5)
            ],
          )
        ],
      ),
    );
  }
}
