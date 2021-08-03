import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/ui/home/components/top_search.dart';
import 'package:flutter_app/ui/sort/model/bannerItem.dart';
import 'package:flutter_app/ui/sort/model/categoryGroupItem.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';
import 'package:flutter_app/ui/sort/model/sortData.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/round_net_image.dart';
import 'package:flutter_app/widget/vertical_tab.dart';

///分类
class SortPage extends StatefulWidget {
  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<SortPage> with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;

  int _rondomIndex = 0;
  var _timer;

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
          _buildSearch(context),
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1, color: splitLineColor),
                        bottom: BorderSide(width: 1, color: splitLineColor),
                      ),
                    ),
                    child: _buildContent(),
                  ),
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
    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
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
    var responseData = await sortData({"categoryId": "$id"});
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

  _buildSearch(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: TopSearch(
        abool: true,
      ),
    );
  }

  _buildContent() {
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
                      padding: EdgeInsets.all(10),
                      height: 120,
                      child: GestureDetector(
                        child: Container(
                            decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: RoundNetImage(
                              url: _bannerList[0].picUrl ?? '',
                              fit: BoxFit.cover,
                            )),
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
                              _categoryGroupList[index].name == null ||
                                      _categoryGroupList[index].name.isEmpty
                                  ? Container()
                                  : Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            color: lineColor, width: 1),
                                      )),
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "${_categoryGroupList[index].name ?? ''}",
                                        style: t16blackbold,
                                      ),
                                    ),
                              GridView.count(
                                ///这两个属性起关键性作用，列表嵌套列表一定要有Container
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.8,
                                children: itemItem.map<Widget>((item) {
                                  Widget widget = Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: CachedNetworkImage(
                                            imageUrl: item.wapBannerUrl,
                                          ),
                                        ),
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
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
