import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/ui/sort/model/sortListData.dart';
import 'package:flutter_app/ui/sort/sort_list_item.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/tab_app_bar.dart' as prefix0;

class SortList extends StatefulWidget {
  Map arguments;

  SortList({this.arguments});

  @override
  _SortChildState createState() => _SortChildState();
}

class _SortChildState extends State<SortList> with TickerProviderStateMixin {
  bool _isLoading = true;
  bool _firstLoading = true;

  int _activeIndex = 0;
  TabController _mController;
  List<Category> _catalogList = [];
  int id = 0;
  @override
  Widget build(BuildContext context) {
    List<String> tabItem = [];
    for (int i = 0; i < (_catalogList.length); i++) {
      tabItem.add(_catalogList[i].name);
    }
    return Scaffold(
      appBar: prefix0.TabAppBar(
        controller: _mController,
        tabs: tabItem,
        title: '${tabItem.length > 0 ? tabItem[_activeIndex] : ''}',
      ).build(context),
      body: _buildBody(context),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.arguments["subCategoryId"];
    _getInitData();
  }

  _getInitData() async {
    // https://m.you.163.com/item/list.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603184092320&categoryType=0&subCategoryId=109284000&categoryId=1005002
    _mController = TabController(length: _catalogList.length, vsync: this);
    var responseData = await sortListData({
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}",
      "categoryType": "0",
      "subCategoryId": id,
      "categoryId": widget.arguments["categoryId"],
    });
    var data = responseData.data;
    var sortListDataModel = SortListData.fromJson(data);

    setState(() {
      _catalogList = sortListDataModel.categoryL2List;
      _isLoading = false;

      if (_firstLoading) {
        for (int i = 0; i < (_catalogList.length); i++) {
          if (widget.arguments['subCategoryId'] == _catalogList[i].id) {
            _activeIndex = i;
          }
        }
        _firstLoading = false;
      }

      _mController = TabController(
          length: _catalogList.length, vsync: this, initialIndex: _activeIndex);
    });
    _mController.addListener(() {
      setState(() {
        _activeIndex = _mController.index;
        id = _catalogList[_activeIndex].id;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mController.dispose();
  }

  _buildBody(BuildContext context) {
    return Container(
      child: _isLoading
          ? Loading()
          : TabBarView(
              children: _catalogList.map((item) {
                return SortListItem(arguments: item);
              }).toList(),
              controller: _mController,
            ),
    );
  }
}
