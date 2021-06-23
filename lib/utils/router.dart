import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ui/goodsDetail/comment_page.dart';
import 'package:flutter_app/ui/goodsDetail/good_detail_page.dart';
import 'package:flutter_app/ui/home/hot_list.dart';
import 'package:flutter_app/ui/home/king_kong_page.dart';
import 'package:flutter_app/ui/home/new_item_page.dart';
import 'package:flutter_app/ui/mine/add_address.dart';
import 'package:flutter_app/ui/mine/coupon.dart';
import 'package:flutter_app/ui/mine/feedback_page.dart';
import 'package:flutter_app/ui/mine/for_services.dart';
import 'package:flutter_app/ui/mine/gift_card.dart';
import 'package:flutter_app/ui/mine/location_manage.dart';
import 'package:flutter_app/ui/mine/login.dart';
import 'package:flutter_app/ui/mine/order_list.dart';
import 'package:flutter_app/ui/mine/pay_safe.dart';
import 'package:flutter_app/ui/mine/points_center.dart';
import 'package:flutter_app/ui/mine/qr_code_mine.dart';
import 'package:flutter_app/ui/mine/red_packet.dart';
import 'package:flutter_app/ui/mine/reward_num.dart';
import 'package:flutter_app/ui/mine/saturday_buy.dart';
import 'package:flutter_app/ui/mine/user_setting.dart';
import 'package:flutter_app/ui/no_found_page.dart';
import 'package:flutter_app/ui/order_init/order_init_page.dart';
import 'package:flutter_app/ui/setting/Setting.dart';
import 'package:flutter_app/ui/setting/about.dart';
import 'package:flutter_app/ui/setting/favorite.dart';
import 'package:flutter_app/ui/setting/scrollView.dart';
import 'package:flutter_app/ui/shopingcart/get_cars_page.dart';
import 'package:flutter_app/ui/shopingcart/payment_page.dart';
import 'package:flutter_app/ui/shopingcart/shopping_cart.dart';
import 'package:flutter_app/ui/sort/search_page.dart';
import 'package:flutter_app/ui/sort/sort_list_page.dart';
import 'package:flutter_app/ui/webview_page.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/FullScreenImage.dart';
import 'package:flutter_app/widget/widget_list.dart';

class Routers {
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

  static Map<String, Function> routes = {
    //商品详情
    goodDetailTag: (context, {arguments}) =>
        GoodsDetailPage(arguments: arguments),
    catalogTag: (context, {arguments}) => SortListPage(arguments: arguments),
    //kingKong
    kingKong: (context, {arguments}) {
      String schemeUrl = arguments['schemeUrl'];
      if (schemeUrl.contains("categoryId")) {
        return KingKongPage(arguments: arguments);
      } else {
        return NewItemPage(arguments: arguments);
      }
    },

    //专题详情
    search: (context, {arguments}) => SearchGoodsPage(arguments: arguments),
    //评论
    comment: (context, {arguments}) => CommentList(arguments: arguments),

    //添加地址
    addAddress: (context, {arguments}) => AddAddress(arguments: arguments),

    //热销榜
    hotList: (context, {arguments}) => HotListPage(param: arguments),

    ///大图
    image: (context, {arguments}) => FullScreenImage(arguments),

    ///确认订单
    orderInit: (context, {arguments}) => PaymentPage(
          arguments: arguments,
        ),

    ///webView
    webView: (context, {arguments}) => WebViewPage(arguments),

    ///webView
    webViewPageAPP: (context, {arguments}) => WebViewPage(arguments),

    ///购物车
    shoppingCart: (context, {arguments}) => ShoppingCart(argument: arguments),

    ///购物车换购
    getCarsPage: (context, {arguments}) => GetCarsPage(param: arguments),

    ///订单确认页面
    orderInitPage: (context, {arguments}) => OrderInitPage(params: arguments),

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
          return RedPacket();
          break;
        case 3:
          return Coupon();
          break;
        case 4: //津贴
          return RewardNumPage(
            arguments: arguments,
          );
          break;
        case 5: //礼品卡
          return GiftCard(
            arguments: arguments,
          );
          break;
      }
      return NoFoundPage();
    },

    ///orderList
    mineItems: (context, {arguments}) {
      var id = arguments['id'];
      switch (id) {
        case 0: //订单界面
          return OrderList();
          break;
        case 1: //  账号管理
          return UserSetting();
          break;
        case 2: //  账号管理
          return SaturdayTBuy();
          break;
        case 3:
          return ForServices();
          break;
        case 4: //邀请返利
          return QRCodeMine();
          break;
        case 5: //优先购
          return WebViewPage(
              {"url": "https://m.you.163.com/preemption/index.html"});
          break;
        case 6: //积分中心
          return PointCenter();
          break;

        case 7: //会员俱乐部
          // return VipCenter();
          return WebViewPage({"url": "https://m.you.163.com/membership/index"});
          break;
        case 8: //地址管理
          return LocationManage();
          break;
        case 9: //支付安全
          return PaySafeCenter();
          break;
        case 10: //帮助客服
          return WebViewPage(
              {'url': 'https://cs.you.163.com/client?k=$kefuKey'});
          break;
        case 11: //反馈
          return FeedBack();
          break;
      }

      return NoFoundPage();
    },
    //专题详情
    setting: (context, {arguments}) {
      var id = arguments['id'];
      switch (id) {
        case 0: //关于界面
          return AboutApp();
          break;
        case 1: //登录
          return Login();
          break;
        case 2: //设置界面
          return Setting();
          break;
        case 3: //组件
          return NoFoundPage();
          break;
        case 4: //组件
          return ScrollViewDemo();
          break;
        case 5: //收藏界面
          return NoFoundPage();
          break;
      }
      return NoFoundPage();
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
              callBack();
            }
          });
        } else {
          Navigator.pushNamed(context, routeName).then((onValue) {
            if (callBack != null) {
              callBack();
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
          callBack();
        }
      });
    } else {
      Navigator.pushNamed(context, routeName).then((onValue) {
        if (callBack != null) {
          callBack();
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
      return MaterialPageRoute(builder: (context) => NoFoundPage());
    }
  }

  static pop(context) {
    Navigator.pop(context);
  }
}
