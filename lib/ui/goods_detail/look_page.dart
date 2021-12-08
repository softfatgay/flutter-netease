import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/my_under_line_tabindicator.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/component/top_round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/component/sliverAppBarDelegate.dart';
import 'package:flutter_app/ui/goods_detail/model/lookCollectionModel.dart';
import 'package:flutter_app/ui/goods_detail/model/lookHomeDataModel.dart';
import 'package:flutter_app/ui/goods_detail/model/lookListModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LookPage extends StatefulWidget {
  const LookPage({Key? key}) : super(key: key);

  @override
  _LookPageState createState() => _LookPageState();
}

class _LookPageState extends State<LookPage> with TickerProviderStateMixin {
  late TabController _tabController;
  var _tabItem = [
    {
      "name": "推荐",
      "type": 4,
    },
    {
      "name": "最新",
      "type": 1,
    },
    {
      "name": "",
      "type": 2,
    },
    {
      "name": "",
      "type": 3,
    }
  ];

  double _navbarHeight = 70;
  final _scrollController = new ScrollController();

  int? _type = 4;
  int _page = 1;
  int _size = 20;
  int? _id = 0;

  bool _hasMore = true;
  String _recommendName = '';
  String _title = '';
  int _activeIndex = 0;

  late LookHomeDataModel _lookHomeDataModel;
  LookCollectionModel? _lookCollectionModel;
  late LookListModel _lookListModel;

