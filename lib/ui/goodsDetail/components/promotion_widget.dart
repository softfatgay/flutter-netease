import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goodsDetail/model/hdrkDetailVOListItem.dart';
import 'package:flutter_app/widget/global.dart';

///促销
class PromotionWidget extends StatelessWidget {
  final List<HdrkDetailVOListItem> hdrkDetailVOList;

  const PromotionWidget({Key key, this.hdrkDetailVOList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return (hdrkDetailVOList == null || hdrkDetailVOList.isEmpty)
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: bottomBorder,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '促销：',
                    style: t14grey,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          decoration: BoxDecoration(
                              color: redLightColor,
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(14)),
                          child: Text(
                            hdrkDetailVOList[0].activityType,
                            style: t10white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                '${hdrkDetailVOList[0].name}',
                                style: t14black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
