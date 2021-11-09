import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopping_cart/model/carItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/cartItemListItem.dart';

typedef void ClearInvalid();

class InvalidCartItemWidget extends StatelessWidget {
  final List<CarItem> invalidCartGroupList;
  final ClearInvalid clearInvalid;

  const InvalidCartItemWidget(
      {Key? key,
      required this.invalidCartGroupList,
      required this.clearInvalid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (invalidCartGroupList.isEmpty)
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
                            EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: textBlack, width: 0.5),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          '清除失效商品',
                          style: t13black,
                        ),
                      ),
                      onTap: () {
                        clearInvalid();
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
                      context, invalidCartGroupList[index]);
                },
                itemCount: invalidCartGroupList.length,
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
          child: Row(
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: Text(
                            "售罄",
                            style: t12white,
                          ),
                        ),
                      )
                    : Container(),
              ),
              RoundNetImage(
                url: item.pic,
                backColor: backGrey,
                corner: 4,
                height: 90,
                width: 90,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.itemName}',
                        style: t14grey,
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                          decoration: BoxDecoration(
                            border: Border.all(color: lineColor, width: 0.5),
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
                                        MediaQuery.of(context).size.width / 2),
                                child: Text(
                                  '${_specValue(item)}',
                                  style: t12grey,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
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
