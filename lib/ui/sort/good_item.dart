import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/slivers.dart';

class GoodItemWidget extends StatelessWidget {
  final List dataList;

  const GoodItemWidget({Key key, this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildrecommond(dataList);
  }

  _buildrecommond(List data) {
    return data.isEmpty
        ? buildASingleSliverGrid(Container(), 2)
        : SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                Widget widget = Container(
                  padding: EdgeInsets.only(bottom: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: _buildGoodItem(context, index, data),
                );
                return GestureDetector(
                  child: widget,
                  onTap: () {
                    Routers.push(
                        Util.goodDetailTag, context, {'id': data[index]['id']});
                  },
                );
              }, childCount: data.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.52,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
            ),
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
        (itemTagList == null || itemTagList.isEmpty)
            ? Container()
            : Row(
                children: itemTagList
                    .map((item) => Container(
                          padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
