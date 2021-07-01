import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/global.dart';

///领券
class CouponWidget extends StatelessWidget {
  final List<String> couponShortNameList;
  final num id;
  const CouponWidget({Key key, this.couponShortNameList, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    return (couponShortNameList == null || couponShortNameList.isEmpty)
        ? Container()
        : InkResponse(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Text(
                      '领券：',
                      style: t14grey,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFBBB65)),
                              borderRadius: BorderRadius.circular(2)),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            couponShortNameList[0],
                            style: t12red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onTap: () {
              Routers.push(Routers.webViewPageAPP, context, {
                'url': 'https://m.you.163.com/item/detail?id=$id#/coupon/$id}'
              });
            },
          );
  }
}
