import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';
import 'package:flutter_app/widget/global.dart';

typedef void OnPress();

class GoodSelectWidget extends StatelessWidget {
  final String selectedStrDec;
  final int goodCount;
  final OnPress onPress;
  final SkuMapValue skuMapItem;

  const GoodSelectWidget(
      {Key key,
      this.selectedStrDec,
      this.goodCount,
      this.onPress,
      this.skuMapItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    print('------');
    print('$selectedStrDec');
    return InkResponse(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: bottomBorder,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                selectedStrDec == null || selectedStrDec == ''
                    ? '请选择参数规格'
                    : '已选：',
                style: selectedStrDec == null || selectedStrDec == ''
                    ? t14black
                    : t14grey,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$selectedStrDec',
                      style: t14black,
                    ),
                    selectedStrDec == null || selectedStrDec == ''
                        ? Container()
                        : Text(
                            'x$goodCount',
                            style: t16black,
                          )
                  ],
                ),
              ),
            ),
            arrowRightIcon,
          ],
        ),
      ),
      onTap: () {
        if (onPress != null) {
          onPress();
        }
      },
    );
  }
}
