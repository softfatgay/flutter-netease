import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/components/gd_button_style.dart';
import 'package:flutter_app/ui/goods_detail/model/hdrkDetailVOListItem.dart';
import 'package:flutter_app/component/global.dart';

///促销
typedef void OnPress();

class PromotionWidget extends StatelessWidget {
  final List<HdrkDetailVOListItem>? hdrkDetailVOList;
  final OnPress onPress;

  const PromotionWidget({
    Key? key,
    this.hdrkDetailVOList,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return (hdrkDetailVOList == null || hdrkDetailVOList!.isEmpty)
        ? Container()
        : TextButton(
            style: gdButtonStyle,
            child: Container(
              padding: EdgeInsets.only(top: 13, bottom: 13, right: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '促销：',
                      style: t14black,
                    ),
                  ),
                  Expanded(
                    child: CuxiaoItems(
                      hdrkDetailVOList: hdrkDetailVOList,
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
}

class CuxiaoItems extends StatelessWidget {
  final List<HdrkDetailVOListItem>? hdrkDetailVOList;

  const CuxiaoItems({Key? key, this.hdrkDetailVOList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: hdrkDetailVOList!
            .map((item) => Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //   begin: Alignment.centerLeft,
                            //   end: Alignment.centerRight,
                            //   colors: [
                            //     Color(0xFFFE2C30),
                            //     Color(0xFFFF8659),
                            //   ],
                            // ),
                            border: Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(14)),
                        child: Text(
                          '${item.activityType}',
                          style: t11red,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item.name}',
                              style: t14black,
                            ),
                            if (item.promLimitDesc != null)
                              Text(
                                '${item.promLimitDesc ?? ''}',
                                style: t12lightGrey,
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

typedef void ItemClick(HdrkDetailVOListItem item);

class DetailCuxiaoItems extends StatelessWidget {
  final List<HdrkDetailVOListItem>? hdrkDetailVOList;
  final ItemClick itemClick;

  const DetailCuxiaoItems({
    Key? key,
    this.hdrkDetailVOList,
    required this.itemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: hdrkDetailVOList!
            .map((item) => GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: lineColor, width: 1))),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    margin: EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFFFE2C30),
                                  Color(0xFFFF8659),
                                ],
                              ),
                              color: redLightColor,
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(14)),
                          child: Text(
                            '${item.activityType}',
                            style: t12white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${item.name}',
                                style: t14black,
                              ),
                              if (item.promLimitDesc != null)
                                Text(
                                  '${item.promLimitDesc ?? ''}',
                                  style: t12lightGrey,
                                )
                            ],
                          ),
                        ),
                        arrowRightIcon,
                        SizedBox(width: 10)
                      ],
                    ),
                  ),
                  onTap: () {
                    itemClick(item);
                  },
                ))
            .toList(),
      ),
    );
  }
}
