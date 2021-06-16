import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  static String brandTag = 'brand';
  static String goodDetailTag = 'goodsDetail';
  static String catalogTag = 'catalog';
  static String kingKong = 'kingKong';
  static String topicDetail = 'topicDetail';
  static String setting = 'setting';
  static String search = 'search';
  static String comment = 'comment';
  static String image = 'image';
  static String orderList = 'orderList';
  static String mineItems = 'mineItems';
  static String mineTopItems = 'mineTopItems';
  static String addAddress = 'addAddress';
  static String hotlist = 'hotlist';
  static String orderInit = 'orderInit';
  static String shoppingCart = 'shoppingCart';
  static String webLogin = 'webLogin';
  static String getCarsPage = 'GetCarsPage';
  static String orderInitPage = 'orderInitPage';

  static const String flutter2activity =
      'plugins.want.flutter.io.GloableCookie';
  static const String flutter2activityParams = 'connect_params';
  static const String webView = 'webView';
  static const String webViewPageAPP = 'WebViewPageAPP';
  static const String feedBack = 'feedBack';

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
