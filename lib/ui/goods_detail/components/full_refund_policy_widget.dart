import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/components/gd_button_style.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/component/global.dart';

///规则
class FullRefundPolicyWidget extends StatelessWidget {
  final Function onPress;
  final FullRefundPolicy? fullRefundPolicy;

  const FullRefundPolicyWidget({
    Key? key,
    required this.onPress,
    this.fullRefundPolicy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    if (fullRefundPolicy == null ||
        fullRefundPolicy!.titles == null ||
        fullRefundPolicy!.titles!.isEmpty) {
      return Container();
    }

    var titles = fullRefundPolicy!.titles ?? [];
    return TextButton(
      style: gdButtonStyle,
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, right: 10),
        child: Row(
          children: <Widget>[
            Container(
              child: Text('规则：', style: t14black),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    titles.map<Widget>((item) => _buildItem(item)).toList(),
              ),
            ),
            arrowRightIcon
          ],
        ),
      ),
      onPressed: () {
        onPress();
      },
    );
  }

  _buildItem(String item) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 2),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2), color: backRed),
          ),
          Expanded(
            child: Text(
              '$item',
              style: t14black,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
