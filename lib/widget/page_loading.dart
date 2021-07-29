import 'package:flutter/material.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class PageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar().build(context),
      body: Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
          height: 22,
          width: 22,
        ),
      ),
    );
  }
}
