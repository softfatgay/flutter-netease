import 'package:flutter/material.dart';
import 'package:flutter_app/component/tab_app_bar.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        title: '404',
      ).build(context),
      body: Material(
        child: Center(
          child: Text(
            'error:404',
            style: TextStyle(fontSize: 25, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
