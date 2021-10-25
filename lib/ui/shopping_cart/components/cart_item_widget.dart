import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/timer_text.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopping_cart/components/cart_check_box.dart';
import 'package:flutter_app/ui/shopping_cart/components/cart_num_filed.dart';
import 'package:flutter_app/ui/shopping_cart/components/shopping_cart_count.dart';
import 'package:flutter_app/ui/shopping_cart/model/carItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/cartItemListItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/redeemModel.dart';
import 'package:flutter_app/utils/toast.dart';

typedef void NumChange(
    num? source, num? type, num? skuId, num cnt, String? extId);
typedef void CheckOne(CarItem itemData, num? source, num? type, num? skuId,
    bool check, String? extId);

typedef void DeleteCheckItem(
    bool check, CarItem itemData, CartItemListItem item);
typedef void GoRedeem(CarItem itemData);
typedef void SkuClick(CartItemListItem item);

const double _checkBoxWith = 40.0;
const double _imageWith = 90.0;

typedef void CallBack();

///购物车条目
class CartItemWidget extends StatelessWidget {
  final CallBack callBack;
  final SkuClick skuClick;
  final NumChange numChange;
  final CheckOne checkOne;
  final GoRedeem goRedeem;
  final DeleteCheckItem deleteCheckItem;
  final List<CarItem> itemList;
  final bool isEdit;
  final TextEditingController controller;

