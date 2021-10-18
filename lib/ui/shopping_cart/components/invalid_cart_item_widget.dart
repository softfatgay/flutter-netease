import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/shopping_cart/model/carItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/cartItemListItem.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/util_mine.dart';

typedef void ClearInvalida();

class InvalidCartItemWidget extends StatelessWidget {
  final List<CarItem>? invalidCartGroupList;
  final ClearInvalida? clearInvalida;

  const InvalidCartItemWidget(
      {Key? key, this.invalidCartGroupList, this.clearInvalida})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (invalidCartGroupList == null || invalidCartGroupList!.length == 0)
        ? Container()
        : Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: lineColor, width: 0.3))),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '失效商品',
                      style: t16black,
                    )),
                    GestureDetector(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: lineColor, width: 0.5),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          '清除失效商品',
                          style: t14black,
                        ),
                      ),
                      onTap: () {
                        if (clearInvalida != null) {
                          clearInvalida!();
                        }
                      },
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildInvalidItem(
                      context, invalidCartGroupList![index]);
                },
                itemCount: invalidCartGroupList!.length,
              ),
            ],
          );
  }

  // 无效商品列表Item
  Widget _buildInvalidItem(BuildContext context, CarItem itemD) {
    List<CartItemListItem> items = itemD.cartItemList!;
    return Column(
      children: items.map<Widget>((item) {
        Widget widget = Container(
          margin: EdgeInsets.only(bottom: 0.5),
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    child: item.sellVolume == 0
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: textLightGrey,
                                borderRadius: BorderRadius.circular(3)),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Text(
                                "售罄",
                                style: t12white,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: backGrey,
                        borderRadius: BorderRadius.circular(4)),
                    height: 90,
                    width: 90,
                    child: CachedNetworkImage(imageUrl: item.pic!),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              '${item.itemName}',
                              style: t14grey,
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 1),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: lineColor, width: 0.5),
                                borderRadius: BorderRadius.circular(2),
                                color: Color(0xFFFAFAFA),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                2),
                                    child: Text(
                                      '${_specValue(item)}',
                                      style: t12grey,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // item.id != 0
                                  //     ? Image.asset(
                                  //   'assets/images/arrow_down.png',
                                  //   width: 10,
                                  //   height: 10,
                                  // )
                                  //     : Container()
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '¥${item.retailPrice}',
                                  style: t14grey,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
        return Routers.link(widget, Routers.goodDetail, context,
            {'id': item.itemId.toString()});
      }).toList(),
    );
  }

  _specValue(CartItemListItem item) {
    List<SpecListItem> specList = item.specList!;
    String specName = '';
    for (var value in specList) {
      specName += value.specValue!;
      specName += "; ";
    }
    var replaceRange =
        specName.replaceRange(specName.length - 2, specName.length - 1, "");
    return replaceRange;
  }
}
