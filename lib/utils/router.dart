import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ui/goodsDetail/comment_page.dart';
import 'package:flutter_app/ui/goodsDetail/good_detail.dart';
import 'package:flutter_app/ui/home/hot_list.dart';
import 'package:flutter_app/ui/home/king_kong_page.dart';
import 'package:flutter_app/ui/home/new_item_page.dart';
import 'package:flutter_app/ui/mine/add_address.dart';
import 'package:flutter_app/ui/mine/coupon.dart';
import 'package:flutter_app/ui/mine/for_services.dart';
import 'package:flutter_app/ui/mine/gift_card.dart';
import 'package:flutter_app/ui/mine/location_manage.dart';
import 'package:flutter_app/ui/mine/login.dart';
import 'package:flutter_app/ui/mine/order_list.dart';
import 'package:flutter_app/ui/mine/qr_code_mine.dart';
import 'package:flutter_app/ui/mine/red_packet.dart';
import 'package:flutter_app/ui/mine/reward_num.dart';
import 'package:flutter_app/ui/mine/saturday_buy.dart';
import 'package:flutter_app/ui/mine/user_setting.dart';
import 'package:flutter_app/ui/no_found_page.dart';
import 'package:flutter_app/ui/setting/Setting.dart';
import 'package:flutter_app/ui/setting/about.dart';
import 'package:flutter_app/ui/setting/favorite.dart';
import 'package:flutter_app/ui/setting/scrollView.dart';
import 'package:flutter_app/ui/sort/search.dart';
import 'package:flutter_app/ui/sort/sort_list.dart';
import 'package:flutter_app/ui/webview_page.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/FullScreenImage.dart';
import 'package:flutter_app/widget/widget_list.dart';

class Routers {
  static String plugin = Util.flutter2activity;
  static var demoPlugin = MethodChannel(plugin);

  static Map<String, Function> routes = {
    Util.goodDetailTag: (context, {arguments}) =>
        GoodsDetail(arguments: arguments),
    //商品详情
    Util.catalogTag: (context, {arguments}) => SortList(arguments: arguments),
    //kingKong
    Util.kingKong: (context, {arguments}) {
      String schemeUrl = arguments['schemeUrl'];
      if (schemeUrl.contains("categoryId")) {
        return KingKongPage(arguments: arguments);
      } else {
        return NewItemPage(arguments: arguments);
      }
    },

    //专题详情
    Util.search: (context, {arguments}) => SearchGoods(arguments: arguments),
    //评论
    Util.comment: (context, {arguments}) => CommentList(arguments: arguments),

    //添加地址
    Util.addAddress: (context, {arguments}) => AddAddress(arguments: arguments),

    //热销榜
    Util.hotlist: (context, {arguments}) => Hotlist(),

    ///大图
    Util.image: (context, {arguments}) => FullScreenImage(arguments),

    ///webView
    Util.webView: (context, {arguments}) => WebViewPage(arguments),

    ///回馈金等
    Util.mineTopItems: (context, {arguments}) {
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
    Util.mineItems: (context, {arguments}) {
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
        case 7: //会员俱乐部
          return WebViewPage(arguments);
          break;
        case 8: //地址管理
          return LocationManage();
          break;
      }

      return NoFoundPage();
    },
    //专题详情
    Util.setting: (context, {arguments}) {
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
          return WidgetList();
          break;
        case 4: //组件
          return ScrollViewDemo();
          break;
        case 5: //收藏界面
          return Favorite();
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
