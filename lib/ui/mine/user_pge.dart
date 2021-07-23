import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/model/minePageItems.dart';
import 'package:flutter_app/ui/mine/model/phoneStatusModel.dart';
import 'package:flutter_app/ui/mine/model/userModel.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/button_widget.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/user_page_header.dart';
import 'package:flutter_app/widget/webview_login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  bool _isLogin = true;
  var _phoneStatusModel;

  bool _firstLoading = true;
  List<MinePageItems> _mineItems = [];
  UserModel _userInfo;
  String _userIcon =
      'https://yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png';

  //动画控制器

  double _expandedHeight = 200;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    HosEventBusUtils.on((event) async {
      if (event == 'mine_refresh') {
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
    setState(() {
      if (isLogin != null) {
        _isLogin = isLogin;
      } else {
        _isLogin = false;
      }
    });
    if (isLogin) {
      _getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildRefresh();
  }

  _buildRefresh() {
    return RefreshIndicator(
        child: _buildBody(),
        onRefresh: () async {
          _checkLogin();
        });
  }

  _buildBody() {
    return _isLogin
        ? Scaffold(
            backgroundColor: backColor,
            body: _firstLoading
                ? Loading()
                : (_userInfo == null ? Container() : _buildContent()))
        : _loginPage(context);
  }

  _buildContent() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: UserHeader(
            showBack: false,
            title: '',
            collapsedHeight: 50,
            userInfo: _userInfo,
            expandedHeight: _expandedHeight,
            paddingTop: MediaQuery.of(context).padding.top,
          ),
        ),
        // _buildTop(context),
        _buildTitle(context),
        _buildMineItems(context),
        _buildMonthCard(context, _userInfo.monthCardEntrance),
        _buildMonthCard(context, _userInfo.welfareCardEntrance),
        _line(10.0),
        _buildActivity(context),
        _buildAdapter(context),
        _line(1),
        _line(10.0),
        _loginOut(context),
        _line(150.0),
      ],
    );
  }

  void _getUserInfo() async {
    try {
      var responseData = await getUserInfo();
      setState(() {
        _userInfo = UserModel.fromJson(responseData.data);
        _setUserInfo();
      });
      var userInfoItems = await getUserInfoItems();
      List data = userInfoItems.data;
      List<MinePageItems> mineItems = [];

      data.forEach((element) {
        mineItems.add(MinePageItems.fromJson(element));
      });
      setState(() {
        _mineItems = mineItems;
        _firstLoading = false;
      });
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
            "image": "assets/images/mine/phone.png",
            "url":
                "https://m.you.163.com/ucenter/mymobile?mobile=${_phoneStatusModel.mobile}&status=${_phoneStatusModel.status}&callback=https://m.you.163.com/ucenter",
            "id": 12
          });
        });
      }
    }
  }

  _buildTop(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(15, MediaQuery.of(context).padding.top, 18, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEFB965),
            Color(0xFFFFD883),
          ],
        ),
      ),
      height: 140 + MediaQuery.of(context).padding.top,
      child: Stack(
        children: [
          GestureDetector(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                        image: NetworkImage('$_userIcon'),
                        fit: BoxFit.cover,
                      ),
                    ), // 通过 container 实现圆角
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userInfo.userSimpleVO.nickname,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          _userInfo.userSimpleVO.memberLevel == 0
                              ? "普通用户"
                              : "vip用户",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          'assets/images/mine/mine_page_qr.png',
                          color: backWhite,
                          width: 25,
                          height: 25,
                        ),
                      ),
                      onTap: () {
                        Routers.push(
                            Routers.userInfoPageIndex, context, {'id': 1});
                      },
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Routers.push(Routers.userInfoPage, context);
            },
          ),
        ],
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return singleSliverWidget(Container(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
        color: backWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "我的资产",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: double.infinity,
              height: 1,
              color: lineColor,
            )
          ],
        ),
      ),
    ));
  }

  _buildMineItems(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 5,
      children: _mineItems.map<Widget>((item) {
        Widget widget = Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    item.fundType == 1 || item.fundType == 4
                        ? "¥${item.fundValue}"
                        : "${item.fundValue}",
                    style: t16blackbold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    item.fundName,
                    style: t12black,
                  ),
                )
              ],
            ),
          ),
        );
        return Routers.link(widget, Routers.mineTopItems, context,
            {"id": item.fundType, "value": item.fundValue});
      }).toList(),
    );
  }

  _buildMonthCard(BuildContext context, WelfareCardEntrance monthCardEntrance) {
    return singleSliverWidget(
      monthCardEntrance == null
          ? Container()
          : GestureDetector(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFF8E4DF)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: monthCardEntrance.iconPicUrl ?? '',
                      height: 30,
                    ),
                    CachedNetworkImage(
                      imageUrl: monthCardEntrance.titleUrl ?? '',
                      height: 20,
                      fit: BoxFit.fitWidth,
                    ),
                    Text(
                      monthCardEntrance.title ?? '',
                      style: t14black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      color: textBlack,
                      height: 15,
                      width: 1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        monthCardEntrance.content,
                        style: t14black,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: redColor,
                      size: 16,
                    )
                  ],
                ),
              ),
              onTap: () {
                Routers.push(
                    Routers.webView, context, {'url': monthCardEntrance.url});
              },
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
      padding: EdgeInsets.symmetric(horizontal: 8),
      sliver: SliverGrid.count(
        childAspectRatio: 1.3,
        crossAxisCount: 3,
        children: mineSettingItems.map<Widget>((item) {
          Widget widget = Container(
            decoration: BoxDecoration(
              color: backWhite,
            ),
            margin: EdgeInsets.all(0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item["image"],
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  item["name"],
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
    WelfareFissionInfo welfareFissionInfo = _userInfo.welfareFissionInfo;
    return singleSliverWidget(welfareFissionInfo == null
        ? Container()
        : Container(
            margin: EdgeInsets.all(10),
            child: CachedNetworkImage(imageUrl: welfareFissionInfo.picUrl),
          ));
  }

  _loginOut(BuildContext context) {
    // Color(0xFFFFD883)
    return singleSliverWidget(
      Container(
        color: backColor,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: NormalBtn('退出登录', backWhite, () async {
          var globalCookie = GlobalCookie();
          var bool = await globalCookie.clearCookie();
          if (bool) {
            CookieConfig.cookie = '';
            _checkLogin();
          }
        }, textStyle: t16grey),
      ),
    );
  }

  _loginPage(BuildContext context) {
    // Routers.push(Util.webLogin, context,{},_callback);

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
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _userInfo.userSimpleVO.nickname);
    await prefs.setString(
        'pointsCnt', _userInfo.userSimpleVO.pointsCnt.toString());
  }

  var mineSettingItems = [
    {
      "name": "我的订单",
      "status": "0",
      "image": "assets/images/mine/dingdan.png",
      "id": 0
    },
    {
      "name": "账号管理",
      "status": "0",
      "image": "assets/images/mine/zhanghaoguanli.png",
      "id": 1
    },
    {
      "name": "周六一起拼",
      "status": "0",
      "image": "assets/images/mine/zhouliu.png",
      "id": 2
    },
    {
      "name": "售后服务",
      "status": "0",
      "image": "assets/images/mine/shouhoufuwu.png",
      "id": 3
    },
    {
      "name": "邀请返利",
      "status": "0",
      "image": "assets/images/mine/yaoqingfanli.png",
      "id": 4
    },
    {
      "name": "优先购",
      "status": "0",
      "image": "assets/images/mine/youxiangou.png",
      "url": "https://m.you.163.com/preemption/index.html",
      "id": 5
    },
    {
      "name": "积分中心",
      "status": "0",
      "image": "assets/images/mine/jifenzhongxin.png",
      "id": 6
    },
    {
      "name": "会员俱乐部",
      "status": "0",
      "image": "assets/images/mine/huiyuanzhongxin.png",
      "url": "https://m.you.163.com/membership/index",
      "id": 7
    },
    {
      "name": "地址管理",
      "status": "0",
      "image": "assets/images/mine/dizhiguanli.png",
      "id": 8
    },
    {
      "name": "支付安全",
      "status": "0",
      "image": "assets/images/mine/zhifuanquan.png",
      "id": 9
    },
    {
      "name": "帮助与客服",
      "status": "0",
      "image": "assets/images/mine/kefu.png",
      "url": "https://cs.you.163.com/client?k=$kefuKey",
      "id": 10
    },
    {
      "name": "意见反馈",
      "status": "0",
      "image": "assets/images/mine/yijianfankui.png",
      "id": 11
    },
    {
      "name": "我的拍卖",
      "status": "0",
      "image": "assets/images/mine/paimai.png",
      "url": "https://m.you.163.com/auction/wap/profile/list",
      "id": 13
    }
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    HosEventBusUtils.off();
    super.dispose();
  }
}

//https://m.you.163.com/xhr/order/getList.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&size=10&lastOrderId=0&status=5
