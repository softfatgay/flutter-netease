
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/loading.dart';

class SliverFooter extends StatelessWidget {
  final bool hasMore;
  final String tipsText;
  const SliverFooter({Key key, this.hasMore = false, this.tipsText = '没有更多了'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildSliver(buildFooter());
  }

  SliverList buildSliver(Widget child) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return child;
        }, childCount: 1));
  }

  Widget buildFooter() {
    if (!hasMore) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Text(
            tipsText,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }

}
