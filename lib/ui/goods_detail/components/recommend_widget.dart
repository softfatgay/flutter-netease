import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/component/slivers.dart';

class RecommendWidget extends StatelessWidget {
  final List<String> recommendReason;
  final String simpleDesc;

  const RecommendWidget({Key key, this.recommendReason, this.simpleDesc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _recommend();
  }

  ///推荐理由
  _recommend() {
    return recommendReason == null || recommendReason.isEmpty
        ? singleSliverWidget(
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.grey[100]),
              child: Text('$simpleDesc', style: t14blackBold),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: Text(
                    '${index + 1} .${recommendReason[index]}',
                    style: t12black,
                  ),
                ),
              );
            }, childCount: recommendReason.length),
          );
  }
}
