import 'package:flutter/material.dart';
import 'package:flutter_app/component/service_tag_widget.dart';
import 'package:flutter_app/constant/fonts.dart';

// ServerTagWidget
class EmptyCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/cart_none.png',
                width: 124,
                height: 124,
              ),
              Text(
                "去添加点什么吧",
                style: t14lightGrey,
              )
            ],
          ),
        ),
        Container(
          color: Color(0xFFEEEEEE),
          child: ServerTagWidget(),
        )
      ],
    );
  }
}
