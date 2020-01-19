import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/vertical_tab.dart';

///分类
class Sort extends StatefulWidget {
  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<Sort> {
  List tabs = [];

  bool isLoading = true;

  int goodCount = 0;

  bool isRequest = true;

  Map currentCategory;

  List roundWords = ['零食', '茅台酒', '床上用品', '衣服', '玩具', '奶粉', '背包'];
  int rondomIndex = 0;
  var timer;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Loading();
    } else {
      List<String> newTabs = [];
      tabs.forEach((item) => newTabs.add(item['name']));
      return Column(
        children: <Widget>[
          buildSearch(context),
          Expanded(
            child: Row(
              children: <Widget>[
                VerticalTab(
                  tabs: newTabs,
                  onTabChange: (index) {
                    getCategoryMsg(tabs[index]['id']);
                  },
                  activeIndex: 0,
                ),
                Expanded(
                  child: buildContent(),
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData();
    timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        rondomIndex++;
        if (rondomIndex>=7) {
          rondomIndex = 0;
        }
      });
    });
  }

  _getInitData() async {
    var response = await Future.wait([Api.getSortTabs(), Api.getGoodsCount()]);

    setState(() {
      tabs = response[0].data['categoryList'];
      goodCount = response[1].data['goodsCount'];
      isLoading = false;
    });

    if (tabs.isNotEmpty) {
      var id = response[0].data['categoryList'][0]['id'];
      getCategoryMsg(id);
    }
  }

  getCategoryMsg(id) async {
    setState(() {
      isRequest = true;
    });

    Response response = await Api.getCategoryMsg(id: id);

    setState(() {
      currentCategory = response.data['currentCategory'];
      isRequest = false;
    });
  }

  Widget buildSearch(BuildContext context) {
    Widget widget = Container(
      height: 40,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 237, 237, 237),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Text(
          roundWords[rondomIndex],
          style: TextStyle(color: Color.fromARGB(255, 102, 102, 102), fontSize: 16),
        ),
      ),
    );
    return Router.link(widget, Util.search, context, {'id': roundWords[rondomIndex]});
  }

  Widget buildContent() {
    if (isRequest) {
      return Loading();
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              Widget widget = Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      height: 120,
                      child: CachedNetworkImage(
                        imageUrl: currentCategory['wap_banner_url'],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: 120,
                      child: Center(
                        child: Text(
                          '${currentCategory['front_name']}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              );
              return Router.link(widget, Util.catalogTag, context, {'id': currentCategory['id']});
            }, childCount: 1),
          ),
          SliverPadding(
            padding: EdgeInsets.all(4.0),
            sliver: SliverGrid(
              delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
                Widget widget = Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: currentCategory['subCategoryList'][index]
                          ['wap_banner_url'],
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Text(
                          currentCategory['subCategoryList'][index]['name'],
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                );
                return Router.link(widget, Util.catalogTag, context,
                    {'id': currentCategory['subCategoryList'][index]['id']});
              }, childCount: currentCategory['subCategoryList'].length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                childAspectRatio: 0.8,
                crossAxisSpacing: 1,
              ),
            ),
          )
        ],
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }
}
