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
}
