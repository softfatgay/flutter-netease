import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/component/slivers.dart';

class RecommendWidget extends StatelessWidget {
  final List<String> recommendReason;
  final String simpleDesc;

  const RecommendWidget({Key key, this.recommendReason, this.simpleDesc})
      : super(key: key);

  // border: Border.all(color:Color(0XFFE6E6E6,),width: 1 )
  @override
  Widget build(BuildContext context) {
    return singleSliverWidget(Container(
      color: backWhite,
      child: _recommend(),
    ));
  }

  ///推荐理由
  _recommend() {
    return recommendReason == null || recommendReason.isEmpty
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.grey[100]),
            child: Text('$simpleDesc', style: t14blackBold),
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: Color(0XFFFAFAFA),
                border: Border.all(
                    color: Color(
                      0XFFE6E6E6,
                    ),
                    width: 0.5),
                borderRadius: BorderRadius.circular(2)),
            child:  Column(
              children: recommendReason
                  .map((item) => Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 3),
                      alignment: Alignment.center,
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: backRed, width: 1)),
                      child: Text(
                        '${recommendReason.indexOf(item) + 1}',
                        style: t12red,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '$item',
                        style: t12black,
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
