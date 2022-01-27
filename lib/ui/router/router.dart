import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/error_page.dart';
import 'package:flutter_app/ui/full_screen/full_screen_image.dart';
import 'package:flutter_app/ui/goods_detail/brand_info_page.dart';
import 'package:flutter_app/ui/goods_detail/comment_page.dart';
import 'package:flutter_app/ui/goods_detail/good_detail_page.dart';
import 'package:flutter_app/ui/goods_detail/item_size_detail_page.dart';
import 'package:flutter_app/ui/goods_detail/look_page.dart';
import 'package:flutter_app/ui/goods_detail/search_index_page.dart';
import 'package:flutter_app/ui/goods_detail/select_address_page.dart';
import 'package:flutter_app/ui/home/home_page.dart';
import 'package:flutter_app/ui/home/hot_list_page.dart';
import 'package:flutter_app/ui/home/king_kong_page.dart';
import 'package:flutter_app/ui/home/new_item_page.dart';
import 'package:flutter_app/ui/home/qr_code_result.dart';
import 'package:flutter_app/ui/home/qr_scan_page.dart';
import 'package:flutter_app/ui/login/index.dart';
import 'package:flutter_app/ui/main/index.dart';
import 'package:flutter_app/ui/mine/add_address_page.dart';
import 'package:flutter_app/ui/mine/address_selector.dart';
import 'package:flutter_app/ui/mine/coupon_page.dart';
import 'package:flutter_app/ui/mine/feedback_page.dart';
import 'package:flutter_app/ui/mine/for_services_page.dart';
import 'package:flutter_app/ui/mine/gift_card_page.dart';
import 'package:flutter_app/ui/mine/layway/LayawayListPage.dart';
import 'package:flutter_app/ui/mine/layway/LaywayDetailPage.dart';
import 'package:flutter_app/ui/mine/location_manage_page.dart';
import 'package:flutter_app/ui/mine/login.dart';
import 'package:flutter_app/ui/mine/order/order_detail_page.dart';
import 'package:flutter_app/ui/mine/order/order_list_page.dart';
import 'package:flutter_app/ui/mine/pay_safe_page.dart';
import 'package:flutter_app/ui/mine/points_center_page.dart';
import 'package:flutter_app/ui/mine/red_package/red_package_use_page.dart';
import 'package:flutter_app/ui/mine/red_package/red_packet_page.dart';
import 'package:flutter_app/ui/mine/reward_num_page.dart';
import 'package:flutter_app/ui/mine/vip_center_page.dart';
import 'package:flutter_app/ui/order_init/order_init_page.dart';
import 'package:flutter_app/ui/pin/pin_detail_page.dart';
import 'package:flutter_app/ui/pin/pin_main_page.dart';
import 'package:flutter_app/ui/pin/send_pin_page.dart';
import 'package:flutter_app/ui/setting/about_page.dart';
import 'package:flutter_app/ui/setting/setting_page.dart';
import 'package:flutter_app/ui/shopping_cart/all_cart_pool_page.dart';
import 'package:flutter_app/ui/shopping_cart/get_cars_page.dart';
import 'package:flutter_app/ui/shopping_cart/get_coupons_page.dart';
import 'package:flutter_app/ui/shopping_cart/make_up_page.dart';
import 'package:flutter_app/ui/shopping_cart/payment_page.dart';
import 'package:flutter_app/ui/shopping_cart/shopping_cart_page.dart';
import 'package:flutter_app/ui/sort/sort_list_page.dart';
import 'package:flutter_app/ui/userInfo/account_manage_page.dart';
import 'package:flutter_app/ui/userInfo/add_new_size.dart';
import 'package:flutter_app/ui/userInfo/favorite_page.dart';
import 'package:flutter_app/ui/userInfo/index.dart';
import 'package:flutter_app/ui/userInfo/mine_size_page.dart';
import 'package:flutter_app/ui/userInfo/qr_code_mine_page.dart';
import 'package:flutter_app/ui/userInfo/user_info_page.dart';
import 'package:flutter_app/ui/video_page.dart';
import 'package:flutter_app/ui/webview_page.dart';

