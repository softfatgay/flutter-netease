import 'package:flutter/material.dart';

class NoFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '未索引页面',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),
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
