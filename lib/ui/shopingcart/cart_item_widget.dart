import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/shopingcart/model/carItem.dart';
import 'package:flutter_app/ui/shopingcart/model/cartItemListItem.dart';
import 'package:flutter_app/ui/shopingcart/model/redeemModel.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/cart_check_box.dart';
import 'package:flutter_app/widget/shopping_cart_count.dart';

typedef void NumChange(num source, num type, num skuId, num cnt, String extId);
typedef void CheckOne(CarItem itemData, num source, num type, num skuId,
    bool check, String extId);

typedef void DeleteCheckItem(
    bool check, CarItem itemData, CartItemListItem item);
typedef void GoRedeem(CarItem itemData);

class CartItemWidget extends StatelessWidget {
  final NumChange numChange;
  final CheckOne checkOne;
  final GoRedeem goRedeem;
  final DeleteCheckItem deleteCheckItem;
  final List<CarItem> itemList;
  final bool isEdit;

  const CartItemWidget(
      {Key key,
      this.numChange,
      this.checkOne,
      this.goRedeem,
      this.deleteCheckItem,
      this.itemList,
      this.isEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        CarItem itemData = itemList[index];
        List<CartItemListItem> _itemList = [];

        ///换购
        List<AddBuyStepListItem> addBuyStepList = itemData.addBuyStepList;
        if (addBuyStepList != null && addBuyStepList.isNotEmpty) {
          addBuyStepList.forEach((element_1) {
            var addBuyItemList = element_1.addBuyItemList;
            if (addBuyItemList != null && addBuyItemList.isNotEmpty) {
              addBuyItemList.forEach((element_2) {
                if (element_2.checked) {
                  _itemList.add(element_2);
                }
              });
            }
          });
        }
        var cartItemList = itemData.cartItemList;
        _itemList.addAll(cartItemList);
        // List<CartItemListItem> _itemList = itemData.cartItemList;

        List<Widget> itemItems = [];
        if (index != 0) {
          itemItems.add(_line());
        }
        itemItems.add(_redeem(itemData, index, context));
        List<Widget> goodWidget = _itemList.map<Widget>((item) {
          return _buildItem(context, itemData, item, index);
        }).toList();
        itemItems.addAll(goodWidget);
        return Column(
          children: itemItems,
        );
      },
      itemCount: itemList.length,
    );
  }

  /// 有效商品列表Item
  Widget _buildItem(BuildContext context, CarItem itemData,
      CartItemListItem item, int index) {
    List<String> cartItemTips = item.cartItemTips;
    return Container(
      margin: EdgeInsets.only(bottom: 0.5),
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ///选择⭕️
              _buildCheckBox(itemData, item, index),

              ///图片
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: backGrey, borderRadius: BorderRadius.circular(4)),
                  height: 90,
                  width: 90,
                  child: CachedNetworkImage(imageUrl: item.pic ?? ''),
                ),
                onTap: () {
                  _goDetail(context, item);
                },
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isEdit
                            ? Container()
                            : Container(
                                padding: EdgeInsets.only(left: 10),
                                child: RichText(
                                  text: TextSpan(style: t14black, children: [
                                    TextSpan(
                                        text: '${item.promTag ?? ''}',
                                        style: t14Yellow),
                                    TextSpan(text: '${item.itemName ?? ''}'),
                                  ]),
                                )),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 3, 0, 0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                          decoration: BoxDecoration(
                              border: Border.all(color: lineColor, width: 0.5),
                              borderRadius: BorderRadius.circular(2),
                              color: backColor),
                          child: Text(
                            '${_specValue(item)}',
                            style: TextStyle(
                                color: textGrey,
                                height: 1.1,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  '¥${item.actualPrice}',
                                  style: t14blackBold,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    item.retailPrice > item.actualPrice
                                        ? '¥${item.retailPrice}'
                                        : '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textGrey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                              ),
                              isEdit
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 3),
                                      child: CartCount(
                                        number: item.cnt,
                                        min: 1,
                                        max: item.sellVolume,
                                        onChange: (index) {
                                          if (numChange != null) {
                                            numChange(item.source, item.type,
                                                item.skuId, index, item.extId);
                                          }
                                        },
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _goDetail(context, item);
                  },
                ),
              )
            ],
          ),
          item.priceReductDesc == null || item.priceReductDesc.isEmpty
              ? Container()
              : Container(
                  margin: EdgeInsets.only(left: 130),
                  decoration: BoxDecoration(
                      border: Border.all(color: backYellow, width: 1),
                      borderRadius: BorderRadius.circular(2)),
                  child: Text(
                    '${item.priceReductDesc}',
                    style: t12Yellow,
                  ),
                ),
          (cartItemTips == null || cartItemTips.length == 0)
              ? Container()
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  margin: EdgeInsets.fromLTRB(32, 10, 0, 0),
                  decoration: BoxDecoration(
                      color: backGrey, borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cartItemTips.map((item) {
                      return Container(
                        child: Text(
                          '• $item',
                          style: t12lightGrey,
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  ///左侧选择框，编辑框
  _buildCheckBox(CarItem itemData, CartItemListItem item, int index) {
    if (isEdit) {
      return Container(
        margin: EdgeInsets.only(right: 6),
        child: CartCheckBox(
          onCheckChanged: (check) {
            if (deleteCheckItem != null) {
              deleteCheckItem(check, itemData, item);
            }
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(right: 6),
        child: InkWell(
          onTap: () {
            if (itemData.canCheck || item.checked) {
              if (checkOne != null) {
                if (item.id != 0 && item.id != null) {
                  checkOne(itemData, item.source, item.type, item.skuId,
                      !item.checked, item.extId);
                }
              }
            }
          },
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: item.id == 0
                  ? (Icon(
                      Icons.check_circle,
                      size: 22,
                      color: Color(0xFFDBDBDB),
                    ))
                  : (item.checked
                      ? Icon(
                          Icons.check_circle,
                          size: 22,
                          color: redColor,
                        )
                      : Icon(
                          Icons.brightness_1_outlined,
                          size: 22,
                          color: itemData.canCheck
                              ? Color(0xFFDBDBDB)
                              : Color(0xFFF7F6FA),
                        )),
            ),
          ),
        ),
      );
    }
  }

  ///换购
  _redeem(CarItem itemData, int index, BuildContext context) {
    return itemData.promTip == null || itemData.addBuyStepList == null
        ? Container()
        : Container(
            color: backWhite,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        padding: EdgeInsets.fromLTRB(5, 1, 5, 2),
                        decoration: BoxDecoration(
                            color: redLightColor,
                            borderRadius: BorderRadius.circular(2)),
                        child: Text(
                          index == 0 ? '全场换购' : '换购',
                          style: t12white,
                        ),
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${itemData.promTip}',
                          style: t14black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      GestureDetector(
                        child: Row(
                          children: [
                            Text(
                              '${itemData.promotionBtn == 3 ? '再逛逛' : '去凑单'}',
                              style: t14red,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: textRed,
                              size: 14,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    margin: EdgeInsets.fromLTRB(50, 0, 15, 0),
                    color: Color(0xFFFFF7F5),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          itemData.promSatisfy ? '去换购商品' : '查看换购商品',
                          style: t12black,
                        )),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: textGrey,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if (goRedeem != null) {
                      goRedeem(itemData);
                    }
                  },
                ),
              ],
            ),
          );
  }

  _specValue(CartItemListItem item) {
    List<SpecListItem> specList = item.specList;
    String specName = '';
    for (var value in specList) {
      specName += value.specValue;
      specName += "; ";
    }
    var replaceRange =
        specName.replaceRange(specName.length - 2, specName.length - 1, "");
    return replaceRange;
  }

  void _goDetail(BuildContext context, CartItemListItem itemData) {
    Routers.push(
        Util.goodDetailTag, context, {'id': itemData.itemId.toString()});
  }

  _line() {
    return Container(
      height: 10,
      color: backColor,
    );
  }
}
