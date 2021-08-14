import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';
import 'package:flutter_app/widget/global.dart';

typedef void ShowDialog();

class FreightWidget extends StatelessWidget {
  final SkuFreight skuFreight;
  final ShowDialog showDialog;

  const FreightWidget({Key key, this.skuFreight, this.showDialog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return skuFreight == null
        ? Container()
        : InkResponse(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: bottomBorder,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      '${skuFreight.title}：',
                      style: t14black,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        skuFreight.freightInfo,
                        style: t14black,
                      ),
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onTap: () {
              if (showDialog != null) {
                showDialog();
              }
            },
          );
  }
}