  const CartItemWidget(
      {Key? key,
      required this.callBack,
      required this.numChange,
      required this.checkOne,
      required this.goRedeem,
      required this.deleteCheckItem,
      required this.itemList,
      required this.isEdit,
      required this.controller,
      required this.skuClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        CarItem itemData = itemList[index];
        List<CartItemListItem> _itemList = [];

        ///换购
        List<AddBuyStepListItem>? addBuyStepList = itemData.addBuyStepList;
        if (addBuyStepList != null && addBuyStepList.isNotEmpty) {
          addBuyStepList.forEach((element_1) {
            var addBuyItemList = element_1.addBuyItemList;
            if (addBuyItemList != null && addBuyItemList.isNotEmpty) {
              addBuyItemList.forEach((element_2) {
                if (element_2.checked!) {
                  _itemList.add(element_2);
                }
              });
            }
          });
        }
        var cartItemList = itemData.cartItemList!;
        _itemList.addAll(cartItemList);

        List<Widget> itemItems = [];
        if (index != 0) {
          itemItems.add(_line());
        }

        ///换购，满减
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
  _buildItem(BuildContext context, CarItem itemData, CartItemListItem item,
      int index) {
    List<String>? cartItemTips = item.cartItemTips;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///顶部活动
          _buildActivity(item),

          ///主体
          _buildMainContent(itemData, item, index, context),

          ///比加入时省多钱
          _buildSaveMoney(item),

          ///自营仓库免邮
          _freeShipping(item),
          _cartItemTips(cartItemTips),
          SizedBox(height: 10),
          Divider(
            indent: _checkBoxWith,
            height: 1,
          )
        ],
      ),
    );
  }

  _buildActivity(CartItemListItem item) {
    if (item.timingPromotion == null || item.timingPromotion == '') {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: _checkBoxWith, top: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: backYellow, width: 0.5)),
            child: Text(
              '${item.timingPromotion}',
              style: t12Orange,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              '${item.finishTip}',
              style: t12black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: TimerText(
              time: item.remainTime! ~/ 1000,
              textStyle: t12blackBold,
            ),
          ),
        ],
      ),
    );
  }

  ///免邮
  _freeShipping(CartItemListItem item) {
    if (item.warehouseInfo == null) {
      return Container();
    }
    var warehouseInfo = item.warehouseInfo!;
    return Container(
      margin: EdgeInsets.only(left: _checkBoxWith, top: 8, right: 10),
      child: Row(
        children: [
          Image.asset(
            'assets/images/house_icon.png',
            width: 14,
            height: 14,
          ),
          SizedBox(width: 5),
          Text(
            '${warehouseInfo.desc}',
            style: t12grey,
          ),
        ],
      ),
    );
  }

  _cartItemTips(List<String>? cartItemTips) {
    return (cartItemTips == null || cartItemTips.length == 0)
        ? Container()
        : Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            margin: EdgeInsets.only(left: _checkBoxWith, right: 10, top: 8),
            decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cartItemTips.map((item) {
                return Container(
                  child: Text(
                    '• $item',
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
  }

  _buildMainContent(CarItem itemData, CartItemListItem item, int index,
      BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          ///选择⭕️
          _buildCheckBox(itemData, item, index),

          ///图片
          GestureDetector(
            child: RoundNetImage(
              url: item.pic,
              backColor: backGrey,
              corner: 4,
              height: _imageWith,
              width: _imageWith,
            ),
            onTap: () {
              _goDetail(context, item);
            },
          ),
          _buildDes(item, context)
        ],
      ),
    );
  }

  _buildDes(CartItemListItem item, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isEdit)
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: t14black,
                      children: [
                        TextSpan(
                            text:
                                '${item.promTag ?? (item.id == 0 ? '换购' : '')}',
                            style: t14Yellow),
                        TextSpan(text: '${item.itemName ?? ''}'),
                      ],
                    ),
                  ),
                ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
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
                            maxWidth: MediaQuery.of(context).size.width / 2),
                        child: Text(
                          '${_specValue(item)}',
                          style: t12grey,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      item.id != 0
                          ? Image.asset(
                              'assets/images/arrow_down.png',
                              width: 10,
                              height: 10,
                            )
                          : Container()
                    ],
                  ),
                ),
                onTap: () {
                  if (item.id != 0) {
                    skuClick(item);
                  }
                },
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
                          item.retailPrice! > item.actualPrice!
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      child: CartCount(
                        number: item.cnt as int?,
                        min: 1,
                        max: item.id == 0 ? 1 : item.sellVolume as int?,
                        onChange: (numValue) {
                          numChange(item.source, item.type, item.skuId,
                              numValue!, item.extId);
                        },
                        numClick: () {
                          if (item.id != 0) {
                            _showNumClickDialog(context, item);
                          }
                        },
                      ),
                    ),
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
    );
  }

  _showNumClickDialog(BuildContext context, CartItemListItem item) {
    controller.text = item.cnt.toString();
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                // border: Border.all(color: textGrey, width: 1),
                // borderRadius: BorderRadius.circular(4),
                ),
            child: CartTextFiled(
              controller: controller,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: t16grey,
              ),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '确认',
                style: t16red,
              ),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  if (num.parse(controller.text.toString()) >
                      item.sellVolume!) {
                    Toast.show('不能超过最大库存量(${item.sellVolume})', context,
                        duration: 3);
                    return;
                  }
                  numChange(item.source, item.type, item.skuId,
                      num.parse(controller.text.toString()), item.extId);
                  Navigator.of(context).pop();
                  // item.cnt = int.parse(controller.text.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  _buildSaveMoney(CartItemListItem item) {
    return item.priceReductDesc == null || item.priceReductDesc!.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            margin: EdgeInsets.only(
                left: _checkBoxWith + _imageWith + 10, right: 10),
            decoration: BoxDecoration(
                border: Border.all(color: backYellow, width: 0.5),
                borderRadius: BorderRadius.circular(2)),
            child: Text(
              '${item.priceReductDesc}',
              style: t10Orange,
            ),
          );
  }

  ///左侧选择框，编辑框
  _buildCheckBox(CarItem itemData, CartItemListItem item, int index) {
    if (isEdit) {
      return Container(
        width: _checkBoxWith,
        child: CartCheckBox(
          canCheck: true,
          onCheckChanged: (check) {
            deleteCheckItem(check, itemData, item);
          },
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        width: _checkBoxWith,
        child: GestureDetector(
          onTap: () {
            if (itemData.canCheck! || item.checked!) {
              if (item.id != 0 && item.id != null) {
                checkOne(itemData, item.source, item.type, item.skuId,
                    !item.checked!, item.extId);
              }
            }
          },
          child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              child: _checkBox(itemData, item)),
        ),
      );
    }
  }

  _checkBox(CarItem itemData, CartItemListItem item) {
    if (item.id == 0) {
      return _cantClickBox();
    } else {
      if (item.checked!) {
        return _checkedBox();
      } else {
        if (itemData.canCheck!) {
          return _canClickBox();
        } else {
          return _cantClickBox();
        }
      }
    }
  }

  ///不能点击
  _cantClickBox() {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backGrey,
      ),
    );
  }

  ///可以点击
  _canClickBox() {
    return Icon(
      Icons.brightness_1_outlined,
      size: 22,
      color: Color(0xFFDBDBDB),
    );
  }

  ///已选择
  _checkedBox() {
    return Icon(
      Icons.check_circle,
      size: 22,
      color: redColor,
    );
  }

  _redeem(CarItem itemData, int index, BuildContext context) {
    bool cartItemEmpty =
        itemData.cartItemList == null || itemData.cartItemList!.isEmpty;
    if (itemData.addBuyStepList != null &&
        itemData.addBuyStepList!.isNotEmpty) {
      ///换购
      return Container(
        color: backWhite,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: cartItemEmpty ? 15 : _checkBoxWith, right: 15),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: redLightColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      '${cartItemEmpty ? '全场换购' : '换购'}',
                      style: TextStyle(
                          fontSize: 12, color: textWhite, height: 1.1),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 4),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${itemData.promTip}',
                        style: t14black,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Text(
                          '${itemData.promotionBtn == 3 ? '再逛逛' : '去凑单'}',
                          style: t12red,
                        ),
                        arrowRightRed10Icon
                      ],
                    ),
                    onTap: () {
                      Routers.push(Routers.makeUpPage, context, {
                        'id': cartItemEmpty ? -1 : itemData.promId,
                        'from': 'cart-item'
                      }, (value) {
                        callBack();
                      });
                    },
                  )
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFF7F5),
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                margin: EdgeInsets.fromLTRB(_checkBoxWith, 0, 15, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        itemData.promSatisfy! ? '去换购商品' : '查看换购商品',
                        style: t12black,
                      ),
                    ),
                    arrowRightIcon
                  ],
                ),
              ),
              onTap: () {
                goRedeem(itemData);
              },
            ),
          ],
        ),
      );
    } else if (itemData.promType == 102 ||
        itemData.promType == 107 ||
        itemData.promType == 108 ||
        itemData.promType == 109) {
      ///108满额减,107满件减,109满折
      return Container(
        color: backWhite,
        padding: EdgeInsets.only(left: _checkBoxWith, top: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 6),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: redLightColor,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                '${_getActivityTv(itemData)}',
                style: TextStyle(fontSize: 12, color: textWhite, height: 1.1),
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
                    '去凑单',
                    style: t12red,
                  ),
                  arrowRightRed10Icon
                ],
              ),
              onTap: () {
                Routers.push(Routers.makeUpPage, context, {
                  'id': cartItemEmpty ? -1 : itemData.promId,
                  'from': 'cart-item'
                }, (value) {
                  callBack();
                });
              },
            )
          ],
        ),
      );
    }
    return Container();
  }

  _getActivityTv(CarItem itemData) {
    String promType = '';
    switch (itemData.promType) {
      case 102:
        promType = '满赠';
        break;
      case 107:
        promType = '满件减';
        break;
      case 108:
        promType = '满额减';
        break;
      case 109:
        promType = '满折';
        break;
    }
    return promType;
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

  void _goDetail(BuildContext context, CartItemListItem itemData) {
    Routers.push(
        Routers.goodDetail, context, {'id': itemData.itemId.toString()});
  }

  _line() {
    return Container(
      height: 10,
      color: backColor,
    );
  }
}
