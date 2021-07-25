import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/error_page.dart';
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
import 'package:flutter_app/ui/mine/order_list_page.dart';
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
import 'package:flutter_app/ui/shopingcart/get_cars_page.dart';
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
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/widget/full_screenImage.dart';

class Routers {
  static const String videoPage = 'videoPage';
  static const String qrScanPage = 'qrScanPage';
  static const String qrCodeResultPage = 'qrCodeResultPage';
  static const String testPage = 'testPage';
  static const String brandTag = 'brandTag';
  static const String goodDetailTag = 'goodDetailTag';
  static const String catalogTag = 'catalogTag';
  static const String kingKong = 'kingKong';
  static const String topicDetail = 'topicDetail';
  static const String setting = 'setting';
  static const String search = 'search';
  static const String comment = 'comment';
  static const String image = 'image';
  static const String orderList = 'orderList';
  static const String mineItems = 'mineItems';
  static const String mineTopItems = 'mineTopItems';
  static const String addAddress = 'addAddress';
  static const String hotList = 'hotList';
  static const String orderInit = 'orderInit';
  static const String shoppingCart = 'shoppingCart';
  static const String webLogin = 'webLogin';
  static const String getCarsPage = 'getCarsPage';
  static const String orderInitPage = 'orderInitPage';
  static const String webView = 'webView';
  static const String webViewPageAPP = 'WebViewPageAPP';
  static const String userInfoPageIndex = 'userInfoPageIndex';
  static const String userInfoPage = 'userInfoPage';
  static const String favorite = 'favorite';
  static const String addNewSize = 'addNewSize';
  static const String accountManagePage = 'accountManagePage';
  static const String selectAddressPage = 'selectAddressPage';
  static const String redPackageUsePage = 'redPackageUsePage';

  static Map<String, Function> routes = {
    ///二维码扫描
    qrScanPage: (context, {arguments}) => QRScanPage(),
    ///视频
    videoPage: (context, {arguments}) => VideoPage(params: arguments),

    ///二维码扫描
    qrCodeResultPage: (context, {arguments}) =>
        QRCodeResultPage(param: arguments),

    ///测试
    testPage: (context, {arguments}) => ErrorPage(),

    ///商品详情
    goodDetailTag: (context, {arguments}) =>
        GoodsDetailPage(arguments: arguments),

    ///商品详情选择地址
    selectAddressPage: (context, {arguments}) => SelectAddressPage(),

    ///分类
    catalogTag: (context, {arguments}) => SortListPage(arguments: arguments),

    ///kingKong
    kingKong: (context, {arguments}) {
      String schemeUrl = arguments['schemeUrl'];
      if (schemeUrl.contains("categoryId")) {
        return KingKongPage(arguments: arguments);
      } else {
        return NewItemPage(arguments: arguments);
      }
    },

    ///搜索
    search: (context, {arguments}) => SearchIndexPage(arguments: arguments),

    ///评论
    comment: (context, {arguments}) => CommentList(arguments: arguments),

    ///添加地址
    addAddress: (context, {arguments}) => AddAddressPage(arguments: arguments),

    ///热销榜
    hotList: (context, {arguments}) => HotListPage(param: arguments),

    ///大图
    image: (context, {arguments}) => FullScreenImage(arguments),

    ///确认订单
    orderInit: (context, {arguments}) => PaymentPage(
          arguments: arguments,
        ),

    ///webView
    webView: (context, {arguments}) => WebViewPage(arguments),

    ///购物车
    shoppingCart: (context, {arguments}) =>
        ShoppingCartPage(argument: arguments),

    ///购物车换购
    getCarsPage: (context, {arguments}) => GetCarsPage(param: arguments),

    ///订单确认页面
    orderInitPage: (context, {arguments}) => OrderInitPage(params: arguments),

    ///用户信息
    userInfoPage: (context, {arguments}) => UserIndexPage(param: arguments),

    ///感兴趣分类
    favorite: (context, {arguments}) => FavoritePage(),

    ///感兴趣分类
    addNewSize: (context, {arguments}) => AddNewSize(param: arguments),
    ///去使用红包
    redPackageUsePage: (context, {arguments}) => RedPackageUsePage(param: arguments),

    ///用户信息
    userInfoPageIndex: (context, {arguments}) {
      var id = arguments['id'];
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
    mineTopItems: (context, {arguments}) {
      var id = arguments['id'];
      switch (id) {
        case 1: //  回馈金
          return RewardNumPage(
            arguments: arguments,
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
            arguments: arguments,
          );
          break;
        case 5: //礼品卡
          return GiftCardPage(
            arguments: arguments,
          );
          break;
      }
      return ErrorPage();
    },

    ///orderList
    mineItems: (context, {arguments}) {
      var id = arguments['id'];
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
        case 10: //帮助客服
          return WebViewPage(
              {'url': 'https://cs.you.163.com/client?k=$kefuKey'});
          break;
        case 11: //反馈
          return FeedBack();
          break;
        case 5: //优先购
        case 7: //会员俱乐部
        case 12: //关于
        case 13: //关于
          return WebViewPage({'url': arguments['item']['url']});
          break;
      }

      return ErrorPage();
    },
    //专题详情
    setting: (context, {arguments}) {
      var id = arguments['id'];
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
            builder: (context) => pageContentBuilder(context,
                arguments: routeSettings.arguments));
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
