import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/error_page.dart';
import 'package:flutter_app/ui/full_screen/full_screenImage.dart';
import 'package:flutter_app/ui/goods_detail/LookPage.dart';
import 'package:flutter_app/ui/goods_detail/brand_info_page.dart';
import 'package:flutter_app/ui/goods_detail/comment_page.dart';
import 'package:flutter_app/ui/goods_detail/good_detail_page.dart';
import 'package:flutter_app/ui/goods_detail/search_index_page.dart';
import 'package:flutter_app/ui/goods_detail/select_address_page.dart';
import 'package:flutter_app/ui/home/hot_list_page.dart';
import 'package:flutter_app/ui/home/king_kong_page.dart';
import 'package:flutter_app/ui/home/new_item_page.dart';
import 'package:flutter_app/ui/home/qr_code_result.dart';
import 'package:flutter_app/ui/home/qr_scan_page.dart';
import 'package:flutter_app/ui/mine/add_address_page.dart';
import 'package:flutter_app/ui/mine/coupon_page.dart';
import 'package:flutter_app/ui/mine/feedback_page.dart';
import 'package:flutter_app/ui/mine/for_services_page.dart';
import 'package:flutter_app/ui/mine/gift_card_page.dart';
import 'package:flutter_app/ui/mine/location_manage_page.dart';
import 'package:flutter_app/ui/mine/login.dart';
import 'package:flutter_app/ui/mine/order/order_detail_page.dart';
import 'package:flutter_app/ui/mine/order/order_list_page.dart';
import 'package:flutter_app/ui/mine/pay_safe_page.dart';
import 'package:flutter_app/ui/mine/points_center_page.dart';
import 'package:flutter_app/ui/mine/red_package_use_page.dart';
import 'package:flutter_app/ui/mine/red_packet_page.dart';
import 'package:flutter_app/ui/mine/reward_num_page.dart';
import 'package:flutter_app/ui/mine/saturday_buy_page.dart';
import 'package:flutter_app/ui/order_init/order_init_page.dart';
import 'package:flutter_app/ui/setting/about_page.dart';
import 'package:flutter_app/ui/setting/scrollView.dart';
import 'package:flutter_app/ui/setting/setting_page.dart';
import 'package:flutter_app/ui/shopingcart/cart_pool_page.dart';
import 'package:flutter_app/ui/shopingcart/get_cars_page.dart';
import 'package:flutter_app/ui/shopingcart/get_coupons_page.dart';
import 'package:flutter_app/ui/shopingcart/make_up_page.dart';
import 'package:flutter_app/ui/shopingcart/payment_page.dart';
import 'package:flutter_app/ui/shopingcart/shopping_cart_page.dart';
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

  static Map<String, Function> routes = {
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
    goodDetail: (context, {params}) => GoodsDetailPage(params: params),

    ///商品详情选择地址
    selectAddressPage: (context, {params}) => SelectAddressPage(),

    ///分类
    catalogTag: (context, {params}) => SortListPage(params: params),

    ///kingKong
    kingKong: (context, {params}) {
      String schemeUrl = params['schemeUrl'];
      if (schemeUrl.contains("categoryId")) {
        return KingKongPage(params: params);
      } else {
        return NewItemPage(params: params);
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
    cartItemPoolPage: (context, {params}) => CartItemPoolPage(),

    ///订单确认页面
    orderInitPage: (context, {params}) => OrderInitPage(params: params),

    ///用户信息
    userInfoPage: (context, {params}) => UserIndexPage(params: params),

    ///感兴趣分类
    favorite: (context, {params}) => FavoritePage(),

    ///感兴趣分类
    addNewSize: (context, {params}) => AddNewSize(params: params),

    ///去使用红包
    redPackageUsePage: (context, {params}) => RedPackageUsePage(params: params),

    ///去使用红包
    getCouponPage: (context, {params}) => GetCouponPage(),

    ///去使用红包
    makeUpPage: (context, {params}) => MakeUpPage(params: params),

    ///用户信息
    userInfoPageIndex: (context, {params}) {
      var id = params['id'];
      switch (id) {
        case 0:
          return UserInfoPage();
          break;
        case 1:
          return QRCodeMinePage();
          break;
        case 2:
          return MineSizePage();
          break;
        case 4:
          return PointCenterPage();
          break;
      }
    },

    ///回馈金等
    mineTopItems: (context, {params}) {
      var id = params['id'];
      switch (id) {
        case 1: //  回馈金
          return RewardNumPage(
            params: params,
          );
          break;
        case 2: //
          return RedPacketPage();
          break;
        case 3:
          return CouponPage();
          break;
        case 4: //津贴
          return RewardNumPage(
            params: params,
          );
          break;
        case 5: //礼品卡
          return GiftCardPage(
            params: params,
          );
          break;
      }
      return ErrorPage();
    },

    ///orderList
    mineItems: (context, {params}) {
      var id = params['id'];
      switch (id) {
        case 0: //订单界面
          return OrderListPage();
          break;
        case 1: //  账号管理
          return AccountManagePage();
          break;
        case 2: //  账号管理
          return SaturdayTBuyPage();
          break;
        case 3:
          return ForServicesPage();
          break;
        case 4: //邀请返利
          return QRCodeMinePage();
          break;
        case 6: //积分中心
          return PointCenterPage();
          break;
        case 8: //地址管理
          return LocationManagePage();
          break;
        case 9: //支付安全
          return PaySafeCenterPage();
          break;
        case 11: //反馈
          return FeedBack();
          break;
        case 5: //优先购
        case 7: //会员俱乐部
        case 10: //帮助客服
        case 12: //关于
        case 13: //关于
          return WebViewPage({'url': params['item']['url']});
          break;
      }

      return ErrorPage();
    },
    //专题详情
    setting: (context, {params}) {
      var id = params['id'];
      switch (id) {
        case 0: //关于界面
          return AboutPage();
          break;
        case 1: //登录
          return Login();
          break;
        case 2: //设置界面
          return SettingPage();
          break;
        case 3: //组件
          return ErrorPage();
          break;
        case 4: //组件
          return ScrollViewDemo();
          break;
        case 5: //收藏界面
          return ErrorPage();
          break;
      }
      return ErrorPage();
    },
  };

  ///组件跳转

  static link(Widget widget, String routeName, BuildContext context,
      [Map params, Function callBack]) {
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
      [Map params, Function callBack]) {
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
    final Function pageContentBuilder = Routers.routes[routeSettings.name];
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
    } else {
      return MaterialPageRoute(builder: (context) => ErrorPage());
    }
  }

  static pop(context) {
    Navigator.pop(context);
  }
}
