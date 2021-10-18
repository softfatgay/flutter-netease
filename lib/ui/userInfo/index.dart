import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/user_config.dart';

class UserIndexPage extends StatefulWidget {
  final Map? params;

  const UserIndexPage({Key? key, this.params}) : super(key: key);

  @override
  _UserIndexPageState createState() => _UserIndexPageState();
}

class _UserIndexPageState extends State<UserIndexPage> {
  String _userIcon =
      'https://yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png';

  String? avatar;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      avatar = widget.params!['avatar'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '个人信息',
      ).build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _tabWidget('个人信息',
                borderRadius: 30, imageUrl: avatar ?? user_icon_url, id: 0),
            _tabWidget('我的二维码',
                borderRadius: 30,
                icon: 'assets/images/mine/qr_icon.png',
                id: 1),
            _tabWidget('我的尺码', id: 2),
            _tabWidget('会员俱乐部', subTitle: '', id: 3),
            _tabWidget('积分中心', id: 4),
          ],
        ),
      ),
    );
  }

  _tabWidget(String tab,
      {double borderRadius = 0,
      String? imageUrl,
      String? icon,
      String? subTitle,
      num? id}) {
    return GestureDetector(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: backWhite,
            border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(child: Text('$tab')),
            if (imageUrl != null)
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  border: borderRadius == 0
                      ? null
                      : Border.all(color: lineColor, width: 1),
                  image: DecorationImage(
                    image: NetworkImage('$imageUrl'),
                    fit: BoxFit.cover,
                  ),
                ), // 通过 container 实现圆角
              ),
            if (icon != null)
              Container(
                width: 20,
                height: 20,
                child: Image.asset('$icon'),
              ),
            if (subTitle != null) Text('$subTitle'),
            SizedBox(width: 5),
            arrowRightIcon
          ],
        ),
      ),
      onTap: () {
        if (id == 3) {
          Routers.push(Routers.webView, context,
              {'url': '${NetContants.baseUrl}membership/index'});
        } else {
          Routers.push(Routers.userInfoPageIndex, context, {'id': id});
        }
      },
    );
  }
}
