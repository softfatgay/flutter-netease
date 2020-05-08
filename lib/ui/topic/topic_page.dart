import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_footer.dart';
import 'package:flutter_app/widget/swiper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TopicPage extends StatefulWidget {
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  ScrollController _scrollController = new ScrollController();

  ///第一次加载
  bool isFirstloading = true;
  final int pageSize = 3;
  int page = 2;

  List dataList = [];
  List banner = [];
  List topDataList = [];
  bool hasMore = true;

  List roundWords = [];
  int rondomIndex = 0;
  var timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
    _getTopicData();
    _getMore();

    timer = Timer.periodic(Duration(milliseconds: 4000), (timer) {
      setState(() {
        if (roundWords.length > 0) {
          rondomIndex++;
          if (rondomIndex >= roundWords.length) {
            rondomIndex = 0;
          }
        }
      });
    });
  }

  void _getTopicData() async {
    Response response = await Dio().post(
      'http://m.you.163.com/topic/index.json',
    );
    Map<String, dynamic> dataTopic = Map<String, dynamic>.from(response.data);
    setState(() {
      isFirstloading = false;
      dataList.addAll(dataTopic['data']['recommendList']);

      List findMore = dataTopic['data']['findMore'];
      if (findMore == null || findMore.isEmpty) {
        banner.add(dataTopic['data']['recommendOne']['picUrl']);
        topDataList.add(dataTopic['data']['recommendOne']['picUrl']);
      } else {
        findMore.forEach((item) {
          banner.add(item['itemPicUrl']);
          roundWords.add(item['subtitle']);
        });
        topDataList.addAll(findMore);
      }
    });
  }

  _getMore() async {
//    http://m.you.163.com/topic/v1/find/recAuto.json?page=3&size=5
    var params = {'page': page, 'size': pageSize};
    Response response = await Dio().post(
        'http://m.you.163.com/topic/v1/find/recAuto.json',
        queryParameters: params);
    Map<dynamic, dynamic> dataTopic = Map<dynamic, dynamic>.from(response.data);
    LogUtil.e(dataTopic);
    setState(() {
      page++;
      hasMore = dataTopic['data']['hasMore'];
      List result = dataTopic['data']['result'];
      result.forEach((item) {
        dataList.addAll(item['topics']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }

  buildBody() {
    if (isFirstloading) {
      return Loading();
    } else {
      return Container(
        child: StaggeredGridView.countBuilder(
            itemCount: dataList.length,
            primary: false,
            controller: _scrollController,
            crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            itemBuilder: (context, index) => buildCard(index),
            staggeredTileBuilder: (index) => StaggeredTile.fit(2)),
      );
    }
  }

  Widget buildSearch(BuildContext context) {
    Widget widget = Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Color(0x0D000000),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              roundWords.length > 0 ? roundWords[rondomIndex] : '',
              style: TextStyle(
                  color: Color.fromARGB(255, 102, 102, 102), fontSize: 16),
            ),
          ),
        ),
        Container(
          child: Text(
            '搜索',
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    ));
    return Router.link(widget, Util.search, context, {'id': ''});
  }

  Widget buildTopBanner() {
    return Swiper(
      itemCount: banner.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: CachedNetworkImage(
            imageUrl: (banner[index]),
          ),
        );
      },
      pagination: SwiperPagination(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(right: 5),
        builder: DotSwiperPaginationBuilder(
            color: Colors.grey[200], size: 8, activeColor: Colors.red[400]),
      ),
      controller: SwiperController(),
      scrollDirection: Axis.horizontal,
      autoplay: true,
      autoplayDelay: 4000,
      onTap: (index) => {
        Router.push(Util.webView, context, {'id': dataList[index]['linkUrl']})
      },
    );
  }

  buildCard(int index) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: CachedNetworkImage(
              imageUrl: dataList[index]['picUrl'],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(3, 5, 3, 5),
            child: Text(
              dataList[index]['title'],
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            child:Row(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      dataList[index]['avatar'] == null
                          ? ""
                          : dataList[index]['avatar'],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(dataList[index]['nickname'] == null
                          ? ''
                          : dataList[index]['nickname'],style: TextStyle(fontSize: 12),),
                    ),
                  ),
                ),
                Container(
                    child: dataList[index]['readCount'] == null
                        ? Container()
                        : Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                      size: 14,
                    )),
                Container(
                  child: Text(dataList[index]['readCount'] == null
                      ? ''
                      : (dataList[index]['readCount'] > 1000
                      ? '${int.parse((dataList[index]['readCount'] / 1000).toStringAsFixed(0))}K'
                      : '${dataList[index]['readCount']}'),style: TextStyle(fontSize: 12),),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
