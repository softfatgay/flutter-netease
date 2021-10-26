import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/components/search_price_filed.dart';

typedef void SortClick(int index);
typedef void ConfirmClick();
typedef void CancelClick();

class PricePopWidget extends StatelessWidget {
  final TextEditingController? lowPriceController;
  final SortClick? sortClick;
  final ConfirmClick? confirmClick;
  final CancelClick? cancelClick;
  final TextEditingController? upPriceController;
  final int descSorted;

  const PricePopWidget(
      {Key? key,
      this.lowPriceController,
      this.upPriceController,
      this.sortClick,
      this.descSorted = -1,
      this.confirmClick,
      this.cancelClick})
      : super(key: key);

  final _childHeight = 25.0;

  @override
  Widget build(BuildContext context) {
    return _widget();
  }

  Widget _widget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                '筛选',
                style: t14black,
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: Container(
                  height: _childHeight,
                  child: SearchPriceTextFiled(
                    hintText: '最低价',
                    controller: lowPriceController,
                  ),
                ),
              ),
              Container(
                width: 20,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: textBlack,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: _childHeight,
                  child: SearchPriceTextFiled(
                    hintText: '最高价',
                    // textStyle: t12black,
                    // borderColor: textGrey,
                    controller: upPriceController,
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                '排序',
                style: t14black,
              ),
              SizedBox(width: 20),
              GestureDetector(
                child: Container(
                  height: _childHeight,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: descSorted == 0 ? textRed : textBlack,
                          width: 1),
                      borderRadius: BorderRadius.circular(3)),
                  child: Text(
                    '从低到高',
                    style: TextStyle(
                        fontSize: 12,
                        color: descSorted == 0 ? textRed : textBlack),
                  ),
                ),
                onTap: () {
                  if (sortClick != null) {
                    sortClick!(0);
                  }
                },
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  height: _childHeight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: descSorted == 1 ? textRed : textBlack,
                          width: 1),
                      borderRadius: BorderRadius.circular(3)),
                  child: Text(
                    '从高到低',
                    style: TextStyle(
                        fontSize: 12,
                        color: descSorted == 1 ? textRed : textBlack),
                  ),
                ),
                onTap: () {
                  if (sortClick != null) {
                    sortClick!(1);
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Divider(height: 1),
        Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    color: backWhite,
                    padding: EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    child: Text(
                      '取消',
                      style: t14black,
                    ),
                  ),
                  onTap: () {
                    if (cancelClick != null) {
                      cancelClick!();
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border(left: BorderSide(color: lineColor, width: 1)),
                      color: backWhite,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    child: Text(
                      '确定',
                      style: t14red,
                    ),
                  ),
                  onTap: () {
                    if (confirmClick != null) {
                      confirmClick!();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1),
      ],
    );
  }

  ///排序点击颜色
  Color _desSortColor(int type) {
    if (type == 0) {
      if (descSorted == 0) {
        return textRed;
      } else {
        return textBlack;
      }
    } else if (type == 1) {
      if (descSorted == 1) {
        return textRed;
      } else {
        return textBlack;
      }
    } else {
      return textBlack;
    }
  }
}
