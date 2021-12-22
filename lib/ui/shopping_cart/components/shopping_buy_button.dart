import 'package:flutter/material.dart';
import 'package:flutter_app/component/check_box.dart';
import 'package:flutter_app/component/check_box_width.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/utils/toast.dart';

const double _checkBoxWidth = 40.0;

///全选不选
typedef void CheckAll(bool checked);
typedef void EditCheckAll(bool checked);

///删除编辑状态选中
typedef void EditDelete();

class ShoppingBuyButton extends StatelessWidget {
  final bool isEdit;
  final bool isCheckedAll;
  final bool isEditCheckedAll;
  final CheckAll checkAll;
  final EditCheckAll editCheckAll;
  final EditDelete editDelete;
  final num selectedNum;
  final num editSelectedNum;
  final num price;
  final num promotionPrice;

  const ShoppingBuyButton({
    Key? key,
    required this.isEdit,
    required this.checkAll,
    required this.editCheckAll,
    required this.isCheckedAll,
    required this.isEditCheckedAll,
    required this.selectedNum,
    required this.price,
    required this.promotionPrice,
    required this.editDelete,
    required this.editSelectedNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBuy(context);
  }

  _buildBuy(BuildContext context) {
    ///编辑状态
    if (isEdit) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: backColor, width: 0.5))),
        height: 46,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _checkBoxWidth,
              child: MCheckBoxWidth(
                onPress: () {
                  editCheckAll(isEditCheckedAll);
                },
                check: isEditCheckedAll,
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  '已选($editSelectedNum)',
                  style: t14grey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (editSelectedNum > 0) {
                  editDelete();
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                color: editSelectedNum > 0 ? redColor : Color(0xFFB4B4B4),
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: double.infinity,
                child: Text(
                  '删除所选',
                  style: t14white,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      ///正常状态
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: backColor, width: 0.5))),
        height: 46,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _checkBoxWidth,
              child: MCheckBoxWidth(
                onPress: () {
                  checkAll(isCheckedAll);
                },
                check: isCheckedAll,
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Text(
                  '已选($selectedNum)',
                  style: t14grey,
                ),
              ),
              onTap: () {
                checkAll(isCheckedAll);
              },
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        '  合计：¥$price',
                        style: num12Red,
                      ),
                    ),
                    if (promotionPrice != 0)
                      Container(
                        child: Text(
                          '已优惠：¥$promotionPrice',
                          style: num12Grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                color: price > 0 ? redColor : Color(0xFFB4B4B4),
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: double.infinity,
                child: Text(
                  '下单',
                  style: t14white,
                ),
              ),
              onTap: () {
                Toast.show('暂未开发', context);
                // _goPay();
              },
            )
          ],
        ),
      );
    }
  }
}