class Routers {
  static const String mainPage = '/mainPage';
  static const String homePage = '/homePage';
  static const String videoPage = '/videoPage';
  static const String qrScanPage = '/qrScanPage';
  static const String qrCodeResultPage = '/qrCodeResultPage';
  static const String testPage = '/testPage';
  static const String brandTag = '/brandTag';
  static const String goodDetail = '/goodDetailTag';
  static const String catalogTag = '/catalogTag';
  static const String kingKong = '/kingKong';
  static const String topicDetail = '/topicDetail';
  static const String setting = '/setting';
  static const String search = '/search';
  static const String comment = '/comment';
  static const String image = '/image';
  static const String orderList = '/orderList';
  static const String mineItems = '/mineItems';
  static const String mineTopItems = '/mineTopItems';
  static const String addAddress = '/addAddress';
  static const String hotList = '/hotList';
  static const String orderInit = '/orderInit';
  static const String shoppingCart = '/shoppingCart';
  static const String webLogin = '/webLogin';
  static const String getCarsPage = '/getCarsPage';
  static const String cartItemPoolPage = '/cartItemPoolPage';
  static const String orderInitPage = '/orderInitPage';
  static const String webView = '/webView';
  static const String webViewPageAPP = '/WebViewPageAPP';
  static const String userInfoPageIndex = '/userInfoPageIndex';
  static const String userInfoPage = '/userInfoPage';
  static const String favorite = '/favorite';
  static const String addNewSize = '/addNewSize';
  static const String accountManagePage = '/accountManagePage';
  static const String selectAddressPage = '/selectAddressPage';
  static const String redPackageUsePage = '/redPackageUsePage';
  static const String orderDetailPage = '/orderDetailPage';
  static const String getCouponPage = '/getCouponPage';
  static const String makeUpPage = '/makeUpPage';
  static const String brandInfoPage = '/brandInfoPage';
  static const String lookPage = '/lookPage';
  static const String pinPage = '/pinPage';
  static const String sendPinPage = '/SendPinPage';
  static const String loginPage = '/loginPage';
  static const String addressSelector = '/addressSelector';
  static const String layaway = '/layaway';
  static const String layawayDetail = '/layawayDetail';
  static const String itemSizeDetailPage = '/itemSizeDetailPage';

