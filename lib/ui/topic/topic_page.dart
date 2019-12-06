import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/loading.dart';

class TopicPage extends StatefulWidget {
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  static String loadingTag = '##loading##';

  ///第一次加载
  bool isFirstloading = true;
  final int pageSize = 6;
  int page = 1;
  int total = 0;
  List topicData = ['##loading##'];

  @override
  Widget build(BuildContext context) {
    if (isFirstloading) {
      return Loading();
    } else {
      return RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView.builder(
          itemCount: topicData.length,
          itemBuilder: (context, index) {
            //如果到了尾部
            if (topicData[index] == loadingTag) {
              if (topicData.length - 1 < total) {
                getMore();
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                );
              } else {
                //没有更多了
                return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "没有更多了",
                      style: TextStyle(color: Colors.grey),
                    ));
              }
            }
            Widget widget = Card(
              color: Colors.white,
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: topicData[index]['scene_pic_url'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                      child: Center(
                        child: Text(
                          '${topicData[index]['title']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      child: Center(
                        child: Text(
                          '${topicData[index]['subtitle']}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
            return Router.link(widget, Util.topicDetail, context,
                {'id': topicData[index]['id']});
          },
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData();
  }

  // 第一次加载
  _getInitData() async {
    Response data = await Api.getTopicData(page: 1, size: pageSize);
    topicData.insertAll(0, data.data['data']);
    setState(() {
      isFirstloading = false;
      page = 2;
      total = data.data['count'];
    });
  }

// 下拉刷新数据
  Future<Null> _handleRefresh() async {
    Response data = await Api.getTopicData(page: 1, size: pageSize);
    List newData = ['##loading##'];
    newData.insertAll(0, data.data['data']);
    setState(() {
      page = 2;
      total = data.data['count'];
      topicData = newData;
    });
    return null;
  }

  getMore() async {
    Response data = await Api.getTopicData(page: page, size: pageSize);
    topicData.insertAll(topicData.length - 1, data.data['data']);
    setState(() {
      page++;
      total = data.data['count'];
    });
    //延迟
    Future.delayed(Duration(seconds: 2)).then((e) async {});
  }
}
