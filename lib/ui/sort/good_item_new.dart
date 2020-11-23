import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GoodItemNewWidget extends StatelessWidget {
  final List dataList;

  const GoodItemNewWidget({Key key, this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _stagegeredGridview(dataList);
  }

  _stagegeredGridview(List data) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      sliver: SliverStaggeredGrid.countBuilder(
        itemCount: data.length,
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        staggeredTileBuilder: (index) => new StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return _buildItem(context, data, index);
        },
      ),
    );
  }

  _buildGoodItem(BuildContext context, int index, List<dynamic> dataList) {
    var item = dataList[index];
    List itemTagList = dataList[index]["itemTagList"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Color(0x33E9E9E8),
          child: Stack(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                        height: 250,
                        imageUrl: item['listPicUrl'],
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  (item["listPromBanner"] == null ||
                          !item["listPromBanner"]['valid'])
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
                        border: Border.all(color: Color(0xFFA28C63), width: 1),
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
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(dataList[index]["name"]),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5,),
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
            SizedBox(width: 5,),
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
                          margin: EdgeInsets.symmetric(horizontal: 5),
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 30,
            child: CachedNetworkImage(
              imageUrl: item["bannerContentUrl"],
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: item["bannerTitleUrl"],
                        height: 35,
                        width: 70,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        width: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                item["promoTitle"] ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              item["promoSubTitle"] ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
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
                      item["content"] ?? "",
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

  _buildItem(BuildContext context, List data, int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(color: Colors.white),
      child: _buildGoodItem(context, index, data),
    );
  }
}