  static Map<String, Function> routes = {
    ///登录
    loginPage: (context, {params}) => LoginPage(),

    ///主页
    mainPage: (context, {params}) => MainPage(),

    ///首页
    homePage: (context, {params}) => HomePage(),

    ///订单详情
    orderDetailPage: (context, {params}) => OrderDetailPage(params: params),

    ///晒单
    lookPage: (context, {params}) => LookPage(),

    ///品牌研究所
    brandInfoPage: (context, {params}) => BrandInfoPage(params: params),

    ///二维码扫描
    qrScanPage: (context, {params}) => QRScanPage(),

    ///视频
    videoPage: (context, {params}) => VideoPage(params: params),

    ///二维码扫描结果
    qrCodeResultPage: (context, {params}) => QRCodeResultPage(param: params),

    ///测试
    testPage: (context, {params}) => ErrorPage(),

    ///商品详情
    goodDetail: (context, {params}) =>
        GoodsDetailPage(params: params ?? {'id': 0}),

    ///拼团
    pinPage: (context, {params}) => PinDetailPage(params: params),

    ///发起拼团
    sendPinPage: (context, {params}) => SendPinPage(params: params),

    ///商品详情选择地址
    selectAddressPage: (context, {params}) => SelectAddressPage(),

    ///分类
    catalogTag: (context, {params}) => SortListPage(params: params),

    ///选择地址
    addressSelector: (context, {params}) => AddressSelector(),

    ///年购
    layaway: (context, {params}) => LayawayPage(),

    layawayDetail: (context, {params}) => LaywayDetailPage(params: params),

    ///kingKong
    kingKong: (context, {required params}) {
      String schemeUrl = params['schemeUrl'];
      if (schemeUrl.contains("item/list")) {
        return KingKongPage(params: params);
      } else if (schemeUrl.contains('item/newItem')) {
        return NewItemPage(params: params);
      } else {
        return WebViewPage({'url': schemeUrl});
      }
    },

    ///搜索
    search: (context, {params}) => SearchIndexPage(params: params),

    ///评论
    comment: (context, {params}) => CommentList(params: params),

    ///添加地址
    addAddress: (context, {params}) => AddAddressPage(params: params),

    ///热销榜
    hotList: (context, {params}) => HotListPage(param: params),

    ///大图
    image: (context, {params}) => FullScreenImage(params),

    ///确认订单
    orderInit: (context, {params}) => PaymentPage(params: params),

    ///webView
    webView: (context, {params}) => WebViewPage(params),

    ///购物车
    shoppingCart: (context, {params}) => ShoppingCartPage(params: params),

    ///购物车换购
    getCarsPage: (context, {params}) => GetCarsPage(params: params),

    ///购物车凑单
    cartItemPoolPage: (context, {params}) => AllCartItemPoolPage(),

    ///订单确认页面
    orderInitPage: (context, {params}) => OrderInitPage(params: params),

    ///用户信息
    userInfoPage: (context, {params}) => UserIndexPage(params: params),

    ///感兴趣分类
    favorite: (context, {params}) => FavoritePage(),

    ///添加尺寸
    addNewSize: (context, {params}) => AddNewSize(params: params),

    ///去使用红包
    redPackageUsePage: (context, {params}) => RedPackageUsePage(params: params),

    ///领券
    getCouponPage: (context, {params}) => GetCouponPage(),

    ///凑单
    makeUpPage: (context, {params}) => MakeUpPage(params: params),

    ///尺寸详情
    itemSizeDetailPage: (context, {params}) =>
        ItemSizeDetailPage(params: params),

    ///用户信息
    userInfoPageIndex: (context, {required params}) {
      var id = params['id'];
      switch (id) {
        case 0:
          return UserInfoPage();
        case 1:
          return QRCodeMinePage();
        case 2:
          return MineSizePage(params: params);
        case 4:
          return PointCenterPage();
      }
    },

    ///回馈金等
    mineTopItems: (context, {required params}) {
      var id = params['item'].fundType;
      switch (id) {
        case 1: //  回馈金
          return RewardNumPage(
            params: params,
          );
        case 2: //
          return RedPacketPage();
        case 3:
          return CouponPage();
        case 4: //津贴
          return RewardNumPage(
            params: params,
          );
        case 5: //礼品卡
          return GiftCardPage(
            params: params,
          );
        case 6: //积分
          return PointCenterPage();
        default:
          return WebViewPage(
              {'url': NetConstants.baseURL + params['item'].targetUrl});
      }
      return ErrorPage();
    },

    ///orderList
    mineItems: (context, {required params}) {
      var id = params['id'];
      switch (id) {
        case 0: //订单界面
          return OrderListPage(params: params);
        case 1: //  账号管理
          return AccountManagePage();
        case 2: // 拼团
          return PinMainPage();
        case 3:
          return ForServicesPage();
        case 4: //邀请返利
          return QRCodeMinePage();
        case 6: //积分中心
          return PointCenterPage();
        case 8: //地址管理
          return LocationManagePage();
        case 9: //支付安全
          return PaySafeCenterPage();
        case 11: //反馈
          return FeedBack();
        case 7: //会员俱乐部
        case 5: //优先购
        case 10: //帮助客服
        case 12: //关于
        case 13: //关于
          return WebViewPage({'url': params['item']['url']});
      }

      return ErrorPage();
    },
    //专题详情
    setting: (context, {required params}) {
      var id = params['id'];
      switch (id) {
        case 0: //关于界面
          return AboutPage();
        case 1: //登录
          return Login();
        case 2: //设置界面
          return SettingPage();
        case 3: //组件
          return ErrorPage();
        case 4: //组件
          return ErrorPage();
        case 5: //收藏界面
          return ErrorPage();
      }
      return ErrorPage();
    },
  };

  ///组件跳转

  static link(Widget widget, String routeName, BuildContext context,
      [Map? params, Function? callBack]) {
    return GestureDetector(
      onTap: () {
        if (params != null) {
          Navigator.pushNamed(context, routeName, arguments: params)
              .then((onValue) {
            if (callBack != null) {
              callBack(onValue);
            }
          });
        } else {
          Navigator.pushNamed(context, routeName).then((onValue) {
            if (callBack != null) {
              callBack(onValue);
            }
          });
        }
      },
      child: widget,
    );
  }

  ///组件跳转
  static push(String routeName, BuildContext context,
      [Map? params, Function? callBack]) {
    if (params != null) {
      Navigator.pushNamed(context, routeName, arguments: params)
          .then((onValue) {
        if (callBack != null) {
          callBack(onValue);
        }
      });
    } else {
      Navigator.pushNamed(context, routeName).then((onValue) {
        if (callBack != null) {
          callBack(onValue);
        }
      });
    }
  }

  static run(RouteSettings routeSettings) {
    final Function? pageContentBuilder = Routers.routes[routeSettings.name!];
    if (pageContentBuilder != null) {
      if (routeSettings.arguments != null) {
        return MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, params: routeSettings.arguments));
      } else {
        // 无参数路由
        return MaterialPageRoute(
            builder: (context) => pageContentBuilder(context));
      }
    }
  }

  static pop(context) {
    Navigator.pop(context);
  }
}
