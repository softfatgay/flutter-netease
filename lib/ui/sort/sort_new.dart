import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/vertical_tab.dart';

///分类
class SortNew extends StatefulWidget {
  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<SortNew> with AutomaticKeepAliveClientMixin{
  List tabs = [];

  bool isLoading = true;

  List roundWords = ['零食', '茅台酒', '床上用品', '衣服', '玩具', '奶粉', '背包'];
  int rondomIndex = 0;
  var timer;

  String categoryId = "";
  int activityTab = 0;
  List banner = [];
  List categoryGroupList = [];

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    List<String> newTabs = [];
    tabs.forEach((item) => newTabs.add(item['name']));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          buildSearch(context),
          Expanded(
            child: Row(
              children: <Widget>[
                VerticalTab(
                  tabs: newTabs,
                  onTabChange: (index) {
                    activityTab = index;
                    if (index == 0) {
                      categoryId = "";
                    } else {
                      categoryId = "${tabs[index]["id"]}";
                    }
                    _getInitData(categoryId);
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
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData("");
    timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        rondomIndex++;
        if (rondomIndex >= 7) {
          rondomIndex = 0;
        }
      });
    });
  }

  _getInitData(String id) async {
    isLoading = true;
    var responseData = await sortData({
      "csrf_token": "61f57b79a343933be0cb10aa37a51cc8",
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}",
      "categoryId": "$id"
    });
    var data = responseData.data;
    setState(() {
      isLoading = false;
      tabs = data["categoryL1List"];
      banner = data["currentCategory"]["bannerList"];
      categoryGroupList = data["categoryGroupList"];
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
          style: TextStyle(
              color: Color.fromARGB(255, 102, 102, 102), fontSize: 16),
        ),
      ),
    );
    Widget navBar = Column(
      children: [
        Container(
          color: Color.fromARGB(1, 255, 255, 255),
          height: MediaQuery.of(context).padding.top,
        ),
        widget
      ],
    );
    return Routers.link(
        navBar, Util.search, context, {'id': roundWords[rondomIndex]});
  }

  Widget buildContent() {
    return isLoading
        ? Loading()
        : MediaQuery.removePadding(
        removeTop: true,
        context: context, child: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: splitLineColor))),
                  padding: EdgeInsets.all(10),
                  height: 120,
                  child: CachedNetworkImage(
                    imageUrl: banner[0]["picUrl"] == null
                        ? ""
                        : banner[0]["picUrl"],
                    fit: BoxFit.fill,
                  ),
                );
              }, childCount: 1),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                List itemItem = categoryGroupList[index]["categoryList"];
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${categoryGroupList[index]["name"] == null ? "" : categoryGroupList[index]["name"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              height: 1,
                              color: splitLineColor,
                            ),
                          ],
                        ),
                      ),
                      GridView.count(
                        ///这两个属性起关键性作用，列表嵌套列表一定要有Container
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                        children: itemItem.map<Widget>((item) {
                          Widget widget = Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl: item["wapBannerUrl"],
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: Text(
                                    item["name"],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          );
                          return Routers.link(
                            widget,
                            Util.catalogTag,
                            context,
                            {
                              'subCategoryId': item['id'],
                              'categoryId': item['superCategoryId'],
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              },
              childCount: categoryGroupList.length,
            ),
          ),
        )
      ],
    ));
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
