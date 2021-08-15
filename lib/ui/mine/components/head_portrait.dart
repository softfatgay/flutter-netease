import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeadPortrait extends StatelessWidget {
  final String url;

  const HeadPortrait({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: Colors.white,width: 1),
        image: DecorationImage(
          image: NetworkImage(
            url,
          ),
          fit: BoxFit.fill,
        ),
      ), // 通过 container 实现圆角
    );
  }
}
