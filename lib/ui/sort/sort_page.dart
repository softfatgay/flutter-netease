import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/ui/sort/model/bannerItem.dart';
import 'package:flutter_app/ui/sort/model/categoryGroupItem.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';
import 'package:flutter_app/ui/sort/model/sortData.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/vertical_tab.dart';

///分类
class SortPage extends StatefulWidget {
  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<SortPage> with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;

  List _roundWords = ['零食', '茅台酒', '床上用品', '衣服', '玩具', '奶粉', '背包'];
  int _rondomIndex = 0;
  var timer;

  String _categoryId = "";
  int _activityTab = 0;

  ///左侧tab
  List<CategoryL1Item> _categoryL1List;

  ///右侧头部banner
  List<BannerItem> _bannerList;

  ///body数据
  List<CategoryGroupItem> _categoryGroupList;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    List<String> newTabs = [];
    if (_categoryL1List != null) {
      _categoryL1List.forEach((item) => newTabs.add(item.name));
    }
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
                    _activityTab = index;
                    if (index == 0) {
                      _categoryId = "";
                    } else {
                      _categoryId = "${_categoryL1List[index].id}";
                    }
                    _getInitData(_categoryId);
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
        _rondomIndex++;
        if (_rondomIndex >= 7) {
          _rondomIndex = 0;
        }
      });
    });
  }

  _getInitData(String id) async {
    _isLoading = true;
    var responseData = await sortData({
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}",
      "categoryId": "$id"
    });
    if (responseData.data != null) {
      var data = responseData.data;
      var sortDataModel = SortData.fromJson(data);
      setState(() {
        _isLoading = false;
        _categoryL1List = sortDataModel.categoryL1List;
        _bannerList = sortDataModel.currentCategory.bannerList;
        _categoryGroupList = sortDataModel.categoryGroupList;
      });
    }
  }

  Widget buildSearch(BuildContext context) {
    Widget widget = Container(
      height: 35,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 237, 237, 237),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.search,
            size: 20,
            color: textGrey,
          ),
          Text(
            "搜索商品，共30000+款好物",
            style: t12grey,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
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
        navBar, Routers.search, context, {'id': _roundWords[_rondomIndex]});
  }

  Widget buildContent() {
    return _isLoading
        ? Loading()
        : MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: splitLineColor)),
                      ),
                      padding: EdgeInsets.all(10),
                      height: 120,
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: backColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: CachedNetworkImage(
                            imageUrl: _bannerList[0].picUrl ?? '',
                            fit: BoxFit.fill,
                          ),
                        ),
                        onTap: () {
                          Routers.push(Routers.webView, context, {
                            'url':
                                '${NetContants.baseUrl}${_bannerList[0].targetUrl}'
                          });
                        },
                      ),
                    );
                  }, childCount: 1),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        List<Category> itemItem =
                            _categoryGroupList[index].categoryList;
                        // List itemItem = _categoryGroupList[index].categoryList;
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
                                      "${_categoryGroupList[index].name ?? ''}",
                                      style: t16blackbold,
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
                                          imageUrl: item.wapBannerUrl,
                                        )),
                                        Container(
                                          margin: EdgeInsets.only(top: 6),
                                          child: Text(
                                            item.name,
                                            style: t12black,
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                  return Routers.link(
                                      widget, Routers.catalogTag, context, {
                                    'subCategoryId': item.id,
                                    'categoryId': item.superCategoryId,
                                  });
                                }).toList(),
                              )
                            ],
                          ),
                        );
                      },
                      childCount: _categoryGroupList.length,
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
