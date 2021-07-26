import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  ///网络返回转换
  static response2Json(Response response) {
    return json.decode(json.encode(response.data));
  }

  ///验证手机号
  static bool isPhone(String phone) {
    return RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(phone);
  }

  ///  隐藏软键盘
  static void hideKeyBord(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String long2date(int tem) {
    DateTime time = DateTime.fromMicrosecondsSinceEpoch(tem);
    var formatter = DateFormat('yyyy.MM.dd hh时');
    return formatter.format(time);
  }

  static String long2dateD(int tem) {
    DateTime time = DateTime.fromMicrosecondsSinceEpoch(tem);
    var formatter = DateFormat('yyyy.MM.dd');
    return formatter.format(time);
  }

  static String getDayFormat(num countdown) {
    int day = 0;
    int hour = 0;

    if (countdown != null && countdown > 0) {
      var d = countdown;
      print(d);
      var e = d ~/ 1000;
      print(e);
      var f = e ~/ 3600;
      print(f);
      hour = (f % 24).toInt();
      day = f ~/ 24;
    }

    return '距结束$day天$hour小时';
  }

  static String temFormat(int tem) {
    DateTime time = DateTime.fromMicrosecondsSinceEpoch(tem);
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(time);
  }
}
