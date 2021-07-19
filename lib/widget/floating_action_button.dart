import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/utils/router.dart';
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
      height: 40,
      width: 40,
      margin: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backLightYellow,
      ),
      child: Icon(
        Icons.arrow_upward,
        color: backWhite,
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
      height: 40,
      width: 40,
      margin: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backLightYellow,
      ),
      child: Icon(
        Icons.shopping_cart_outlined,
        color: backWhite,
      ),
    ),
    onTap: () {
      Routers.push(Routers.shoppingCart, context, {'from': 'detail'});
    },
  );
}
