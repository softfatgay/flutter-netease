import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/component/my_vertical_text.dart';
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

typedef void CheckOne(CartItemListItem item);
typedef void CheckGroup(CarItem itemData);

typedef void DeleteCheckItem(
    CarItem itemData, CartItemListItem item, bool check);

///编辑状态选择group
typedef void DeleteCheckGroup(CarItem itemData, bool check);

typedef void NumChange(CartItemListItem item, num cnt);

typedef void GoRedeem(CarItem itemData);
typedef void SkuClick(CartItemListItem item);

const double _checkBoxWidth = 40.0;
const double _imageWidth = 90.0;

typedef void CallBack();

///购物车条目
class CartItemWidget extends StatelessWidget {
  final CallBack callBack;
  final SkuClick skuClick;
  final NumChange numChange;
  final CheckOne checkOne;
  final CheckGroup checkGroup;
  final GoRedeem goRedeem;
  final DeleteCheckItem deleteCheckItem;
  final DeleteCheckGroup deleteCheckGroup;
  final List<CarItem> dataList;
  final bool isEdit;
  final TextEditingController controller;
  final bool isInvalid;

  const CartItemWidget({
    Key? key,
    required this.callBack,
    required this.numChange,
    required this.checkOne,
    required this.checkGroup,
    required this.goRedeem,
    required this.deleteCheckItem,
    required this.deleteCheckGroup,
    required this.dataList,
    required this.isEdit,
    required this.controller,
    required this.skuClick,
    this.isInvalid = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        CarItem itemData = dataList[index];
        List<CartItemListItem> _itemList = [];

        ///TODO 102满赠,104换购,107满件减,108满额减,109满折(待补充),
        List<AddBuyStepListItem> activityList = [];
        if (itemData.promType == 102) {
          ///满赠
          activityList = itemData.giftStepList ?? [];
        } else if (itemData.promType == 104) {
          ///换购
          activityList = itemData.addBuyStepList ?? [];
        } else if (itemData.promType == 4) {
          ///换购
          activityList = itemData.addBuyStepList ?? [];
        }

        ///是否有选择的换购/赠品
        bool hasCheck = false;

        if (activityList.isNotEmpty) {
          activityList.forEach((element_1) {
            ///TODO 102满赠,104换购,107满件减,108满额减,109满折(待补充),
            List<CartItemListItem> itemItemList = [];
            if (itemData.promType == 102) {
              itemItemList = element_1.giftItemList ?? [];
            } else if (itemData.promType == 4 || itemData.promType == 104) {
              itemItemList = element_1.addBuyItemList ?? [];
            }
            if (itemItemList.isNotEmpty) {
              itemItemList.forEach((element_2) {
                ///方便编辑添加check
                if (element_2.checked!) {
                  hasCheck = true;
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

        ///102满赠,104换购,106N元任选,107满件减,108满额减,109满折 4全场换购标题
        itemItems.add(_itemActivityTitle(context, itemData));

        ///满赠,换购
        itemItems.add(_giftStep(context, itemData, hasCheck));

        List<Widget> goodWidget = _itemList.map<Widget>((item) {
          return _buildItem(context, _itemList, itemData, item, index);
        }).toList();
        itemItems.addAll(goodWidget);
        return Column(
          children: itemItems,
        );
      },
      itemCount: dataList.length,
    );
  }

  /// 有效商品列表Item
  _buildItem(BuildContext context, List<CartItemListItem> _itemList,
      CarItem itemData, CartItemListItem item, int index) {
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

          ///app推广
          _appFreshmanBanner(context, item),
          _cartItemTips(cartItemTips),
          SizedBox(height: 10),
          Divider(
            indent: _checkBoxWidth,
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
      margin: EdgeInsets.only(left: _checkBoxWidth, top: 10),
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

  _appFreshmanBanner(BuildContext context, CartItemListItem item) {
    if (item.appFreshmanBannerVO == null) return Container();
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFFFF4EE), borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.only(left: _checkBoxWidth, right: 10, top: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _appFreshmanBannerText(item.appFreshmanBannerVO!),
          ),
          GestureDetector(
            child: Row(
              children: [
                Container(
                  child: Text(
                    '去APP购买',
                    style: t12red,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 16,
                  color: textRed,
                )
              ],
            ),
            onTap: () {
              Routers.push(Routers.webView, context,
                  {'url': 'https://m.you.163.com/downloadapp'});
            },
          )
        ],
      ),
    );
  }

  _appFreshmanBannerText(AppFreshmanBannerVO appFreshmanBannerVO) {
    try {
      var freshmanDesc = appFreshmanBannerVO.freshmanDesc;
      var appFreshmanPrice = appFreshmanBannerVO.appFreshmanPrice;

      if (freshmanDesc != null &&
          appFreshmanPrice != null &&
          freshmanDesc.contains('##') &&
          freshmanDesc.length > 2) {
        var indexOf = freshmanDesc.indexOf('##');
        var lastIndexOf = freshmanDesc.lastIndexOf('##');

        var substring = freshmanDesc.substring(0, indexOf);
        var substring2 =
            freshmanDesc.substring(lastIndexOf + 2, freshmanDesc.length);
        return RichText(
          text: TextSpan(children: [
            TextSpan(text: '$substring'),
            TextSpan(text: '¥$appFreshmanPrice', style: t14red),
            TextSpan(text: '$substring2'),
          ], style: t12black),
        );
      }
    } catch (e) {
      return Text('${appFreshmanBannerVO.freshmanDesc ?? ''}');
    }
    return Text('${appFreshmanBannerVO.freshmanDesc ?? ''}');
  }

  ///免邮
  _freeShipping(CartItemListItem item) {
    if (item.warehouseInfo == null) {
      return Container();
    }
    var warehouseInfo = item.warehouseInfo!;
    return Container(
      margin: EdgeInsets.only(left: _checkBoxWidth, top: 8, right: 10),
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
            margin: EdgeInsets.only(left: _checkBoxWidth, right: 10, top: 8),
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
          _buildImageInfo(context, item),

          _buildDes(itemData, item, context)
        ],
      ),
    );
  }

  _buildImageInfo(BuildContext context, CartItemListItem item) {
    return GestureDetector(
      child: Container(
        height: _imageWidth,
        width: _imageWidth,
        child: Stack(
          children: [
            RoundNetImage(
              url: item.pic,
              backColor: backGrey,
              corner: 4,
              height: _imageWidth,
              width: _imageWidth,
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: _imgFlag(item))
          ],
        ),
      ),
      onTap: () {
        _goDetail(context, item);
      },
    );
  }

  _imgFlag(CartItemListItem item) {
    if (item.limitPurchaseFlag!) {
      ///限购标签
      return _limitPurchaseFlag(item);
    } else if (item.sellVolume! < item.cnt!) {
      ///无法购买标签
      return _cantBuyFlag(item, '库存不足');
    } else if (item.preemptionStatus! == 0) {
      ///无法购买标签
      return _cantBuyFlag(item, '无法购买');
    } else if (item.sellVolume == 0) {
      ///库存为0
      return _cantBuyFlag(item, '暂无库存');
    } else if (item.sellVolume! <= 5) {
      return _cantBuyFlag(item, '仅剩${item.sellVolume}件');
    }
    return Container();
  }

  ///无法购买标签
  _cantBuyFlag(CartItemListItem item, String tips) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x80333333),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
      ),
      padding: EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.center,
      child: Text(
        '$tips',
        style: TextStyle(fontSize: 12, color: textWhite, height: 1.1),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  ///限购标签
  _limitPurchaseFlag(CartItemListItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF48F18),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
      ),
      padding: EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.center,
      child: Text(
        '限购${item.limitPurchaseCount}件',
        style: TextStyle(fontSize: 12, color: textWhite, height: 1.1),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _desPromTag(CarItem itemData, CartItemListItem item) {
    String promTag = '';
    switch (itemData.promType) {
      case 4:
      case 104:
        promTag = '换购';
        break;
      case 102:
        promTag = '满赠';
        break;
    }
    return item.promTag ?? promTag;
  }

  _buildDes(CarItem itemData, CartItemListItem item, BuildContext context) {
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
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: t14black,
                            children: [
                              TextSpan(
                                text: '${_desPromTag(itemData, item)}',
                                style: t14Yellow,
                              ),
                              TextSpan(text: '${item.itemName ?? ''}'),
                            ],
                          ),
                        ),
                      ),
                      if (isInvalid)
                        Container(
                          child: Text(
                            'x${item.cnt}',
                            style: t14lightGrey,
                          ),
                        )
                    ],
                  ),
                ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                  decoration: (item.id != 0 && item.canSwitchSpec!)
                      ? BoxDecoration(
                          border: Border.all(color: lineColor, width: 0.5),
                          borderRadius: BorderRadius.circular(2),
                          color: Color(0xFFFAFAFA),
                        )
                      : null,
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
                      if (item.id != 0 && item.canSwitchSpec!)
                        Image.asset(
                          'assets/images/arrow_down.png',
                          width: 10,
                          height: 10,
                        )
                    ],
                  ),
                ),
                onTap: () {
                  if (item.id != 0 && item.canSwitchSpec!) {
                    skuClick(item);
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '¥${item.actualPrice}',
                      style: num14BlackBold,
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
                            fontFamily: 'DINAlternateBold',
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ),
                    isInvalid
                        ? Container(height: 30)
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3, vertical: 3),
                            child: CartCount(
                              number: item.cnt as int?,
                              min: 1,
                              max: item.id == 0 ? 1 : item.sellVolume as int?,
                              onChange: (numValue) {
                                numChange(item, numValue!);
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
                  numChange(item, num.parse(controller.text.toString()));
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
                left: _checkBoxWidth + _imageWidth + 10, right: 10),
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
        width: _checkBoxWidth,
        child: CartCheckBox(
          canCheck: true,
          checked: item.editChecked ?? false,
          onCheckChanged: (check) {
            deleteCheckItem(itemData, item, check);
          },
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        width: _checkBoxWidth,
        child: GestureDetector(
          onTap: () {
            if (_canCheck(item)) {
              // checkOne(itemData, item.source, item.type, item.skuId,
              //     !item.checked!, item.extId);
              checkOne(item);
            }
          },
          child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.transparent,
              child: _checkBox(itemData, item)),
        ),
      );
    }
  }

  _checkBox(CarItem itemData, CartItemListItem item) {
    if (isInvalid) {
      return _invalidCheckBoxView(item);
    }
    if (item.id == 0) {
      if (item.type == 110) {
        return Container();
      } else {
        return _checkGreyBox();
      }
    } else {
      if (item.checked!) {
        return _checkedBox();
      } else {
        if (_canCheck(item)) {
          return _canClickBox();
        } else {
          return _cantClickBox();
        }
      }
    }
  }

  _invalidCheckBoxView(CartItemListItem item) {
    return Container(
      width: _checkBoxWidth,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFB4B4B4), borderRadius: BorderRadius.circular(2)),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 2),
        child: VerticalText(
          '${_getInvalidCheckBoxTv(item)}',
          style: TextStyle(height: 1, color: textWhite, fontSize: 12),
        ),
      ),
    );
  }

  _getInvalidCheckBoxTv(CartItemListItem item) {
    if (item.status == 0) {
      return '售罄下架';
    } else if (item.sellVolume == 0) {
      return '售罄';
    } else {
      return '';
    }
  }

  _canCheck(CartItemListItem item) {
    if ((item.limitPurchaseFlag! && (item.limitPurchaseCount! < item.cnt!)) ||
        item.preemptionStatus == 0 ||
        item.sellVolume! < item.cnt! ||
        item.sellVolume == 0 ||
        item.id == 0 ||
        item.type == 110) {
      return false;
    }
    return true;
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

  ///已选择
  _checkGreyBox() {
    return Icon(
      Icons.check_circle,
      size: 22,
      color: lineColor,
    );
  }

  _giftStep(BuildContext context, CarItem itemData, bool hasCheck) {
    if (itemData.promType == 102 ||
        itemData.promType == 104 ||
        itemData.promType == 4) {
      return GestureDetector(
        child: Container(
          color: backWhite,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFF7F5),
              borderRadius: BorderRadius.circular(3),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            margin: EdgeInsets.fromLTRB(_checkBoxWidth, 8, 15, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${_getPromTips(itemData, hasCheck)}',
                    style: t12black,
                  ),
                ),
                arrowRightIcon
              ],
            ),
          ),
        ),
        onTap: () {
          goRedeem(itemData);
        },
      );
    }
    return Container();
  }

  _getPromTips(CarItem itemData, bool hasCheck) {
    String tv = '';
    if (itemData.promType == 102) {
      if (itemData.promSatisfy!) {
        if (hasCheck) {
          tv = '更换赠品';
        } else {
          tv = '获取赠品';
        }
      } else {
        tv = '查看赠品';
      }
    } else if (itemData.promType == 4 || itemData.promType == 104) {
      if (itemData.promSatisfy!) {
        if (hasCheck) {
          tv = '重新换购商品';
        } else {
          tv = '去换购商品';
        }
      } else {
        tv = '去换购商品';
      }
    }
    return tv;
  }

  _itemActivityTitle(BuildContext context, CarItem itemData) {
    ///102满赠,104换购,107满件减,108满额减,109满折 标题
    var promType = itemData.promType;
    bool cartItemEmpty =
        itemData.cartItemList == null || itemData.cartItemList!.isEmpty;
    if (promType == 4 ||
        promType == 102 ||
        promType == 104 ||
        promType == 106 ||
        promType == 107 ||
        promType == 108 ||
        promType == 109) {
      return Container(
        color: backWhite,
        padding: EdgeInsets.only(left: 0, top: 10, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                width: _checkBoxWidth,
                child: _groupCheckBox(itemData),
              ),
              onTap: () {
                _groupCheckClick(itemData);
              },
            ),
            Container(
              margin: EdgeInsets.only(right: 6),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: redLightColor,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                '${_getItemActivityTitle(itemData)}',
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
                    '${itemData.promSatisfy! ? '再逛逛' : '去凑单'}',
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

  _groupCheckClick(CarItem itemData) {
    if (isEdit) {
    } else {
      checkGroup(itemData);
    }
  }

  _groupCheckBox(CarItem itemData) {
    if (isInvalid) {
      return Container();
    }
    if (isEdit) {
      return Container(
        width: _checkBoxWidth,
        child: CartCheckBox(
          canCheck: true,
          checked: itemData.editChecked ?? false,
          onCheckChanged: (checked) {
            ///group选择
            deleteCheckGroup(itemData, checked);
          },
        ),
      );
    } else {
      if (itemData.showCheck!) {
        if (itemData.canCheck!) {
          if (itemData.checked!) {
            return _checkedBox();
          } else {
            return _canClickBox();
          }
        } else {
          return _cantClickBox();
        }
      }
    }
    return Container();
  }

  _getItemActivityTitle(CarItem itemData) {
    String promTypeTitle = '';
    switch (itemData.promType) {
      case 4:
        promTypeTitle = '全场换购';
        break;
      case 102:
        promTypeTitle = '满赠';
        break;
      case 104:
        promTypeTitle = '换购';
        break;
      case 106:
        promTypeTitle = 'N元任选';
        break;
      case 107:
        promTypeTitle = '满件减';
        break;
      case 108:
        promTypeTitle = '满额减';
        break;
      case 109:
        promTypeTitle = '满折';
        break;
    }
    return promTypeTitle;
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
