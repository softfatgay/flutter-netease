import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/component/indicator_banner.dart';
import 'package:flutter_app/component/loading.dart';
import 'package:flutter_app/component/net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/ui/home/components/top_search.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/sort/component/vertical_tab.dart';
import 'package:flutter_app/ui/sort/model/bannerItem.dart';
import 'package:flutter_app/ui/sort/model/categoryGroupItem.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';
import 'package:flutter_app/ui/sort/model/sortData.dart';
import 'package:flutter_app/utils/local_storage.dart';

///分类
class SortPage extends StatefulWidget {
  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<SortPage> with AutomaticKeepAliveClientMixin {
  bool _firstLoading = true;

  int _rondomIndex = 0;
  var _timer;

  int _activeIndex = 0;

  String _categoryId = "";

  ///左侧tab
  List<CategoryL1Item> _categoryL1List = [];

  List<SortPageModel> _dataList = [];

  @override
  bool get wantKeepAlive => true;

  num? _totalNum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData("");
    _getTotalNum();
    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        _rondomIndex++;
        if (_rondomIndex >= 7) {
          _rondomIndex = 0;
        }
      });
    });
  }

  _getTotalNum() async {
    var sp = await LocalStorage.sp;
    setState(() {
      _totalNum = sp!.get(LocalStorage.totalNum) as num?;
    });
  }

  _getInitData(String id) async {
    var responseData = await sortData({"categoryId": "$id"});
    if (responseData.data != null) {
      var data = responseData.data;
      var sortDataModel = SortData.fromJson(data);
      setState(() {
        _firstLoading = false;
        if (_categoryL1List.isEmpty) {
          _categoryL1List = sortDataModel.categoryL1List ?? [];
          _dataList = List.filled(_categoryL1List.length, SortPageModel());
        }
        var data = SortPageModel(
            bannerList: sortDataModel.currentCategory!.bannerList ?? [],
            categoryGroupList: sortDataModel.categoryGroupList ?? []);
        _dataList[_activeIndex] = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<String?> newTabs = [];
    _categoryL1List.forEach((item) => newTabs.add(item.name));
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context, newTabs),
    );
  }

  _buildBody(BuildContext context, List<String?> newTabs) {
    return _firstLoading
        ? Loading()
        : Column(
            children: <Widget>[
              _buildSearch(context),
              Expanded(
                child: Row(
                  children: <Widget>[
                    VerticalTab(
                      tabs: newTabs,
                      onTabChange: (index) {
                        setState(() {
                          _activeIndex = index;
                        });
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
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 0.5, color: lineColor),
                            bottom: BorderSide(width: 0.5, color: lineColor),
                          ),
                        ),
                        child: _buildContent(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
  }

  _buildSearch(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: TopSearch(
        abool: true,
        totalNum: _totalNum,
      ),
    );
  }

  _buildContent() {
    var dataList = _dataList[_activeIndex];
    var bannerList = dataList.bannerList;
    var categoryGroupList = dataList.categoryGroupList;

    return categoryGroupList.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height / 2, child: Loading())
        : SingleChildScrollView(
            child: Column(
              children: [
                if (bannerList.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: IndicatorBanner(
                      dataList:
                          bannerList.map((e) => '${e.picUrl ?? ''}').toList(),
                      onPress: (index) {
                        var targetUrl = bannerList[index].targetUrl;
                        if (targetUrl!.isNotEmpty) {
                          Routers.push(
                              Routers.webView, context, {'url': targetUrl});
                        }
                      },
                      corner: 4,
                      fit: BoxFit.cover,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 110,
                    ),
                  ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: _dataListItems(bannerList, categoryGroupList),
                )
              ],
            ),
          );
  }

  _dataListItems(
      List<BannerItem> bannerList, List<CategoryGroupItem> categoryGroupList) {
    return Column(
      children: categoryGroupList.map<Widget>((item) {
        List<Category> itemItem = item.categoryList!;
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.name != null && item.name!.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: lineColor, width: 0.5),
                  )),
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "${item.name ?? ''}",
                    style: t16blackbold,
                  ),
                ),
              GridView.count(
                ///这两个属性起关键性作用，列表嵌套列表一定要有Container
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
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
                          child: NetImage(
                            imageUrl: item.wapBannerUrl,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            '${item.name ?? ''}',
                            style: t12black,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  );
                  return Routers.link(widget, Routers.catalogTag, context, {
                    'subCategoryId': item.id,
                    'categoryId': item.superCategoryId,
                  });
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }
}

class SortPageModel {
  List<BannerItem> bannerList;
  List<CategoryGroupItem> categoryGroupList;

  SortPageModel(
      {this.bannerList = const [], this.categoryGroupList = const []});
}
