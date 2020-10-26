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

///新品
Future<ResponseData> kingKongNewItemData(Map<String, dynamic> parameters) async {
  return await HttpManager.get(ORDER_NEW_ITEM, queryParameters: parameters);
}


Future<ResponseData> kingKongDataNoId(Map<String, dynamic> parameters) async {
  return await HttpManager.get(URL_KING_KONG_NO_ID, queryParameters: parameters);
}

Future<ResponseData> getUserInfoItems(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(USER_INFO_ITEMS, queryParameters: parameters,headers: header);
}

Future<ResponseData> getUserInfo(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(USER_INFO, queryParameters: parameters,headers: header);
}
///订单列表
Future<ResponseData> getOrderList(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(ORDER_LIST, queryParameters: parameters,headers: header);
}



