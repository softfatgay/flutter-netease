import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/utils/widget_util.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/footer.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/slivers.dart';

class SortListItem extends StatefulWidget {
  var arguments;

  SortListItem({this.arguments});

  @override
  _CatalogGoodsState createState() => _CatalogGoodsState();
}

///AutomaticKeepAliveClientMixin  保持滑动不刷新  重写方法 bool get wantKeepAlive => true;
class _CatalogGoodsState extends State<SortListItem>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  int total = 0;
  List dataList = [];

  bool moreLoading = false;

  ScrollController _scrollController = new ScrollController();

  List itemList = [];
  var category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData();

    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!moreLoading && (total > dataList.length)) {
          // _getMore();
        }
      }
    });
  }

  _getInitData() async {
    var map = {
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}",
      "categoryType": "0",
      "subCategoryId": widget.arguments["id"],
      "categoryId": widget.arguments["superCategoryId"],
    };
    var responseData = await sortListData(map);
    print("========================================");
    print(responseData.data);
    var data = responseData.data;
    setState(() {
      dataList = data["categoryItems"]["itemList"];
      category = data["categoryItems"]["category"];
      isLoading = false;
      total = dataList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Loading();
    } else {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            category["frontName"] == null || category["frontName"] == ""
                ? singleSliverWidget(Container())
                : SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    sliver: singleSliverWidget(Container(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(category["frontName"]),
                      ),
                    )),
                  ),
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Widget widget = Container(
                    padding: EdgeInsets.only(bottom: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: _buildGoodItem(context, index, dataList),
                  );
                  return GestureDetector(
                    child: widget,
                    onTap: () {
                      Router.push(Util.goodDetailTag, context,
                          {'id': dataList[index]['id']});
                    },
                  );
                }, childCount: dataList.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.52,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
              ),
            ),
            WidgetUtil.buildASingleSliver(buildFooter()),
          ],
        ),
      );
    }
  }

  Future _refresh() async {
    _getInitData();
  }

  Widget buildFooter() {
    if (dataList.length == total) {
      return NoMoreText();
    } else {
      return Loading();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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
}
