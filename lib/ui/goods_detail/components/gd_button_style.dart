import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

///详情中使用
ButtonStyle gdButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return backWhite;
    }),
    padding: MaterialStateProperty.all(EdgeInsets.only(left: 10)));
