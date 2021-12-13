import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/button_widget.dart';
import 'package:flutter_app/component/sliver_refresh_indicator.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/component/webview_login_page.dart';
import 'package:flutter_app/ui/mine/components/user_page_header.dart';
import 'package:flutter_app/ui/mine/model/minePageItems.dart';
import 'package:flutter_app/ui/mine/model/phoneStatusModel.dart';
import 'package:flutter_app/ui/mine/model/userModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/eventbus_constans.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';
import 'package:flutter_app/utils/local_storage.dart';

class UserPage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  bool _isLogin = true;
  late var _phoneStatusModel;

  bool _firstLoading = true;
  List<MinePageItems> _mineItems = [];
  late UserModel _userInfo;

  //动画控制器
  double _expandedHeight = 180;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    HosEventBusUtils.on((dynamic event) async {
      if (event == REFRESH_MINE) {
        _checkLogin();
        _getUserInfo();
      }
    });
    _checkLogin();
  }

  ///检查是否登录
  _checkLogin() async {
    var responseData = await checkLogin();
    var isLogin = responseData.data;

    if (isLogin == null) {
      setState(() {
        _isLogin = false;
      });
    } else {
      setState(() {
        _isLogin = isLogin;
      });
      if (isLogin) {
        _getUserInfo();
        Timer(Duration(seconds: 1), () {
          HosEventBusUtils.fire(REFRESH_CART_NUM);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }
        return Future.value(false);
      },
      child: _buildBody(),
    );
  }

  _buildBody() {
    return _isLogin
        ? Scaffold(
            backgroundColor: backColor,
            body: _firstLoading ? Loading() : _buildContent())
        : _loginPage(context);
  }

  _buildContent() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: UserHeader(
            avatar: _userInfo.userSimpleVO!.avatar,
            showBack: false,
            title: '',
            collapsedHeight: 50,
            userInfo: _userInfo,
            expandedHeight: _expandedHeight,
            paddingTop: MediaQuery.of(context).padding.top,
          ),
        ),
        SliverRefreshIndicator(refresh: _checkLogin, top: false),
        // _buildTop(context),
        _buildTitle(context),
        _buildMineItems(context),
        _buildMonthCard(context, _userInfo.monthCardEntrance),
        _buildMonthCard(context, _userInfo.welfareCardEntrance),
        _buildActivity(context),
        _buildAdapter(context),
        _loginOut(context),
        _line(10.0),
      ],
    );
  }

  void _getUserInfo() async {
    try {
      var responseData = await getUserInfo();
      if (responseData.code == '200') {
        setState(() {
          _userInfo = UserModel.fromJson(responseData.data);
          _setUserInfo();
        });
      }
      var userInfoItems = await getUserInfoItems();
      if (userInfoItems.code == '200') {
        List data = userInfoItems.data;
        List<MinePageItems> mineItems = [];

        data.forEach((element) {
          mineItems.add(MinePageItems.fromJson(element));
        });
        setState(() {
          _mineItems = mineItems;
          _firstLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _firstLoading = false;
      });
    }
    getPhoneStatus();
  }

  void getPhoneStatus() async {
    var responseData = await phoneStatus();

    if (responseData.code == '200') {
      if (responseData.data != null &&
          responseData.data['mobile'] != null &&
          responseData.data['ucMobile'] != null &&
          mineSettingItems.length < 14) {
        setState(() {
          _phoneStatusModel = PhoneStatusModel.fromJson(responseData.data);
          mineSettingItems.insert(2, {
            "name": "我的手机号",
            "status": "${_phoneStatusModel.status}",
            "url":
                "${NetConstants.baseUrl}ucenter/mymobile?mobile=${_phoneStatusModel.mobile}&status=${_phoneStatusModel.status}&callback=${NetConstants.baseUrl}ucenter",
            "id": 12,
            "pic": "assets/images/user/mine_item_3.png",
          });
        });
      }
    }
  }

  _buildTitle(BuildContext context) {
    return singleSliverWidget(Container(
      child: Container(
        color: backWhite,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          margin: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: lineColor, width: 1))),
          child: Text(
            "我的资产",
            style: t15black,
          ),
        ),
      ),
    ));
  }

  _buildMineItems(BuildContext context) {
    return singleSliverWidget(
      Container(
        color: backWhite,
        child: Stack(
          children: [
            Row(
              children: _mineItems
                  .map<Widget>((item) => _minItemItem(item, context))
                  .toList(),
            ),
            if (!_showRedPackageNum())
              Positioned(
                left: MediaQuery.of(context).size.width * 1.5 / 5 + 5,
                top: 6,
                child: Container(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFF74134),
                          Color(0xFFFF8462),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      '${_mineItems[1].toast}',
                      style: t10white,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  _minItemItem(MinePageItems item, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          color: backWhite,
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  item.fundType == 1 || item.fundType == 4
                      ? "¥${item.fundValue}"
                      : "${item.fundValue}",
                  style: num16BlackBold),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  item.fundName!,
                  style: t12black,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Routers.push(Routers.mineTopItems, context,
              {"id": item.fundType, "value": item.fundValue});
        },
      ),
    );
  }

  bool _showRedPackageNum() {
    return _mineItems.isEmpty ||
        _mineItems.length < 2 ||
        _mineItems[1].toast == null ||
        _mineItems[1].toast!.isEmpty;
  }

  _buildMonthCard(
      BuildContext context, WelfareCardEntrance? monthCardEntrance) {
    return singleSliverWidget(
      monthCardEntrance == null
          ? Container()
          : Container(
              color: backWhite,
              child: GestureDetector(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFFFF6F4),
                      border: Border.all(color: Color(0xFFFCE1DF), width: 1)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: monthCardEntrance.iconPicUrl ?? '',
                        height: 25,
                      ),
                      CachedNetworkImage(
                        imageUrl: monthCardEntrance.titleUrl ?? '',
                        height: 20,
                        fit: BoxFit.fitWidth,
                      ),
                      Text(
                        '${monthCardEntrance.title ?? ' '}',
                        style: t14black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        color: textBlack,
                        height: 12,
                        width: 1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '${monthCardEntrance.content ?? ''}',
                          style: t14black,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      if (monthCardEntrance.buttonName != null &&
                          monthCardEntrance.buttonName!.isNotEmpty)
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                                color: backRed,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              '${monthCardEntrance.buttonName}',
                              style: TextStyle(
                                  fontSize: 12, height: 1.1, color: textWhite),
                            ),
                          ),
                          onTap: () {
                            Routers.push(Routers.webView, context,
                                {'url': monthCardEntrance.url});
                          },
                        )
                    ],
                  ),
                ),
                onTap: () {
                  Routers.push(
                      Routers.webView, context, {'url': monthCardEntrance.url});
                },
              ),
            ),
    );
  }

  _line(double height) {
    return singleSliverWidget(Container(
      height: height,
      color: backColor,
    ));
  }

  _buildAdapter(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      sliver: SliverGrid.count(
        childAspectRatio: 1.3,
        crossAxisCount: 3,
        children: mineSettingItems.map<Widget>((item) {
          Widget widget = Container(
            decoration: BoxDecoration(color: backWhite),
            margin: EdgeInsets.all(0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item["pic"] as String,
                  width: 35,
                  height: 35,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  item["name"] as String,
                  style: t12black,
                ),
              ],
            ),
          );
          return Routers.link(widget, Routers.mineItems, context,
              {"id": item['id'], "item": item});
        }).toList(),
      ),
    );
  }

  _buildActivity(BuildContext context) {
    WelfareFissionInfo? welfareFissionInfo = _userInfo.welfareFissionInfo;
    return singleSliverWidget(
      welfareFissionInfo == null
          ? Container()
          : Container(
              decoration: BoxDecoration(color: backWhite),
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: GestureDetector(
                child: CachedNetworkImage(imageUrl: welfareFissionInfo.picUrl!),
                onTap: () {
                  Routers.push(Routers.webView, context,
                      {'url': '${welfareFissionInfo.schemeUrl}'});
                },
              ),
            ),
    );
  }

  _loginOut(BuildContext context) {
    return singleSliverWidget(
      Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        color: backColor,
        child: NormalBtn('退出登录', backWhite, () async {
          var globalCookie = GlobalCookie();
          var bool = await globalCookie.clearCookie();
          if (bool) {
            CookieConfig.cookie = '';
            _checkLogin();
          }
        }, textStyle: t14darkGrey),
      ),
    );
  }

  _loginPage(BuildContext context) {
    return WebLoginWidget(
      onValueChanged: (value) {
        if (value) {
          setState(() {
            _isLogin = value;
          });
          _getUserInfo();
        }
      },
    );
  }

  void _setUserInfo() async {
    var sp = await LocalStorage.sp;
    sp!.setString(LocalStorage.userName, _userInfo.userSimpleVO!.nickname!);
    sp.setString(LocalStorage.userIcon, _userInfo.userSimpleVO!.avatar!);
    sp.setString(
        LocalStorage.pointsCnt, _userInfo.userSimpleVO!.pointsCnt.toString());
  }

  var mineSettingItems = [
    {
      "name": "我的订单",
      "status": "0",
      "id": 0,
      "pic": "assets/images/user/mine_item_1.png",
    },
    {
      "name": "账号管理",
      "status": "0",
      "id": 1,
      "pic": "assets/images/user/mine_item_2.png",
    },
    {
      "name": "周六一起拼",
      "status": "0",
      "id": 2,
      "pic": "assets/images/user/mine_item_4.png",
    },
    {
      "name": "售后服务",
      "status": "0",
      "id": 3,
      "pic": "assets/images/user/mine_item_5.png",
    },
    {
      "name": "邀请返利",
      "status": "0",
      "id": 4,
      "pic": "assets/images/user/mine_item_6.png",
    },
    {
      "name": "优先购",
      "status": "0",
      "url": "${NetConstants.baseUrl}preemption/index.html",
      "id": 5,
      "pic": "assets/images/user/mine_item_7.png",
    },
    {
      "name": "积分中心",
      "status": "0",
      "id": 6,
      "pic": "assets/images/user/mine_item_8.png",
    },
    {
      "name": "会员俱乐部",
      "status": "0",
      "url": "${NetConstants.baseUrl}membership/index",
      "id": 7,
      "pic": "assets/images/user/mine_item_9.png",
    },
    {
      "name": "地址管理",
      "status": "0",
      "id": 8,
      "pic": "assets/images/user/mine_item_10.png",
    },
    {
      "name": "支付安全",
      "status": "0",
      "id": 9,
      "pic": "assets/images/user/mine_item_11.png",
    },
    {
      "name": "帮助与客服",
      "status": "0",
      "url": "${NetConstants.baseUrl}help/new#/",
      "id": 10,
      "pic": "assets/images/user/mine_item_12.png",
    },
    {
      "name": "意见反馈",
      "status": "0",
      "id": 11,
      "pic": "assets/images/user/mine_item_13.png",
    },
    {
      "name": "我的拍卖",
      "status": "0",
      "url": "${NetConstants.baseUrl}auction/wap/profile/list",
      "id": 13,
      "pic": "assets/images/user/mine_item_14.png",
    }
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    HosEventBusUtils.off();
    super.dispose();
  }
}
