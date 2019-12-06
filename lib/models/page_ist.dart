import 'dart:convert';
import 'package:flutter_app/models/gank_info.dart';

class PageList {
  bool error;
  List<GankInfo> results;

  PageList.fromParams({this.error, this.results});

  PageList.fromJson(jsonRes) {
    error = jsonRes['error'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']) {
      results
          .add(resultsItem == null ? null : new GankInfo.fromJson(resultsItem));
    }
  }

  factory PageList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ?  PageList.fromJson(json.decode(jsonStr))
          :  GankInfo.fromJson(jsonStr);
}
