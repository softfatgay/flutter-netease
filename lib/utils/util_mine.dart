import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Util {
  static String brandTag = 'brand';
  static String goodDetailTag = 'goodsDetail';
  static String catalogTag = 'catalog';
  static String topicDetail = 'topicDetail';
  static String setting = 'setting';
  static String search = 'search';


  static const String flutter2activity = 'com.example.want.flutter2activity';
  static const String flutter2activityParams = 'connect_params';
  static const String webView = 'webView';

  static respone2Json(Response response) {
    return json.decode(json.encode(response.data));
  }

 static SliverList buildOneSliverList(Widget widget) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return SingleChildScrollView(
          child: widget,
        );
      }, childCount: 1),
    );
  }

  static bool isPhone(String phone){
    return RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(phone);
  }
  static void hideKeyBord(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
