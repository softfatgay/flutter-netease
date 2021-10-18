import 'package:flutter/material.dart';
import 'package:flutter_app/component/loading.dart';

class NormalFooter extends StatelessWidget {
  final bool hasMore;
  final String tipsText;

  const NormalFooter({Key? key, this.hasMore = false, this.tipsText = '没有更多了'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildFooter();
  }

  Widget _buildFooter() {
    if (!hasMore) {
      return Container(
        height: 40,
        child: Center(
          child: Text(
            tipsText,
            style: TextStyle(color: Colors.grey),
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
