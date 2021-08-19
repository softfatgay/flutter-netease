import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/home/components/top_search.dart';
import 'package:flutter_app/ui/topic/components/topic_item_widget.dart';
import 'package:flutter_app/ui/topic/model/navItem.dart';
import 'package:flutter_app/ui/topic/model/result.dart';
import 'package:flutter_app/ui/topic/model/topNavData.dart';
import 'package:flutter_app/ui/topic/model/topicData.dart';
import 'package:flutter_app/ui/topic/model/topicItem.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/local_storage.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/loading.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TopicPage extends StatefulWidget {
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = new ScrollController();

  final _streamController = StreamController<double>.broadcast();

  final _streamControllerTab = StreamController<double>.broadcast();

  final _footerController = StreamController<bool>.broadcast();

  ///第一次加载
  bool _isFirstLoading = true;
  final int _pageSize = 5;
  int _page = 1;

  bool _hasMore = true;
  List _roundWords = [];
  int _rondomIndex = 0;
  var _timer;

  var _alignmentY = 0.0;

  ///头部nav
  List<NavItem> _navList;

  ///数据
  List<Result> _result;

  ///条目数据
  List<TopicItem> _dataList = [];

  @override
  bool get wantKeepAlive => true;

  var _toolbarHeight = 0;

  num _totalNum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 180) {
        if (_toolbarHeight == 0) {
          setState(() {
            _toolbarHeight = 50;
          });
          _streamControllerTab.sink.add(50);
        }
        if (_scrollController.position.pixels > 700) {
          _footerController.sink.add(true);
        } else {
          _footerController.sink.add(false);
        }
      } else {
        if (_toolbarHeight == 50) {
          setState(() {
            _toolbarHeight = 0;
          });
          _streamControllerTab.sink.add(0);
        }
      }

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
    _getTopicData();
    _getMore();

    _timer = Timer.periodic(Duration(milliseconds: 4000), (_timer) {
      setState(() {
        if (_roundWords.length > 0) {
          _rondomIndex++;
          if (_rondomIndex >= _roundWords.length) {
            _rondomIndex = 0;
          }
        }
      });
    });
  }

  ///头部nav
  void _getTopicData() async {
    var sp = await LocalStorage.sp;
    setState(() {
      _totalNum = sp.get(LocalStorage.totalNum);
    });
    var responseData = await knowNavwap();
    setState(() {
      _isFirstLoading = false;
      var data = responseData.data;
      if (data != null) {
        var topData = TopData.fromJson(data);
        _navList = topData.navList;
      }
    });
  }

  _getMore() async {
    Map<String, dynamic> params = {
      'page': _page,
      'size': _pageSize,
      'exceptIds': ''
    };

    var responseData = await findRecAuto(params);
    var data = responseData.data;
    if (data != null) {
      var topicData = TopicData.fromJson(data);
      setState(() {
        _page++;
        _hasMore = topicData.hasMore;
        _result = topicData.result;
        _result.forEach((element) {
          _dataList.addAll(element.topics);
        });
      });
      if (_dataList.length < 3 && _page == 2) {
        _getMore();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    _streamControllerTab.close();
    _footerController.close();
    _scrollController.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGrey,
      body: _buildBody(),
      floatingActionButton: StreamBuilder(
          stream: _footerController.stream,
          initialData: false,
          builder: (context, snapshot) {
            return snapshot.data ? floatingAB(_scrollController) : Container();
          }),
    );
  }

  _buildBody() {
    if (_isFirstLoading) {
      return Loading();
    } else {
      return _buildBodyData();
    }
  }

  _staggeredGridview() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      sliver: SliverStaggeredGrid.countBuilder(
        itemCount: _dataList.length,
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        staggeredTileBuilder: (index) => new StaggeredTile.count(
            1, _dataList[index].buyNow == null ? 1.4 : 1.5),
        itemBuilder: (context, index) {
          return TopicItemWidget(item: _dataList[index]);
        },
      ),
    );
  }

  _buildBodyData() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        StreamBuilder(
            stream: _streamControllerTab.stream,
            initialData: 0.0,
            builder: (context, snapshot) {
              return SliverAppBar(
                pinned: true,
                expandedHeight: 260,
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                toolbarHeight: double.parse(snapshot.data.toString()),
                title: TopSearch(
                  totalNum: _totalNum,
                ),
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildNav(),
                ),
              );
            }),
        _staggeredGridview(),
        SliverFooter(hasMore: _hasMore)
      ],
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    var alignmentY = -1 + (metrics.pixels / metrics.maxScrollExtent) * 2;
    _streamController.sink.add(alignmentY);
    return true;
  }

  _buildNav() {
    if (_navList == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/topic_header_back.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Row(
              children: [
                Image.asset(
                  'assets/images/topic_icon.png',
                  height: 30,
                ),
                Text(
                  '严选好物 用心生活',
                  style: t14white,
                )
              ],
            ),
          ),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: backWhite,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    scrollDirection: Axis.horizontal,
                    children: _navList.map((item) {
                      return GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  height: ScreenUtil().setHeight(50),
                                  width: ScreenUtil().setHeight(50),
                                  child: CachedNetworkImage(
                                    imageUrl: '${item.picUrl}',
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Text('${item.mainTitle}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: textBlack,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 1),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Text(
                                  '${item.viceTitle}',
                                  style: TextStyle(
                                      fontSize: 10, color: textLightGrey),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Routers.push(Routers.webView, context,
                              {'url': '${item.columnUrl}'});
                        },
                      );
                    }).toList(),
                  ),
                  StreamBuilder(
                      stream: _streamController.stream,
                      initialData: -1.0,
                      builder: (context, snapshot) {
                        return Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: lineColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          width: 100,
                          alignment: Alignment(snapshot.data, 1),
                          child: Container(
                            decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(2)),
                            height: 4,
                            width: 20,
                          ),
                        );
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
