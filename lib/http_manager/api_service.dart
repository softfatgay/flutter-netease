import 'package:flutter_app/http_manager/net_contants.dart';

final String URL_HOME_NEW = "${NetContants.baseUrl}xhr/index.json";
final String URL_SORT_NEW = "${NetContants.baseUrl}item/cateList.json";
final String URL_SORT_LIST_NEW = "${NetContants.baseUrl}item/list.json";
final String URL_KING_KONG = "${NetContants.baseUrl}item/list.json";
final String URL_KING_KONG_NO_ID = "${NetContants.baseUrl}xhr/item/getPreNewItem.json";
final String USER_INFO_ITEMS = "${NetContants.baseUrl}xhr/user/myFund.json";
final String USER_INFO = "${NetContants.baseUrl}xhr/user/checkConfig.json";
final String ORDER_LIST = "${NetContants.baseUrl}xhr/order/getList.json";
final String ORDER_NEW_ITEM = "${NetContants.baseUrl}item/newItem.json";


// https://m.you.163.com/item/newItem.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603704250732&


// https://m.you.163.com/item/cateList.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603173469343&categoryId=

///kingkong
// https://m.you.163.com/item/list.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603334436519&style=pd&categoryId=1005002

// https://m.you.163.com/xhr/user/myFund.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///订单列表
// https://m.you.163.com/xhr/order/getList.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&size=10&lastOrderId=0&status=0

///福利社
// https://m.you.163.com/xhr/saleCenter/index.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8
