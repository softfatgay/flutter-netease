import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/component/global.dart';

typedef void ShowDialog();

///规则
class FullRefundPolicyWidget extends StatelessWidget {
  final ShowDialog showDialog;
  final FullRefundPolicy? fullRefundPolicy;

  const FullRefundPolicyWidget(
      {Key? key, required this.showDialog, this.fullRefundPolicy})
      : super(key: key);

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
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        color: backWhite,
        child: Row(
          children: <Widget>[
            Container(
              child: Text('规则：', style: t14black),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: titles
                    .map((item) => Container(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 2),
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: backRed),
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
                        ))
                    .toList(),
              ),
            ),
            arrowRightIcon
          ],
        ),
      ),
      onTap: () {
        showDialog();
      },
    );
  }
}
