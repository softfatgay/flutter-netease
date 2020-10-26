import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_custom_header_delegate.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class NewItemPage extends StatefulWidget {
  final Map arguments;

  const NewItemPage({Key key, this.arguments}) : super(key: key);

  @override
  _KingKongPageState createState() => _KingKongPageState();
}

class _KingKongPageState extends State<NewItemPage> {
  var banner, dataList = List();
  bool initLoading = true;
  var currentCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getInitData();
  }

  void _getInitData() async {
    String schemeUrl = widget.arguments["schemeUrl"];
    print("////////////////////////////////////");
    print(schemeUrl);

    if (schemeUrl.contains("categoryId")) {
    } else {
      _getNewData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: initLoading
          ? Loading()
          : CustomScrollView(
              slivers: [
                _buildTitle(context),
                singleSliverWidget(Container(height: 20,)),
                _buildNewItems(context),
              ],
            ),
    );
  }

  _buildTitle(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverCustomHeaderDelegate(
        title: '全部',
        collapsedHeight: 50,
        expandedHeight: 200,
        paddingTop: MediaQuery.of(context).padding.top,
        child: _buildSwiper(context),
      ),
    );
  }


  //轮播图
  _buildSwiper(BuildContext context) {
    return BannerCacheImg(
      imageList: banner,
      onTap: (index) {
        Routers.push(Util.image, context, {'id': '${banner[index]}'});
      },
    );
  }



  _buildGoodItem(BuildContext context, int index, List<dynamic> dataList) {
    var item = dataList[index];
    List itemTagList = dataList[index]["itemTagList"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            color: Color(0x33E9E9E8),
            child: Stack(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            height: 300,
                            width: double.infinity,
                            imageUrl: item['listPicUrl'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    item["listPromBanner"] == null
                        ? _buildTextDesc(item["simpleDesc"])
                        : _buildPromBanner(item["listPromBanner"]),
                  ],
                ),
                dataList[index]["productPlace"] == null ||
                        dataList[index]["productPlace"] == ""
                    ? Container()
                    : Container(
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFA28C63), width: 1),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          dataList[index]["productPlace"],
                          style:
                              TextStyle(color: Color(0xFFA28C63), fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(dataList[index]["name"]),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "¥${dataList[index]["retailPrice"]}",
              style: TextStyle(color: textRed, fontSize: 16),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              dataList[index]["counterPrice"] == null
                  ? ""
                  : "¥${dataList[index]["counterPrice"]}",
              style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: itemTagList
              .map((item) => Container(
                    padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: redColor)),
                    child: Text(
                      item["name"],
                      style: TextStyle(color: textRed, fontSize: 12),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }

  ///仅描述
  _buildTextDesc(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      color: Color(0xFFEDE8DB),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Color(0xFF958259), fontSize: 12),
        textAlign: TextAlign.start,
      ),
    );
  }

  ///特价描述
  _buildPromBanner(item) {
    return Container(
      height: 35,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: 30,
            child: CachedNetworkImage(
              imageUrl: item["bannerContentUrl"],
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: item["bannerTitleUrl"],
                        height: 35,
                        width: 60,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              item["promoTitle"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item["promoSubTitle"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      item["content"],
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _getNewData() async {
    print("!!!!!!!!!!!!!!!!!!!!!!");
    var responseData = await kingKongNewItemData({
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    });
    setState(() {
      dataList = responseData.newItems["itemList"];
      List bannerList = responseData.OData["newItemAds"];
      banner = bannerList.map((item) => item["picUrl"]).toList();

      initLoading = false;
    });
  }

  _buildNewItems(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        Widget widget = Container(
          padding: EdgeInsets.only(bottom: 5),
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.transparent),
          child: _buildGoodItem(context, index, dataList),
        );
        return GestureDetector(
          child: widget,
          onTap: () {
            Routers.push(
                Util.goodDetailTag, context, {'id': dataList[index]['id']});
          },
        );
      }, childCount: dataList.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.52,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
    );
  }

  _bodyTitle(value) {
    return singleSliverWidget(Container(
      padding: EdgeInsets.all(15),
      child: Text(
        "新品",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
