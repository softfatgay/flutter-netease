import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/ui/child_fenlei/cataLog.dart';
import 'package:flutter_app/widget/tab_app_bar.dart' as prefix0;
import 'package:flutter_app/widget/loading.dart';

class SortChild extends StatefulWidget {
  Map arguments;

  SortChild({this.arguments});

  @override
  _SortChildState createState() => _SortChildState();
}

class _SortChildState extends State<SortChild> with TickerProviderStateMixin {
  bool isLoading = true;
  bool footLoading = true;
  List<dynamic> catalogList = [];
  int activeIndex;
  TabController mController;

  @override
  Widget build(BuildContext context) {
    List<String> tabItem = [];
    for (int i = 0; i < (catalogList.length); i++) {
      tabItem.add(catalogList[i]['name']);
    }

    return Scaffold(
      appBar: prefix0.TabAppBar(
        controller: mController,
        tabs: tabItem,
        title: '${tabItem.length > 0 ? tabItem[activeIndex] : '奇趣'}分类',
      ).build(context),
      body: Container(
        child: isLoading
            ? Loading()
            : TabBarView(
                children: catalogList.map((item) {
                  return CatalogGoods(item['id']);
                }).toList(),
                controller: mController,
              ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitdata();
  }

  _getInitdata() async {
    Response data = await Api.getBrotherCatalog(id: widget.arguments['id']);
    List<dynamic> brotherCategory = data.data['brotherCategory'];
    int index;
    for (int i = 0; i < (brotherCategory.length); i++) {
      if (widget.arguments['id'] == brotherCategory[i]['id']) {
        index = i;
      }
    }
    mController = TabController(length: catalogList.length, vsync: this);
    setState(() {
      isLoading = false;
      catalogList = brotherCategory;
      activeIndex = index;
      mController = TabController(
          length: brotherCategory.length, vsync: this, initialIndex: index);
    });

    mController.addListener(() {
      setState(() {
        activeIndex = mController.index;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mController.dispose();
  }
}
