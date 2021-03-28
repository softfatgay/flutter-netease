import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/shopingcart/model/carItem.dart';
import 'package:flutter_app/ui/shopingcart/model/cartItemListItem.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/cart_check_box.dart';
import 'package:flutter_app/widget/shopping_cart_count.dart';

typedef void NumChange(num source, num type, num skuId, num cnt, String extId);
typedef void CheckOne(
    num source, num type, num skuId, bool check, String extId);

typedef void DeleteCheckItem(
    bool check, CarItem itemData, CartItemListItem item);

class CartItemWidget extends StatelessWidget {
  final NumChange numChange;
  final CheckOne checkOne;
  final DeleteCheckItem deleteCheckItem;
  final List<CarItem> itemList;
  final bool isEdit;

  const CartItemWidget(
      {Key key,
      this.numChange,
      this.checkOne,
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
        List<CartItemListItem> _itemList = itemData.cartItemList;
        List<Widget> itemItems = [];
        itemItems.add(_line());
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
                                child: Text(
                                  '${item.itemName ?? ''}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: textBlack,
                                      height: 1.1),
                                ),
                              ),
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
                                  '¥${item.actualPrice == 0 ? item.actualPrice : item.retailPrice}',
                                  style: t14blackblod,
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
                checkOne(item.source, item.type, item.skuId, !item.checked,
                    item.extId);
              }
            }
          },
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: item.checked
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
                    ),
            ),
          ),
        ),
      );
    }
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
