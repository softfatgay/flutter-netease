import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/http_manager/http_manager.dart';
import 'package:flutter_app/http_manager/response_data.dart';

Future<ResponseData> homeData(Map<String, dynamic> parameters) async {
  return await HttpManager.get(URL_HOME_NEW, queryParameters: parameters);
}

Future<ResponseData> sortData(Map<String, dynamic> parameters) async {
  return await HttpManager.get(URL_SORT_NEW, queryParameters: parameters);
}

Future<ResponseData> sortListData(Map<String, dynamic> parameters) async {
  return await HttpManager.get(URL_SORT_LIST_NEW, queryParameters: parameters);
}

Future<ResponseData> kingKongData(Map<String, dynamic> parameters) async {
  return await HttpManager.get(URL_KING_KONG, queryParameters: parameters);
}



