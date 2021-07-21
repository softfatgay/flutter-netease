import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/widget/global.dart';

typedef void OnPress();

class GoodSelectWidget extends StatelessWidget {
  final String selectedStrDec;
  final int goodCount;
  final OnPress onPress;

  const GoodSelectWidget(
      {Key key, this.selectedStrDec, this.goodCount, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return InkResponse(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: bottomBorder,
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                '已选：',
                style: t14grey,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('$selectedStrDec')),
                  ],
                ),
              ),
            ),
            Container(
              child: Text(
                'x$goodCount',
                style: TextStyle(fontSize: 14, color: Colors.red),
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
