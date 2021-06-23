import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/model/itemTagListItem.dart';
import 'package:flutter_app/ui/sort/model/listPromBanner.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/MyVerticalText.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/top_round_net_image.dart';

class GoodItemNormalWidget extends StatelessWidget {
  final List<ItemListItem> dataList;

  const GoodItemNormalWidget({Key key, this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildrecommond(dataList);
  }

  _buildrecommond(List<ItemListItem> data) {
    return data.isEmpty
        ? buildASingleSliverGrid(Container(), 2)
        : SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            sliver: SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                Widget widget = Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: _buildGoodItem(context, index, data),
                );
                return GestureDetector(
                  child: widget,
                  onTap: () {
                    print(data[index]);
                    Routers.push(
                        Routers.goodDetailTag, context, {'id': data[index].id});
                  },
                );
              }, childCount: data.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.52,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5),
            ),
          );
  }

  _buildGoodItem(BuildContext context, int index, List<ItemListItem> dataList) {
    var item = dataList[index];
    var itemTagList = dataList[index].itemTagList;
    return Container(
      decoration: BoxDecoration(
        color: backWhite,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x33E9E9E8),
                borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
              ),
              child: Stack(
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: TopRoundNetImage(
                              url: item.listPicUrl,
                              corner: 3,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                      (item.promTag == null || item.listPromBanner == null)
                          ? _buildTextDesc(item.simpleDesc)
                          : _buildPromBanner(item.listPromBanner),
                    ],
                  ),
                  dataList[index].productPlace == null ||
                          dataList[index].productPlace == ""
                      ? Container()
                      : Container(
                          padding: EdgeInsets.fromLTRB(1, 2, 1, 2),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFFA28C63), width: 1),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: MyVerticalText(
                              dataList[index].productPlace,
                              TextStyle(
                                  color: Color(0xFFA28C63), fontSize: 12))),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              dataList[index].name,
              style: t14blackBold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          _buildTags(itemTagList),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 5),
              Text(
                "¥${dataList[index].retailPrice}",
                style: t18redBold,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                dataList[index].counterPrice == null
                    ? ""
                    : "¥${dataList[index].counterPrice}",
                style: TextStyle(
                    color: textGrey,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }

  _buildTags(List<ItemTagListItem> itemTagList) {
    if (itemTagList == null || itemTagList.isEmpty) {
      return Container();
    } else {
      if (itemTagList.length > 3) {
        itemTagList.removeRange(2, itemTagList.length - 1);
      }
      return Row(
        children: itemTagList
            .map((item) => Container(
                  padding: EdgeInsets.fromLTRB(4, 2, 4, 1),
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: backLightRed),
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 9,
                      color: textRed,
                      height: 1.1,
                    ),
                  ),
                ))
            .toList(),
      );
    }
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
  _buildPromBanner(ListPromBanner item) {
    return Container(
      height: 30,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: 25,
            child: CachedNetworkImage(
              imageUrl: item.bannerContentUrl,
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
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage(item.bannerTitleUrl),
                          fit: BoxFit.fill,
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                item.promoTitle ?? "",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: t12whiteBold,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  item.promoSubTitle ?? "",
                                  textAlign: TextAlign.center,
                                  style: t12whiteBold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
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
                      item.content ?? "",
                      style: TextStyle(fontSize: 11, color: Colors.white),
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
