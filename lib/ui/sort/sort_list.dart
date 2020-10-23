import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
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
  bool isLoading = true;
  bool firstLoading = true;

  bool footLoading = true;
  List catalogList = [];
  int activeIndex = 0;
  TabController mController;

  List itemList = [];
  var category;
  int id = 0;

  @override
  Widget build(BuildContext context) {
    List<String> tabItem = [];
    for (int i = 0; i < (catalogList.length); i++) {
      tabItem.add(catalogList[i]["name"]);
    }
    return Scaffold(
      appBar: prefix0.TabAppBar(
        controller: mController,
        tabs: tabItem,
        title: '${tabItem.length > 0 ? tabItem[activeIndex] : ''}',
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
    mController = TabController(length: catalogList.length, vsync: this);
    var responseData = await sortListData({
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}",
      "categoryType": "0",
      "subCategoryId": id,
      "categoryId": widget.arguments["categoryId"],
    });

    print("========================================");
    print(responseData.data);

    var data = responseData.data;
    setState(() {
      catalogList = data["categoryL2List"];
      itemList = data["categoryItems"]["itemList"];
      category = data["categoryItems"]["category"];
      isLoading = false;

      if (firstLoading) {
        for (int i = 0; i < (catalogList.length); i++) {
          if (widget.arguments['subCategoryId'] == catalogList[i]['id']) {
            activeIndex = i;
          }
        }
        firstLoading = false;
      }

      mController = TabController(
          length: catalogList.length, vsync: this, initialIndex: activeIndex);
    });

    mController.addListener(() {
      setState(() {
        activeIndex = mController.index;
        id = catalogList[activeIndex]["id"];
        category = catalogList[activeIndex];
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mController.dispose();
  }

  _buildBody(BuildContext context) {
    return Container(
      child: isLoading
          ? Loading()
          : TabBarView(
              children: catalogList.map((item) {
                return SortListItem(arguments: item);
              }).toList(),
              controller: mController,
            ),
    );
  }
}
