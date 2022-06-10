import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/main/mainContex.dart';
import 'package:flutter_app/ui/home/home_page.dart';
import 'package:flutter_app/ui/mine/user_pge.dart';
import 'package:flutter_app/ui/shopping_cart/shopping_cart_page.dart';
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
  final _pageController = PageController();
  int _tabIndex = 0;
  final List<_Item> itemNames = [];
  String _cartNum = '0';

  final _homeNew = HomePage();
  final _topicPage = TopicPage();
  final _sortNew = SortPage();
  final _shoppingCart = ShoppingCartPage();
  final _userPage = UserPage();

  @override
  Widget build(BuildContext context) {
    var bottomNaviBar = _bottomNaviBar();
    mainContext = context;
    //获取屏幕宽高
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
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _tabIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HosEventBusUtils.on((dynamic event) {
      if (event == REFRESH_CART_NUM) {
        _getMiniCartNum();
      } else if (event == GO_HOME) {
        setState(() {
          _tabIndex = 0;
          _pageController.jumpToPage(0);
        });
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
  }

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
    return itemNames.map<BottomNavigationBarItem>((item) {
      if (item.name == '购物车') {
        return _cartBarItem(item);
      } else {
        return _normalItem(item);
      }
    }).toList();
  }

  _normalItem(_Item item) {
    return BottomNavigationBarItem(
        label: item.name,
        icon: _icon(item.normalIcon),
        activeIcon: _icon(item.activeIcon));
  }

  _icon(String? icon) {
    return Image.asset(
      icon!,
      width: 22.0,
      height: 22.0,
    );
  }

  _cartBarItem(_Item item) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 11),
            child: _icon(item.normalIcon),
          ),
          if (_cartNum != '0') _cartNumWidget()
        ],
      ),
      label: item.name,
      activeIcon: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: _icon(item.activeIcon),
          ),
          if (_cartNum != '0') _cartNumWidget()
        ],
      ),
    );
  }

  _cartNumWidget() {
    return Positioned(
      right: 18,
      top: 0,
      child: Container(
        constraints: BoxConstraints(minHeight: 15, minWidth: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backRed,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: textWhite, width: 1)),
        child: Text(
          '$_cartNum',
          style: TextStyle(fontSize: 9, color: textWhite, height: 1.1),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
}

class _Item {
  String name, activeIcon, normalIcon;
  String? cartNum;

  _Item(this.name, this.activeIcon, this.normalIcon, {this.cartNum});
}
