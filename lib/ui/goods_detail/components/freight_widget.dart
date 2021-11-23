import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/components/gd_button_style.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';
import 'package:flutter_app/component/global.dart';

typedef void ShowDialog();

class FreightWidget extends StatelessWidget {
  final SkuFreight? skuFreight;
  final ShowDialog showDialog;

  const FreightWidget({
    Key? key,
    this.skuFreight,
    required this.showDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return skuFreight == null
        ? Container()
        : TextButton(
            style: gdButtonStyle,
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 10),
              decoration: bottomBorder,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      '${skuFreight!.title}：',
                      style: t14black,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        '${skuFreight!.freightInfo ?? ''}',
                        style: t14black,
                      ),
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onPressed: () {
              showDialog();
            },
          );
  }
}
