import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/utils/user_config.dart';

final String LOGIN_PAGE_URL = "${NetContants.baseUrl}login";
final String CHECK_LOGIN = "${NetContants.baseUrl}xhr/common/checklogin.json";
final String URL_HOME_NEW = "${NetContants.baseUrl}xhr/index.json";
final String URL_SORT_NEW = "${NetContants.baseUrl}item/cateList.json";
final String URL_SORT_LIST_NEW = "${NetContants.baseUrl}item/list.json";
final String URL_KING_KONG = "${NetContants.baseUrl}item/list.json";
final String URL_KING_KONG_NO_ID =
    "${NetContants.baseUrl}xhr/item/getPreNewItem.json";
final String USER_INFO_ITEMS = "${NetContants.baseUrl}xhr/user/myFund.json";
final String USER_INFO = "${NetContants.baseUrl}xhr/user/checkConfig.json";
final String ORDER_LIST = "${NetContants.baseUrl}xhr/order/getList.json";
final String ORDER_NEW_ITEM = "${NetContants.baseUrl}item/newItem.json";
final String USER_ALIASINFO = "${NetContants.baseUrl}xhr/user/aliasInfo.json";
final String PIN_GROUP = "${NetContants.baseUrl}pin/group/item/index";
final String PIN_GROUP_LIST = "${NetContants.baseUrl}pin/group/item/list";
final String LOCATION_LIST = "${NetContants.baseUrl}xhr/address/list.json";
final String DELETE_ASSRESS =
    "${NetContants.baseUrl}xhr/address/deleteAddress.json";
final String PROVINCE_LIST =
    "${NetContants.baseUrl}xhr/address/getProvince.json";
final String CITY_LIST = "${NetContants.baseUrl}xhr/address/getCity.json";
final String DIS_LIST = "${NetContants.baseUrl}xhr/address/getDistrict.json";
final String TOWN_LIST = "${NetContants.baseUrl}xhr/address/getTown.json";
final String ADD_ADDRESS =
    "${NetContants.baseUrl}xhr/address/upsertAddress.json";
final String QR_CODE = "${NetContants.baseUrl}xhr/user/qrCode.json";
final String GET_USER_SPMCINFO =
    "${NetContants.baseUrl}xhr/supermc/getUserSpmcInfo.json";
final String REWARD_RCMD = "${NetContants.baseUrl}xhr/bonus/rcmd.json";
final String RED_PACKET = "${NetContants.baseUrl}xhr/redpacket/list.json";
final String COUPON_LIST = "${NetContants.baseUrl}xhr/coupon/list.json";

///商品详情
final String GOOD_DETAIL = "${NetContants.baseUrl}item/detail.json";
final String SHOPPING_CART = "${NetContants.baseUrl}xhr/cart/getCarts.json";
final String SHOPPING_CART_CHECK =
    "${NetContants.baseUrl}xhr/cart/selectAll.json";
final String SHOPPING_CART_CHECK_ONE =
    "${NetContants.baseUrl}xhr/cart/updateCheck.json";
final String SHOPPING_CART_CHECK_NUM =
    "${NetContants.baseUrl}xhr/cart/updateByNum.json";
final String HOT_LIST_CAT = "${NetContants.baseUrl}item/saleRank.json";
final String HOT_LIST_LIST =
    "${NetContants.baseUrl}xhr/item/saleRankItems.json";
final String DELETE_ORDER = "${NetContants.baseUrl}xhr/order/delete.json";
final String DELETE_CART = "${NetContants.baseUrl}xhr/cart/delete.json";
final String TOPPIC = "${NetContants.baseUrl}topic/index.json";
final String COMMENT_LIST =
    "${NetContants.baseUrl}xhr/comment/listByItemByTag.json";
final String POINT_CENTER = "${NetContants.baseUrl}xhr/points/index.json";
final String VIP_CENTER =
    "${NetContants.baseUrl}xhr/membership/indexPrivilege.json";
