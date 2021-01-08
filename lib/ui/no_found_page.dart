import 'package:flutter/material.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class NoFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        title: '未索引页面',
      ).build(context),
      body: Material(
        child: Center(
          child: Text(
            '此页面暂未开发',
            style: TextStyle(fontSize: 25, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
