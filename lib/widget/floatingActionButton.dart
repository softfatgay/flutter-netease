import 'package:flutter/material.dart';
import 'package:flutter_app/widget/colors.dart';

FloatingActionButton floatingActionButton(ScrollController _scrollController) {
  return FloatingActionButton(
    mini: true,
    backgroundColor: Color(0x80D2001A),
    onPressed: () {
      _scrollController.position.jumpTo(0);
    },
    tooltip: 'Increment',
    child: Icon(
      Icons.arrow_upward,
      color: backWhite,
    ),
  );
}

Widget floatingAB(ScrollController _scrollController) {
  return GestureDetector(
    child: Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0x80D2001A),
      ),
      child:  Icon(
        Icons.arrow_upward,
        color: backWhite,
      ),
    ),
    onTap: () {
      _scrollController.position.jumpTo(0);
    },
  );
}
