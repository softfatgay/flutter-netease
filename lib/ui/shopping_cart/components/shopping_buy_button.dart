import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/utils/toast.dart';

const double _checkBoxWidth = 40.0;

///全选不选
typedef void CheckAll(bool checked);

///删除编辑状态选中
typedef void EditDelete();

class ShoppingBuyButton extends StatelessWidget {
  final bool isEdit;
  final List checkList;
  final bool isCheckedAll;
  final CheckAll checkAll;
  final EditDelete editDelete;
  final int selectedNum;
  final num price;
  final num promotionPrice;

  const ShoppingBuyButton({
    Key? key,
    required this.isEdit,
    required this.checkList,
    required this.checkAll,
    required this.isCheckedAll,
    required this.selectedNum,
    required this.price,
    required this.promotionPrice,
    required this.editDelete,
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
            ),
            Expanded(
              child: Container(
                child: Text(
                  '已选(${checkList.length})',
                  style: t14grey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (checkList.length > 0) {
                  editDelete();
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                color: checkList.length > 0 ? redColor : Color(0xFFB4B4B4),
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
              child: InkWell(
                onTap: () {
                  checkAll(isCheckedAll);
                },
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: isCheckedAll
                        ? Icon(
                            Icons.check_circle,
                            size: 22,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.brightness_1_outlined,
                            size: 22,
                            color: lineColor,
                          ),
                  ),
                ),
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
                        '合计：¥$price',
                        style: TextStyle(
                            color: textRed, fontSize: 14, height: 1.1),
                      ),
                    ),
                    if (promotionPrice != 0)
                      Container(
                        child: Text(
                          '已优惠：¥$promotionPrice',
                          style: TextStyle(
                              color: textGrey, fontSize: 12, height: 1.1),
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