final String ADD_CART = "${NetContants.baseUrl}xhr/cart/add.json";
final String ORDER_INIT =
    "${NetContants.baseUrl}xhr/order/init.json?csrf_token=$csrf_token";
final String USER_MOBILE =
    "${NetContants.baseUrl}xhr/feedback/getUserMobile.json?csrf_token=$csrf_token";
final String FEEDBACK_TYPE = "${NetContants.baseUrl}xhr/feedback/typeList.json";
final String FEEDBACK_SUBMIT =
    "${NetContants.baseUrl}xhr/feedback/submit.json?csrf_token=$csrf_token";
final String USERMOBILE =
    "${NetContants.baseUrl}xhr/userMobile/getStatus.json?csrf_token=$csrf_token";
final String SEARCH_TIPS =
    "${NetContants.baseUrl}xhr/search/searchAutoComplete.json";
final String SEARCH_SEARCH =
    "${NetContants.baseUrl}xhr/search/search.json.json";
final String FIND_REC_AUTO = "${NetContants.baseUrl}topic/v1/find/recAuto.json";
final String KNOW_NAVWAP = "${NetContants.baseUrl}topic/v1/know/navWap.json";

///好评率
final String COMMENT_PRAISE =
    '${NetContants.baseUrl}xhr/comment/itemGoodRates.json';

///评价tags
final String COMMENT_TAGS = '${NetContants.baseUrl}xhr/comment/tags.json';

///商品详情下半部分
final String GOOD_DETAIL_DOWN = '${NetContants.baseUrl}xhr/item/detail.json';

///商品详情推荐
final String WAPITEM_RCMD = '${NetContants.baseUrl}xhr/wapitem/rcmd.json';

///配送信息
final String WAPITEM_DELIVERY =
    '${NetContants.baseUrl}xhr/wapitem/delivery.json';

///配送信息
///https://m.you.163.com/xhr/wapitem/delivery.json?csrf_token=2e0f34896f4b94471965dcfb84ecf43a

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
///购物车
//https://m.you.163.com/xhr/cart/getCarts.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8
///购物车全选/不选
//https://m.you.163.com/xhr/cart/selectAll.json?csrf_token=36afe4bc43f0ab111759b0ebcbf5a684
///购物车选/不选
//https://m.you.163.com/xhr/cart/updateCheck.json?
///购物车选购数量
//https://m.you.163.com/xhr/cart/updateByNum.json

///热销榜标题
//https://m.you.163.com/item/saleRank.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1605864254678&categoryId=0&subCategoryId=0
///热销榜条目
//https://m.you.163.com/xhr/item/saleRankItems.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8
///删除订单
//https://m.you.163.com/xhr/order/delete.json?csrf_token=fc5917b2e05041552a566a1f31fab98a&orderId=200124805

///购物车删除商品
//https://m.you.163.com/xhr/cart/delete.json?csrf_token=28f3b8193ba520fc96697b3a214c01bf

///积分中心
//https://m.you.163.com/xhr/points/index.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///会员俱乐部
//https://m.you.163.com/xhr/membership/indexPrivilege.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///加入购物车
//https://m.you.163.com/xhr/cart/add.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&cnt=1&skuId=3628032

///确认订单
//https://m.you.163.com/xhr/order/init.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///检查登录GET
//https://m.you.163.com/xhr/common/checklogin.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1610603146879&

///获取手机号
//https://m.you.163.com/xhr/feedback/getUserMobile.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///反馈类型
//https://m.you.163.com/xhr/feedback/typeList.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///反馈提交
//https://m.you.163.com/xhr/feedback/submit.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///获取手机号
// https://m.you.163.com/xhr/userMobile/getStatus.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

///值得买
//https://m.you.163.com/topic/v1/find/recAuto.json?page=1&size=2&exceptIds=

///值得买头部nav
//https://m.you.163.com/topic/v1/know/navWap.json

//https://m.you.163.com/xhr/address/list.json?csrf_token=2e0f34896f4b94471965dcfb84ecf43a&from=1

///推荐POST
///xhr/wapitem/relatedRcmd.json
