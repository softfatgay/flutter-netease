import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';
import 'package:flutter_app/component/global.dart';

typedef void ShowDialog();

class ServiceWidget extends StatelessWidget {
  final List<PolicyListItem> policyList;
  final ShowDialog showDialog;

  const ServiceWidget({Key key, this.policyList, this.showDialog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return policyList == null || policyList.isEmpty
        ? Container()
        : GestureDetector(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          child: Text(
                            '服务:',
                            style: t14black,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: _buildSerVice(),
                          ),
                        )),
                        arrowRightIcon
                      ],
                    ),
                  )
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

  List<Widget> _buildSerVice() => List.generate(policyList.length, (index) {
        return Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 4,
                color: textRed,
              ),
              SizedBox(width: 2),
              Text(
                '${policyList[index].title}',
                style: t12black,
              )
            ],
          ),
        );
      });
}
