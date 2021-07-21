import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/widget/global.dart';

typedef void ShowDialog();

///规则
class FullRefundPolicyWidget extends StatelessWidget {
  final ShowDialog showDialog;
  final FullRefundPolicy fullRefundPolicy;

  const FullRefundPolicyWidget(
      {Key key, this.showDialog, this.fullRefundPolicy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    String policyTitle = '';
    if (fullRefundPolicy != null) {
      List fullRefundPolicyTitle = fullRefundPolicy.titles;
      if (fullRefundPolicyTitle != null && fullRefundPolicyTitle.isNotEmpty) {
        fullRefundPolicyTitle.forEach((element) {
          policyTitle += '▪$element ';
        });
      }
    }
    return fullRefundPolicy == null
        ? Container()
        : InkResponse(
            child: Container(
              decoration: bottomBorder,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                children: [
                  Text(
                    '规则：',
                    style: t14grey,
                  ),
                  Expanded(
                    child: Text(
                      '$policyTitle',
                      style: t14black,
                    ),
                  ),
                  arrowRightIcon
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
