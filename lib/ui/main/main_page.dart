import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/main/mainContex.dart';
import 'package:flutter_app/ui/home/home_page.dart';
import 'package:flutter_app/ui/mine/user_pge.dart';
import 'package:flutter_app/ui/shopingcart/shopping_cart.dart';
import 'package:flutter_app/ui/sort/sort_page.dart';
import 'package:flutter_app/ui/topic/topic_page.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';

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
  var _shoppingCart = ShoppingCart();
  var _userPage = UserPage();

  @override
  Widget build(BuildContext context) {
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
        items: _itemList,
        onTap: (int index) {
          setState(() {
            _tabIndex = index;
            _pageController.jumpToPage(index);
          });
          if (_tabIndex == 3) {
            HosEventBusUtils.fire('refresh');
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

    if (itemNames.isEmpty) {
      itemNames.add(_Item('首页', 'assets/images/ic_tab_home_active.png',
          'assets/images/ic_tab_home_normal.png'));
      itemNames.add(_Item('分类', 'assets/images/ic_tab_group_active.png',
          'assets/images/ic_tab_group_normal.png'));
      itemNames.add(_Item('值得买', 'assets/images/ic_tab_subject_active.png',
          'assets/images/ic_tab_subject_normal.png'));
      itemNames.add(_Item('购物车', 'assets/images/ic_tab_cart_active.png',
          'assets/images/ic_tab_cart_normal.png'));
      itemNames.add(_Item('个人', 'assets/images/ic_tab_profile_active.png',
          'assets/images/ic_tab_profile_normal.png'));
    }

    if (_itemList == null) {
      _itemList = itemNames
          .map(
            (item) => BottomNavigationBarItem(
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
            ),
          )
          .toList();
    }
  }

  final itemNames = [];

  _saveScreenInfo(BuildContext context) async {
//    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//    final width = MediaQuery.of(context).size.width;
//    final height = MediaQuery.of(context).size.height;
//    SharedPreferences prefs = await _prefs;
//    prefs.setDouble('screen_width', width);
//    prefs.setDouble('screen_height', height);
  }
}

class _Item {
  String name, activeIcon, normalIcon;

  _Item(this.name, this.activeIcon, this.normalIcon);
}
