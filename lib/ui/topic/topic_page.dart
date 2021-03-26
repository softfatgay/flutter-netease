import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/topic/model/navItem.dart';
import 'package:flutter_app/ui/topic/model/result.dart';
import 'package:flutter_app/ui/topic/model/topNavData.dart';
import 'package:flutter_app/ui/topic/model/topicData.dart';
import 'package:flutter_app/ui/topic/model/topicItem.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/search.dart';
import 'package:flutter_app/widget/sliver_footer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TopicPage extends StatefulWidget {
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = new ScrollController();
  ScrollController _scrollBarController = new ScrollController();

  ///第一次加载
  bool _isFirstLoading = true;
  final int _pageSize = 3;
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

  var toolbarHeight = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      if (_scrollController.position.pixels > 180) {
        setState(() {
          toolbarHeight = 50;
        });
      } else {
        setState(() {
          toolbarHeight = 0;
        });
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
    var responseData = await knowNavwap({});
    setState(() {
      _isFirstLoading = false;
      var data = responseData.data;
      var topData = TopData.fromJson(data);
      _navList = topData.navList;
    });
  }

  _getMore() async {
    Map<String, dynamic> header = {
      "Cookie": cookie,
      "csrf_token": csrf_token,
    };
    Map<String, dynamic> params = {
      'page': _page,
      'size': _pageSize,
      'exceptIds': ''
    };

    var responseData = await findRecAuto(params, header: header);
    var data = responseData.data;
    var topicData = TopicData.fromJson(data);
    setState(() {
      _page++;
      _hasMore = topicData.hasMore;
      _result = topicData.result;
      _result.forEach((element) {
        _dataList.addAll(element.topics);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGrey,
      body: buildBody(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    _scrollBarController.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  buildBody() {
    if (_isFirstLoading) {
      return Loading();
    } else {
      return _buildBodyData();
    }
  }

  _buildSearch(BuildContext context) {
    Widget widget = Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Color(0x0D000000),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              _roundWords.length > 0 ? _roundWords[_rondomIndex] : '',
              style: TextStyle(color: textGrey, fontSize: 14),
            ),
          ),
        ),
        Container(
          child: Text(
            '搜索',
            style: t16grey,
          ),
        )
      ],
    ));
    return Routers.link(widget, Util.search, context, {'id': ''});
  }

  _buildItem(TopicItem item) {
    var buyNow = item.buyNow;
    Widget widget = Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: CachedNetworkImage(
              height: ScreenUtil().setHeight(150),
              imageUrl: item.picUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              item.title,
              textAlign: TextAlign.left,
              style: t12black,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipOval(
                  child: item.avatar == null
                      ? Container()
                      : Container(
                          width: 25,
                          height: 25,
                          child: CachedNetworkImage(
                            imageUrl: item.avatar,
                            errorWidget: (context, url, error) {
                              return ClipOval(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                ),
                Expanded(
                  child: Container(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        item.nickname ?? '',
                        style: t12grey,
                      ),
                    ),
                  ),
                ),
                Container(
                    child: item.readCount == null
                        ? Container()
                        : Icon(
                            Icons.remove_red_eye,
                            color: textGrey,
                            size: 16,
                          )),
                Container(
                  child: Text(
                    item.readCount == null
                        ? ''
                        : (item.readCount > 1000
                            ? '${int.parse((item.readCount / 1000).toStringAsFixed(0))}K'
                            : '${item.readCount}'),
                    style: t12grey,
                  ),
                ),
              ],
            ),
          ),
          buyNow == null
              ? Container()
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 1,
                  color: lineColor,
                ),
          buyNow == null
              ? Container()
              : GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          '${buyNow.itemName}',
                          style: t12black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Text(
                          '去购买',
                          style: t12red,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: textRed,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Routers.push(Util.goodDetailTag, context,
                        {'id': '${buyNow.itemId}'});
                  },
                )
        ],
      ),
    );
    String schemeUrl = item.schemeUrl;
    if (!schemeUrl.startsWith('http')) {
      schemeUrl = 'https://m.you.163.com$schemeUrl';
    }
    return Routers.link(widget, Util.webView, context, {'id': schemeUrl});
  }

  _stagegeredGridview() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      sliver: SliverStaggeredGrid.countBuilder(
        itemCount: _dataList.length,
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        staggeredTileBuilder: (index) => new StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return _buildItem(_dataList[index]);
        },
      ),
    );
  }

  _buildBodyData() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: ScreenUtil().setHeight(180),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          toolbarHeight: double.parse(toolbarHeight.toString()),
          title: SearchWidget(),
          centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildNav(),
          ),
        ),
        _stagegeredGridview(),
        SliverFooter(
          hasMore: _hasMore,
        )
      ],
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    print('滚动组件最大滚动距离:${metrics.maxScrollExtent}');
    print('当前滚动位置:${metrics.pixels}');
    setState(() {
      _alignmentY = -1 + (metrics.pixels / metrics.maxScrollExtent) * 2;
    });
    return true;
  }

  _buildNav() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEED4A9),
            Colors.white,
          ],
        ),
      ),
      padding:
          EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 10, 0, 5),
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GridView.count(
              crossAxisCount: 2,
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
                                  fontSize: ScreenUtil()
                                      .setSp(12, allowFontScalingSelf: false),
                                  color: textBlack,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            '${item.viceTitle}',
                            style: TextStyle(
                                fontSize: ScreenUtil()
                                    .setSp(10, allowFontScalingSelf: false),
                                color: textLightGrey),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Routers.push(
                        Util.webView, context, {'id': '${item.columnUrl}'});
                  },
                );
              }).toList(),
            ),
            Container(
              height: 3,
              decoration: BoxDecoration(
                  color: lineColor, borderRadius: BorderRadius.circular(2)),
              width: 150,
              alignment: Alignment(_alignmentY, 1),
              child: Container(
                decoration: BoxDecoration(
                    color: redColor, borderRadius: BorderRadius.circular(2)),
                height: 4,
                width: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
