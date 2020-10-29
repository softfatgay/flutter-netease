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

///用户账号相关
Future<ResponseData> getUserAlias(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(USER_ALIASINFO, queryParameters: parameters,headers: header);
}

///周六一起拼
Future<ResponseData> getPinCategoryList(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(PIN_GROUP, queryParameters: parameters,headers: header);
}


///周六一起拼数据列表
Future<ResponseData> getPinDataList(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(PIN_GROUP_LIST, queryParameters: parameters,headers: header);
}

///地址列表
Future<ResponseData> getLocationList(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(LOCATION_LIST, queryParameters: parameters,headers: header);
}

///删除地址
Future<ResponseData> deleteAddress(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(DELETE_ASSRESS, queryParameters: parameters,headers: header);
}

///省份
Future<ResponseData> getProvenceList(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(PROVINCE_LIST, queryParameters: parameters,headers: header);
}

///市
Future<ResponseData> getCityList(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(CITY_LIST, queryParameters: parameters,headers: header);
}
///区县
Future<ResponseData> getDisList(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(DIS_LIST, queryParameters: parameters,headers: header);
}

///街道
Future<ResponseData> getTown(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.get(TOWN_LIST, queryParameters: parameters,headers: header);
}

///添加地址
Future<ResponseData> addAddress(Map<String, dynamic> parameters,{Map<String, dynamic> header}) async {
  return await HttpManager.post(ADD_ADDRESS, queryParameters: parameters,headers: header);
}