  List<TopicListItem> _dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    _initTabController();
    super.initState();
    _scrollController.addListener(_scrollListener);
    _lookHomeData();
    _lookGetList();
  }

  _initTabController() {
    setState(() {
      _tabController = TabController(
          length: _tabItem.length, vsync: this, initialIndex: _activeIndex)
        ..addListener(() {
          if (_tabController.index == _tabController.animation!.value) {
            var index = _tabController.index;
            var tabItem = _tabItem[index];

            setState(() {
              _type = tabItem['type'] as int?;
              _page = 1;
            });
            _lookGetList();
          }
        });
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_hasMore) {
        setState(() {
          _page += 1;
        });
        _lookGetList();
      }
    }
  }

  void _lookHomeData() async {
    var responseData = await lookHomeData();
    if (mounted) {
      var data = responseData.data;
      if (responseData.code == '200') {
        setState(() {
          _lookHomeDataModel = LookHomeDataModel.fromJson(data);
          var recModule = _lookHomeDataModel.recModule!;
          _tabItem[2]['name'] = _lookHomeDataModel.hotTabName as String;
          _tabItem[3]['name'] = recModule.topicTagName as String;
          _recommendName = recModule.recommendName ?? '';
          var collectionList = recModule.collectionList;
          if (collectionList != null && collectionList.isNotEmpty) {
            var collection = collectionList[0];
            _title = collection.title ?? '';
          }
          if (collectionList != null && collectionList.isNotEmpty) {
            setState(() {
              _id = collectionList[0].id as int?;
            });
            _lookGetCollection(collectionList[0].id);
          }
        });
      }
    }
  }

  void _lookGetList() async {
    Map<String, dynamic> params = {'type': _type, 'page': _page, 'size': _size};
    var responseData = await lookGetList(params, _page == 1);
    if (mounted) {
      if (responseData.code == '200') {
        setState(() {
          _lookListModel = LookListModel.fromJson(responseData.data);
          if (_page == 1) {
            _dataList.clear();
          }
          _dataList.addAll(_lookListModel.topicList!);
        });
      }
    }
  }

  void _lookGetCollection(num? id) async {
    Map<String, dynamic> params = {'id': id};
    var responseData = await lookGetCollection(params);
    if (mounted) {
      if (responseData.code == '200') {
        setState(() {
          _lookCollectionModel =
              LookCollectionModel.fromJson(responseData.data);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: TopAppBar(
        title: '晒单',
      ).build(context),
      body: _body(),
      floatingActionButton: _floatingAB(),
    );
  }

  _floatingAB() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 50),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backRed,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/edit_icon.png',
              color: backWhite,
              width: 16,
              height: 16,
            ),
            SizedBox(width: 4),
            Text(
              '立即投稿',
              style: t14white,
            ),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.mineItems, context, {'id': 0, 'tab': 4});
      },
    );
  }

  _body() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        if (_lookCollectionModel != null) singleSliverWidget(_topWidget()),
        _buildStickyBar(),
        _listData(),
        SliverFooter(hasMore: _hasMore)
      ],
    );
  }

  _topWidget() {
    return Container(
      color: backWhite,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            '$_recommendName',
            style: t14grey,
          ),
          SizedBox(height: 5),
          Text(
            "$_title",
            style: t16black,
          ),
          SizedBox(height: 5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _lookCollectionModel!.lookList!
                  .map((item) => GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: RoundNetImage(
                            url: item.banner!.picUrl,
                            backColor: backColor,
                            height: 120,
                            width: 120,
                            corner: 6,
                          ),
                        ),
                        onTap: () {
                          Routers.push(Routers.webView, context, {
                            'url':
                                'https://you.163.com/act/pub/7F3DBEV0Rn.html?id=142&index=$_id'
                          });
                        },
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  _buildStickyBar() {
    return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: SliverAppBarDelegate(
          minHeight: _navbarHeight - 30, //收起的高度
          maxHeight: _navbarHeight, //展开的最大高度
          child: Container(
            color: backWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '他们的严选生活',
                      style: t14blackBold,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Container(
                    height: 40,
                    child: TabBar(
                      isScrollable: false,
                      controller: this._tabController,
                      labelStyle: TextStyle(fontSize: 15),
                      labelColor: redColor,
                      indicatorColor: Colors.red,
                      unselectedLabelColor: Colors.black,
                      indicator: MyUnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: redColor),
                      ),
                      tabs: _tabItem
                          .map((f) => Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 34,
                                  child: Text(
                                    f['name'] as String,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ))
                          .toList(),
                    )),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _listData() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      sliver: SliverStaggeredGrid.countBuilder(
          itemCount: _dataList.length,
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          staggeredTileBuilder: (index) =>
              StaggeredTile.count(1, _crosAxis(_dataList[index])),
          itemBuilder: (context, index) {
            var buildGoodItem = _buildItem(context, index);
            return GestureDetector(
              child: buildGoodItem,
              onTap: () {
                var dataItem = _dataList[index];
                String tagUrl =
                    '${NetConstants.baseUrl}act/pub/7F3DBEV0Rn.html?id=';
                String url = '';
                if (dataItem.bannerUrl == null) {
                  url = '$tagUrl${dataItem.topicId}';
                } else {
                  url = '${NetConstants.baseUrl_}${_dataList[index].bannerUrl}';
                }
                Routers.push(Routers.webView, context, {'url': url});
              },
            );
          }),
    );
  }

  double _crosAxis(TopicListItem item) {
    if (item.bannerInfo!.height == null ||
        item.bannerInfo!.width == null ||
        item.bannerInfo!.width == 0) {
      return 1;
    }
    return (item.bannerInfo!.height! / item.bannerInfo!.width!) + 0.5;
  }

  _buildItem(BuildContext context, int index) {
    var item = _dataList[index];
    var collection = item.collection;
    if (collection != null) {
      return Container(
        decoration: BoxDecoration(
            color: item.bannerUrl == null ? backWhite : Color(0XFFffe1b2),
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TopRoundNetImage(
                url: collection.picUrl,
                corner: 6,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${collection.title}',
                    style: t18blackBold,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${collection.subtitle}',
                    style: t14black,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: backWhite, borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TopRoundNetImage(
              url: item.bannerInfo!.picUrl,
              corner: 6,
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: Text(
              '${item.content}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: t12black,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                RoundNetImage(
                  height: 24,
                  width: 24,
                  corner: 12,
                  url: '${item.avatar}',
                ),
                Expanded(
                    child: Text(
                  '${item.nickName}',
                  style: t12grey,
                )),
                GestureDetector(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${item.supportNum}',
                        style: t12grey,
                      ),
                      SizedBox(width: 2),
                      item.supportFlag!
                          ? Image.asset(
                              'assets/images/zan_true.png',
                              width: 14,
                              height: 14,
                            )
                          : Image.asset(
                              'assets/images/zan_nomal.png',
                              width: 14,
                              height: 14,
                            ),
                    ],
                  ),
                  onTap: () {
                    if (!item.supportFlag!) {
                      _support(item, index);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _support(TopicListItem item, int index) async {
    Map<String, dynamic> params = {'topicId': item.topicId};
    var responseData = await lookSupport(params);
    if (responseData.code == '200') {
      setState(() {
        _dataList[index].supportFlag = true;
        _dataList[index].supportNum = _dataList[index].supportNum! + 1;
      });
    }
  }
}
