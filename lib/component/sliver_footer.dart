import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/component/loading.dart';

class SliverFooter extends StatelessWidget {
  final bool? hasMore;
  final String tipsText;

  const SliverFooter({Key? key, this.hasMore = false, this.tipsText = '没有更多了'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSliver(_buildFooter());
  }

  _buildSliver(Widget child) {
    return SliverToBoxAdapter(
      child: child,
    );
  }

  Widget _buildFooter() {
    if (!hasMore!) {
      return Container(
        height: 40,
        child: Center(
          child: Text(
            tipsText,
            style: t12grey,
          ),
        ),
      );
    } else {
      return Container(
        height: 40,
        child: Loading(),
      );
    }
  }
}
