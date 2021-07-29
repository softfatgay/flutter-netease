import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/main/mainContex.dart';
import 'package:flutter_app/ui/home/home_page.dart';
import 'package:flutter_app/ui/mine/user_pge.dart';
import 'package:flutter_app/ui/shopingcart/shopping_cart_page.dart';
import 'package:flutter_app/ui/sort/sort_page.dart';
import 'package:flutter_app/ui/topic/index.dart';
import 'package:flutter_app/utils/eventbus_constans.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';
import 'package:flutter_app/utils/user_config.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BottomNavigationBarItem> _itemList;
  final _pageController = PageController();

  int _tabIndex = 0;

  var _homeNew = HomePage();
  var _topicPage = TopicPage();
  var _sortNew = SortPage();
  var _shoppingCart = ShoppingCartPage();
  var _userPage = UserPage();

  @override
  Widget build(BuildContext context) {
    var bottomNaviBar = _bottomNaviBar();
    mainContext = context;
    //获取屏幕宽高
    _saveScreenInfo(context);
    return Scaffold(
      backgroundColor: backColor,
      body: PageView(
        children: <Widget>[
          _homeNew,
          _sortNew,
          _topicPage,
          _shoppingCart,
          _userPage,
        ],
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: bottomNaviBar,
        onTap: (int index) {
          setState(() {
            _tabIndex = index;
            _pageController.jumpToPage(index);
          });
          if (_tabIndex == 3) {
            HosEventBusUtils.fire(REFRESH_CART);
          }
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        iconSize: 20,
        currentIndex: _tabIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HosEventBusUtils.on((event) {
      if (event == REFRESH_CART_NUM) {
        _getMiniCartNum();
      }
    });
    _initData();
    _getMiniCartNum();
  }

  void _initData() {
    if (itemNames.isEmpty) {
      itemNames.add(_Item('首页', 'assets/images/ic_tab_home_active.png',
          'assets/images/ic_tab_home_normal.png'));
      itemNames.add(_Item('分类', 'assets/images/ic_tab_group_active.png',
          'assets/images/ic_tab_group_normal.png'));
      itemNames.add(_Item('值得买', 'assets/images/ic_tab_subject_active.png',
          'assets/images/ic_tab_subject_normal.png'));
      itemNames.add(_Item('购物车', 'assets/images/ic_tab_cart_active.png',
          'assets/images/ic_tab_cart_normal.png',
          cartNum: _cartNum));
      itemNames.add(_Item('个人', 'assets/images/ic_tab_profile_active.png',
          'assets/images/ic_tab_profile_normal.png'));
    } else {
      itemNames[3] = _Item('购物车', 'assets/images/ic_tab_cart_active.png',
          'assets/images/ic_tab_cart_normal.png',
          cartNum: _cartNum);
    }

    // if (_itemList == null) {
    //   _itemList = itemNames.map(
    //     (item) {
    //       return item.name == '购物车'
    //           ? BottomNavigationBarItem(
    //               icon: Stack(
    //                 children: [
    //                   Image.asset(
    //                     item.normalIcon,
    //                     width: 22.0,
    //                     height: 22.0,
    //                   ),
    //                   Positioned(
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                           color: backRed,
    //                           borderRadius: BorderRadius.circular(10)),
    //                       child: Text(
    //                         '${item.cartNum}',
    //                         style: t10white,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               label: item.name,
    //               activeIcon: Image.asset(
    //                 item.activeIcon,
    //                 width: 22.0,
    //                 height: 22.0,
    //               ),
    //             )
    //           : BottomNavigationBarItem(
    //               icon: Image.asset(
    //                 item.normalIcon,
    //                 width: 22.0,
    //                 height: 22.0,
    //               ),
    //               label: item.name,
    //               activeIcon: Image.asset(
    //                 item.activeIcon,
    //                 width: 22.0,
    //                 height: 22.0,
    //               ),
    //             );
    //     },
    //   ).toList();
    // }
  }

  final List<_Item> itemNames = [];

  _saveScreenInfo(BuildContext context) async {
//    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//    final width = MediaQuery.of(context).size.width;
//    final height = MediaQuery.of(context).size.height;
//    SharedPreferences prefs = await _prefs;
//    prefs.setDouble('screen_width', width);
//    prefs.setDouble('screen_height', height);
  }

  String _cartNum = '0';

  void _getMiniCartNum() async {
    final globalCookie = GlobalCookie();
    CookieConfig.cookie = await globalCookie.globalCookieValue(LOGIN_PAGE_URL);
    var responseData = await miniCartNum();
    if (responseData.code == '200') {
      setState(() {
        if (responseData.data > 99) {
          _cartNum = '99+';
        } else {
          _cartNum = responseData.data.toString();
        }
      });
    }
  }

  _bottomNaviBar() {
    return itemNames.map((item) {
      if (item.name == '购物车') {
        return BottomNavigationBarItem(
          icon: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 11),
                child: Image.asset(
                  item.normalIcon,
                  width: 22.0,
                  height: 22.0,
                ),
              ),
              _cartNum == '0'
                  ? Container()
                  : Positioned(
                      right: 18,
                      top: 0,
                      child: Container(
                        constraints:
                            BoxConstraints(minHeight: 15, minWidth: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: backRed,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          '$_cartNum',
                          style: t10white,
                        ),
                      ),
                    ),
            ],
          ),
          label: item.name,
          activeIcon: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  item.activeIcon,
                  width: 22.0,
                  height: 22.0,
                ),
              ),
              _cartNum == '0'
                  ? Container()
                  : Positioned(
                      right: 18,
                      top: 0,
                      child: Container(
                        constraints:
                            BoxConstraints(minHeight: 15, minWidth: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: backRed,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          '$_cartNum',
                          style: t10white,
                        ),
                      ),
                    ),
            ],
          ),
        );
      } else {
        return BottomNavigationBarItem(
          icon: Image.asset(
            item.normalIcon,
            width: 22.0,
            height: 22.0,
          ),
          label: item.name,
          activeIcon: Image.asset(
            item.activeIcon,
            width: 22.0,
            height: 22.0,
          ),
        );
      }
    }).toList();
  }
}

class _Item {
  String name, activeIcon, normalIcon, cartNum;

  _Item(this.name, this.activeIcon, this.normalIcon, {this.cartNum});
}
