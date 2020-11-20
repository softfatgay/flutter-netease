import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/MyUnderlineTabIndicator.dart';
import 'package:flutter_app/widget/SliverTabBarDelegate.dart';
import 'package:flutter_app/widget/colors.dart';

class Hotlist extends StatefulWidget {
  @override
  _HotlistState createState() => _HotlistState();
}

class _HotlistState extends State<Hotlist> with TickerProviderStateMixin{
  List currentCategory, itemList = List();
  int currentCategoryId = 0;
  int currentSubCategoryId = 0;

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    _getCat();
    _getItemList();
  }

  _getCat() async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}",
      "categoryId": 0,
      "subCategoryId": 0,
    };
    Map<String, dynamic> header = {"Cookie": cookie};

    var responseData = await hotListCat(params, header: header);
    setState(() {
      currentCategory = responseData.OData['currentCategory']['subCateList'];
      _tabController = TabController(length: currentCategory.length, vsync: this);
    });
  }

  _getItemList() async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "categoryId": currentCategoryId,
      "subCategoryId": currentSubCategoryId,
    };
    Map<String, dynamic> header = {"Cookie": cookie};

    var responseData = await hotList(params, header: header);
    setState(() {
      itemList = responseData.data['itemList'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool) {
          return [
            SliverAppBar(
              expandedHeight: 100.0,
              floating: true,
              pinned: true,
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              shadowColor: Colors.transparent,
              title: Container(
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: textBlack,
                        size: 28,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '拼团',
                      style: TextStyle(color: textBlack),
                    )
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                // centerTitle: true,
                  background: Image(
                    image: AssetImage("assets/images/stadurday_buy.png"),
                    fit: BoxFit.fitHeight,
                  )),
            ),
            SliverPersistentHeader(
              delegate: new SliverTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: currentCategory
                        .map((f) => Tab(text: f['name']))
                        .toList(),
                    indicator: MyUnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0, color: redColor),
                    ),
                    indicatorColor: Colors.red,
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.red,
                    isScrollable: true,
                  ),
                  color: Colors.white,
                  back: Icon(Icons.keyboard_backspace)),
              pinned: true,
            ),
          ];
        },
        body: Container(

        ),
      ),
    );
  }
}
