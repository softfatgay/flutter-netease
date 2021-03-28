import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

///底部边框
BoxDecoration bottomBorder = BoxDecoration(
    border: Border(bottom: BorderSide(color: backGrey, width: 0.5)));

BoxDecoration topBorder = BoxDecoration(
  border: Border(top: BorderSide(color: backGrey, width: 0.5)),
  color: Colors.white,
);

///右指向箭头
Icon arrowRightIcon = Icon(
  Icons.keyboard_arrow_right,
  color: textGrey,
  size: 14,
);

///icon颜色
const Color iconColor = Colors.red;
