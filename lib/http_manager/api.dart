import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/http_manager/http_manager.dart';
import 'package:flutter_app/http_manager/response_data.dart';
import 'package:flutter_app/utils/user_config.dart';

Future<ResponseData> homeData(Map<String, dynamic> params) async {
  return await HttpManager.get(URL_HOME_NEW, params: params);
}

Future<ResponseData> sortData(Map<String, dynamic> params) async {
  return await HttpManager.get(URL_SORT_NEW, params: params);
}

Future<ResponseData> sortListData(Map<String, dynamic> params) async {
  return await HttpManager.get(URL_SORT_LIST_NEW, params: params);
}

Future<ResponseData> kingKongData(Map<String, dynamic> params) async {
  return await HttpManager.get(URL_KING_KONG, params: params);
}

///新品
Future<ResponseData> kingKongNewItemData(Map<String, dynamic> params) async {
  return await HttpManager.get(ORDER_NEW_ITEM, params: params);
}

Future<ResponseData> kingKongDataNoId(Map<String, dynamic> params) async {
  return await HttpManager.get(URL_KING_KONG_NO_ID, params: params);
}

Future<ResponseData> getUserInfoItems(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(USER_INFO_ITEMS, params: params, header: header);
}

Future<ResponseData> getUserInfo(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(USER_INFO, params: params, header: header);
}

///订单列表
Future<ResponseData> getOrderList(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(ORDER_LIST, params: params, header: header);
}

///删除订单
Future<ResponseData> deleteOrder(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(DELETE_ORDER, params: params, header: header);
}

///用户账号相关
Future<ResponseData> getUserAlias(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(USER_ALIASINFO, params: params, header: header);
}

///周六一起拼
Future<ResponseData> getPinCategoryList(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(PIN_GROUP, params: params, header: header);
}

///周六一起拼数据列表
Future<ResponseData> getPinDataList(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(PIN_GROUP_LIST, params: params, header: header);
}

///地址列表
Future<ResponseData> getLocationList(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(LOCATION_LIST, params: params, header: header);
}

///删除地址
Future<ResponseData> deleteAddress(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(DELETE_ASSRESS, params: params, header: header);
}

///省份
Future<ResponseData> getProvenceList(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(PROVINCE_LIST, params: params, header: header);
}

///市
Future<ResponseData> getCityList(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(CITY_LIST, params: params, header: header);
}

///区县
Future<ResponseData> getDisList(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(DIS_LIST, params: params, header: header);
}

///街道
Future<ResponseData> getTown(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(TOWN_LIST, params: params, header: header);
}

///添加地址
Future<ResponseData> addAddress(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(ADD_ADDRESS, params: params, header: header);
}

///二维码
Future<ResponseData> qrCode(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(QR_CODE, params: params, header: header);
}

///
Future<ResponseData> getUserSpmcInfo(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(GET_USER_SPMCINFO,
      params: params, header: header);
}

///热销好物
Future<ResponseData> rewardRcmd(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(REWARD_RCMD, params: params, header: header);
}

///红包
Future<ResponseData> redPacket(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(RED_PACKET, params: params, header: header);
}

///优惠券
Future<ResponseData> couponList(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(COUPON_LIST, params: params, header: header);
}

///商品详情
Future<ResponseData> goodDetailData(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(GOOD_DETAIL, params: params, header: header);
}

///购物车
Future<ResponseData> shoppingCart(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(SHOPPING_CART, params: params, header: header);
}

///购物车 全选/不选
Future<ResponseData> shoppingCartCheck(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(SHOPPING_CART_CHECK,
      params: params, header: header);
}

///购物车 选/不选
Future<ResponseData> shoppingCartCheckOne(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(SHOPPING_CART_CHECK_ONE,
      params: params, header: header);
}

///购物车 选购数量
Future<ResponseData> shoppingCartCheckNum(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(SHOPPING_CART_CHECK_NUM,
      params: params, header: header);
}

///购物车 删除商品
Future<ResponseData> deleteCart(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(DELETE_CART, params: params, header: header);
}

///热销榜/标题
Future<ResponseData> hotListCat(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(HOT_LIST_CAT, params: params, header: header);
}

///热销榜/条目
Future<ResponseData> hotList(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(HOT_LIST_LIST, params: params, header: header);
}

///值得买
Future<ResponseData> topicData(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(TOPPIC, params: params, header: header);
}

///评论
Future<ResponseData> commentListData(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(COMMENT_LIST, params: params, header: header);
}

///积分中心
Future<ResponseData> pointCenter(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(POINT_CENTER, params: params, header: header);
}

///会员俱乐部
Future<ResponseData> vipCenter(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(VIP_CENTER, params: params, header: header);
}

///加入购物车
Future<ResponseData> addCart(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(ADD_CART, params: params, header: header);
}

///订单确认界面
Future<ResponseData> orderInit(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(ORDER_INIT, params: params, header: header);
}

///检查登录
Future<ResponseData> checkLogin(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(CHECK_LOGIN, params: params, header: header);
}

///获取用户手机号
Future<ResponseData> userMobile(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(USER_MOBILE, params: params, header: header);
}

///反馈类型
Future<ResponseData> feedbackType(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(FEEDBACK_TYPE, params: params, header: header);
}

///反馈提交
Future<ResponseData> feedbackSubmit(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(FEEDBACK_SUBMIT,
      params: params, header: header);
}

///反馈提交
Future<ResponseData> getPhone(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(USERMOBILE, params: params, header: header);
}

///模糊搜索
Future<ResponseData> searchTips(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(SEARCH_TIPS, params: params, header: header);
}

///搜索关键字
Future<ResponseData> searchSearch(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(SEARCH_SEARCH, params: params, header: header);
}

///值得买列表
Future<ResponseData> findRecAuto(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(FIND_REC_AUTO, params: params, header: header);
}

///值得买头部nav
Future<ResponseData> knowNavwap(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(KNOW_NAVWAP, params: params, header: header);
}

///好评率
Future<ResponseData> commentPraiseApi(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(COMMENT_PRAISE, params: params, header: header);
}

///好评率
Future<ResponseData> commentTagsApi(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(COMMENT_TAGS, params: params, header: header);
}

///商品详情
Future<ResponseData> goodDetailApi(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.get(GOOD_DETAIL, params: params, header: header);
}

///商品详情下半部分
Future<ResponseData> goodDetailDownApi(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(GOOD_DETAIL_DOWN,
      params: params, header: header);
}

//////商品详情推荐
Future<ResponseData> wapitemRcmdApi(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(WAPITEM_RCMD, params: params, header: header);
}

///配送信息
Future<ResponseData> wapitemDeliveryApi(Map<String, dynamic> params,
    {Map<String, dynamic> header}) async {
  return await HttpManager.post(WAPITEM_DELIVERY,
      params: params, header: header);
}
