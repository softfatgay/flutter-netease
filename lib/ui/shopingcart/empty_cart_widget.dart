import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cart_none.png',
            width: 96,
            height: 96,
          ),
          Padding(padding: EdgeInsets.all(8.0)),
          Text("去添加点什么吧！")
        ],
      ),
    );
  }
}
