import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/component/global.dart';

class SkulimitWidget extends StatelessWidget {
  final String? skuLimit;

  const SkulimitWidget({Key? key, this.skuLimit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return (skuLimit == null || skuLimit == '')
        ? Container()
        : Container(
            margin: EdgeInsets.only(left: 10),
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '限制：',
                      style: t14black,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      skuLimit!,
                      style: t14black,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
