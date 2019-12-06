import 'package:flutter/material.dart';

class NoMoreText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text('没有更多了'),
      ),
    );
  }
}
