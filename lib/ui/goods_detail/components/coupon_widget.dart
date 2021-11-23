import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/ui/goods_detail/components/gd_button_style.dart';

///领券
typedef void OnPress();

class CouponWidget extends StatelessWidget {
  final List<String>? couponShortNameList;
  final num? id;
  final OnPress onPress;

  const CouponWidget(
      {Key? key, this.couponShortNameList, this.id, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    return (couponShortNameList == null || couponShortNameList!.isEmpty)
        ? Container()
        : TextButton(
            style: gdButtonStyle,
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Text(
                      '领券：',
                      style: t14black,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: couponShortNameList!
                          .map((item) => Container(
                                margin: EdgeInsets.only(right: 3),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xFFF48F18), width: 0.5),
                                    borderRadius: BorderRadius.circular(2)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                child: Text(
                                  '$item',
                                  style: t12Yellow,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onPressed: () {
              onPress();
            },
          );
  }
}
