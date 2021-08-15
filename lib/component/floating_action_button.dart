import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/util_mine.dart';

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
      height: 35,
      width: 35,
      margin: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xBFFFFFFF),
          border: Border.all(color: lineColor, width: 0.5)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Image.asset(
          'assets/images/arrow_up.png',
          width: 12,
          height: 12,
        ),
      ),
    ),
    onTap: () {
      _scrollController.position.jumpTo(0);
    },
  );
}

Widget floatingABCart(
    BuildContext context, ScrollController _scrollController) {
  return GestureDetector(
    child: Container(
      height: 35,
      width: 35,
      margin: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xBFFFFFFF),
          border: Border.all(color: lineColor, width: 0.5)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Image.asset(
          'assets/images/ic_tab_cart_normal.png',
          width: 12,
          height: 12,
        ),
      ),
    ),
    onTap: () {
      Routers.push(Routers.shoppingCart, context, {'from': 'detail'});
    },
  );
}

Widget floatingABRefresh(BuildContext context,
    AnimationController _animalController, Function refresh) {
  return GestureDetector(
    child: Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xBFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: RotationTransition(
          turns: _animalController,
          child: Image.asset(
            'assets/images/refresh.png',
            width: 12,
            height: 12,
          ),
        ),
      ),
    ),
    onTap: () {
      refresh();
    },
  );
}
