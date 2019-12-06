import 'package:flutter_app/models/daily_info.dart';
import 'package:flutter_app/models/history_list.dart';
import 'package:flutter_app/models/msg_info.dart';
import 'package:flutter_app/models/page_ist.dart';
import 'package:flutter_app/net/http_one.dart';

class NetApi {

  static Future<PageList> getListData(String type, int count,
      int pageIndex) async {
    var response = await HttpOne.getJson('data/$type/$count/$pageIndex', {});
    return PageList.fromJson(response);
  }

  static Future<DailyInfo> getDailyInfo(String date) async {
    var response = await HttpOne.getJson("day/$date", {});
    return DailyInfo.fromJson(response);
  }

  static Future<DailyInfo> getToday() async {
    var response = await HttpOne.getJson("today", {});
    return DailyInfo.fromJson(response);
  }

  static Future<HistoryList> getHistory(int count, int pageIndex) async {
    var response =
    await HttpOne.getJson("history/content/$count/$pageIndex", {});
    return HistoryList.fromJson(response);
  }

  static Future<MsgInfo> release(Map<String, dynamic> map) async {
    var response = await HttpOne.postForm("add2gank", map);
    return MsgInfo.fromJson(response);
  }

}