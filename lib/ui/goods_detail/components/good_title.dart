import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/global.dart';

class GoodTitleWidget extends StatelessWidget {
  final String name;
  final String goodCmtRate;
  final num goodId;

  const GoodTitleWidget({Key key, this.name, this.goodCmtRate, this.goodId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTitle(context);
  }

  _buildTitle(BuildContext context) {
    return Container(
      color: backWhite,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              '$name',
              style: t16blackbold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          _goodCmtRate(context)
        ],
      ),
    );
  }

  _goodCmtRate(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Row(
          children: <Widget>[
            (goodCmtRate == null || goodCmtRate == '')
                ? Text(
                    '查看评价',
                    style: t12black,
                  )
                : Column(
                    children: [
                      Text(
                        goodCmtRate,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        '好评率',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
            arrowRightIcon,
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.comment, context, {'id': goodId});
      },
    );
  }
}
