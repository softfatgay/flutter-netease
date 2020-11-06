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
final String USER_ALIASINFO = "${NetContants.baseUrl}xhr/user/aliasInfo.json";
final String PIN_GROUP = "${NetContants.baseUrl}pin/group/item/index";
final String PIN_GROUP_LIST = "${NetContants.baseUrl}pin/group/item/list";
final String LOCATION_LIST = "${NetContants.baseUrl}xhr/address/list.json";
final String DELETE_ASSRESS = "${NetContants.baseUrl}xhr/address/deleteAddress.json";
final String PROVINCE_LIST = "${NetContants.baseUrl}xhr/address/getProvince.json";
final String CITY_LIST = "${NetContants.baseUrl}xhr/address/getCity.json";
final String DIS_LIST = "${NetContants.baseUrl}xhr/address/getDistrict.json";
final String TOWN_LIST = "${NetContants.baseUrl}xhr/address/getTown.json";
final String ADD_ADDRESS = "${NetContants.baseUrl}xhr/address/upsertAddress.json";
final String QR_CODE = "${NetContants.baseUrl}xhr/user/qrCode.json";
final String GET_USER_SPMCINFO = "${NetContants.baseUrl}xhr/supermc/getUserSpmcInfo.json";
final String REWARD_RCMD = "${NetContants.baseUrl}xhr/bonus/rcmd.json";
final String RED_PACKET = "${NetContants.baseUrl}xhr/redpacket/list.json";
final String COUPON_LIST = "${NetContants.baseUrl}xhr/coupon/list.json";
final String GOOD_DETAIL = "${NetContants.baseUrl}item/detail.json";




// https://m.you.163.com/item/newItem.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603704250732&


// https://m.you.163.com/item/cateList.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603173469343&categoryId=

///kingkong
// https://m.you.163.com/item/list.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603334436519&style=pd&categoryId=1005002

// https://m.you.163.com/xhr/user/myFund.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///订单列表
// https://m.you.163.com/xhr/order/getList.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&size=10&lastOrderId=0&status=0

///福利社
// https://m.you.163.com/xhr/saleCenter/index.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

// https://m.you.163.com/xhr/user/aliasInfo.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///周六一起拼
// https://m.you.163.com/pin/group/item/index?csrf_token=61f57b79a343933be0cb10aa37a51cc8


///周六一起拼数据列表
// https://m.you.163.com/pin/group/item/list?csrf_token=61f57b79a343933be0cb10aa37a51cc8&tabId=0&page=1&pageSize=10

// https://m.you.163.com/pin/group/item/list?csrf_token=61f57b79a343933be0cb10aa37a51cc8&categoryId=1005000&page=1&pageSize=10



///删除地址
//https://m.you.163.com/xhr/address/deleteAddress.json?csrf_token=f3c512bd7f5e552a9cd72ddacde4ef83&id=85723006
///地址
// https://m.you.163.com/xhr/address/list.json?csrf_token=f3c512bd7f5e552a9cd72ddacde4ef83
///省
// https://m.you.163.com/xhr/address/getProvince.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&withOverseasCountry=true
///市
//https://m.you.163.com/xhr/address/getCity.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&parentId=130000
///区县
//https://m.you.163.com/xhr/address/getDistrict.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&grandParentId=130000&parentId=130100
///街道
//https://m.you.163.com/xhr/address/getTown.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&parentId=130104
///添加地址
//https://m.you.163.com/xhr/address/upsertAddress.json?csrf_token=e0c09646e43d88a4315216febe03ede5
///qrCode
// https://m.you.163.com/xhr/user/qrCode.json?csrf_token=6f1045179c0bd2422d7afc03edac1668

///
//https://m.you.163.com/xhr/supermc/getUserSpmcInfo.json?csrf_token=6f1045179c0bd2422d7afc03edac1668
///热销好物推荐
// https://m.you.163.com/xhr/bonus/rcmd.json?csrf_token=6f1045179c0bd2422d7afc03edac1668
///红包
//https://m.you.163.com/xhr/redpacket/list.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8
///优惠券
//https://m.you.163.com/xhr/coupon/list.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&searchType=3&page=1
///商品详情
//https://m.you.163.com/item/detail.json?id=3986088
