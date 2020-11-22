import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/http_manager/http_manager.dart';
import 'package:flutter_app/http_manager/response_data.dart';
import 'package:flutter_app/utils/user_config.dart';

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
Future<ResponseData> kingKongNewItemData(
    Map<String, dynamic> parameters) async {
  return await HttpManager.get(ORDER_NEW_ITEM, queryParameters: parameters);
}

Future<ResponseData> kingKongDataNoId(Map<String, dynamic> parameters) async {
  return await HttpManager.get(URL_KING_KONG_NO_ID,
      queryParameters: parameters);
}

Future<ResponseData> getUserInfoItems(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(USER_INFO_ITEMS,
      queryParameters: parameters, headers: header);
}

Future<ResponseData> getUserInfo(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(USER_INFO,
      queryParameters: parameters, headers: header);
}

///订单列表
Future<ResponseData> getOrderList(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(ORDER_LIST,
      queryParameters: parameters, headers: header);
}

///删除订单
Future<ResponseData> deleteOrder(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(DELETE_ORDER,
      queryParameters: parameters, headers: header);
}

///用户账号相关
Future<ResponseData> getUserAlias(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(USER_ALIASINFO,
      queryParameters: parameters, headers: header);
}

///周六一起拼
Future<ResponseData> getPinCategoryList(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(PIN_GROUP,
      queryParameters: parameters, headers: header);
}

///周六一起拼数据列表
Future<ResponseData> getPinDataList(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(PIN_GROUP_LIST,
      queryParameters: parameters, headers: header);
}

///地址列表
Future<ResponseData> getLocationList(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(LOCATION_LIST,
      queryParameters: parameters, headers: header);
}

///删除地址
Future<ResponseData> deleteAddress(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(DELETE_ASSRESS,
      queryParameters: parameters, headers: header);
}

///省份
Future<ResponseData> getProvenceList(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(PROVINCE_LIST,
      queryParameters: parameters, headers: header);
}

///市
Future<ResponseData> getCityList(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(CITY_LIST,
      queryParameters: parameters, headers: header);
}

///区县
Future<ResponseData> getDisList(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(DIS_LIST,
      queryParameters: parameters, headers: header);
}

///街道
Future<ResponseData> getTown(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(TOWN_LIST,
      queryParameters: parameters, headers: header);
}

///添加地址
Future<ResponseData> addAddress(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(ADD_ADDRESS,
      queryParameters: parameters, headers: header);
}

///二维码
Future<ResponseData> qrCode(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(QR_CODE,
      queryParameters: parameters, headers: header);
}

///
Future<ResponseData> getUserSpmcInfo(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(GET_USER_SPMCINFO,
      queryParameters: parameters, headers: header);
}

///热销好物
Future<ResponseData> rewardRcmd(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(REWARD_RCMD,
      queryParameters: parameters, headers: header);
}

///红包
Future<ResponseData> redPacket(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(RED_PACKET,
      queryParameters: parameters, headers: header);
}

///优惠券
Future<ResponseData> couponList(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(COUPON_LIST,
      queryParameters: parameters, headers: header);
}

///商品详情
Future<ResponseData> goodDetailData(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(GOOD_DETAIL,
      queryParameters: parameters, headers: header);
}

///购物车
Future<ResponseData> shoppingCart(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(SHOPPING_CART,
      queryParameters: parameters, headers: header);
}
///购物车 全选/不选
Future<ResponseData> shoppingCartCheck(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(SHOPPING_CART_CHECK,
      queryParameters: parameters, headers: header);
}
///购物车 选/不选
Future<ResponseData> shoppingCartCheckOne(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(SHOPPING_CART_CHECK_ONE,
      queryParameters: parameters, headers: header);
}
///购物车 选购数量
Future<ResponseData> shoppingCartCheckNum(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(SHOPPING_CART_CHECK_NUM,
      queryParameters: parameters, headers: header);
}

///购物车 删除商品
Future<ResponseData> deleteCart(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(DELETE_CART, queryParameters: parameters,headers: header);
}


///热销榜/标题
Future<ResponseData> hotListCat(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(HOT_LIST_CAT,
      queryParameters: parameters, headers: header);
}
///热销榜/条目
Future<ResponseData> hotList(Map<String, dynamic> parameters,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(HOT_LIST_LIST,
      queryParameters: parameters, headers: header);
}
