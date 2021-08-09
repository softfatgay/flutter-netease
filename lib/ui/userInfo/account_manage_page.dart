import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/userInfo/model/accountMGModel.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/global.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class AccountManagePage extends StatefulWidget {
  @override
  _AccountManagePageState createState() => _AccountManagePageState();
}

class _AccountManagePageState extends State<AccountManagePage> {
  var _tabs = [
    {'name': '手机', 'icon': 'assets/images/phone_icon.png', 'value': '未关联'},
    {'name': '邮箱', 'icon': 'assets/images/email_icon.png', 'value': '未关联'},
    {'name': '微信', 'icon': 'assets/images/wechat_icon.png', 'value': '未关联'},
    {'name': 'QQ', 'icon': 'assets/images/qq_icon.png', 'value': '未关联'},
    {'name': '微博', 'icon': 'assets/images/weibo_icon.png', 'value': '未关联'},
    {
      'name': 'Apple ID',
      'icon': 'assets/images/apple_icon.png',
      'value': '未关联'
    },
  ];

  var _accountMGModel = AccountMGModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserAlias();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = _buildItems();
    items.add(_buildBottom());

    return Scaffold(
      appBar: TopAppBar(
        title: '账号管理',
      ).build(context),
      body: Column(
        children: items,
      ),
    );
  }

  _buildItems() {
    return _accountMGModel.alias
        .map<Widget>((item) => GestureDetector(
              child: Container(
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: lineColor, width: 0.5))),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(width: 1, color: lineColor),
                        ),
                        height: 20,
                        width: 20,
                        child: _imageIcon(item),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          _tabTitle(item),
                          style: t14black,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${item.mobile == null || item.mobile.isEmpty ? item.alias : item.mobile}',
                            style: t14black,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: _changeAccount(item),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                if (item.mobile != null && item.mobile.isNotEmpty) {
                  Routers.push(Routers.webView, context, {
                    'url':
                        'https://m.you.163.com/user/securityCenter/updateMobile'
                  });
                }
              },
            ))
        .toList();
  }

  _tabTitle(AliasItem item) {
    var aliasType = item.aliasType;
    String tabtitle = '';
    if (aliasType == 27) {
      tabtitle = '手机';
    } else if (aliasType == 29) {
      tabtitle = '邮箱';
    }
    return tabtitle;
  }

  _imageIcon(AliasItem item) {
    var aliasType = item.aliasType;
    if (aliasType == 27) {
      return Image.asset('assets/images/phone_icon.png', color: textGrey);
    } else if (aliasType == 29) {
      return Image.asset('assets/images/email_icon.png', color: textGrey);
    }
    return Container();
  }

  void _getUserAlias() async {
    var responseData = await getUserAlias();
    setState(() {
      _accountMGModel = AccountMGModel.fromJson(responseData.data);
    });
  }

  _buildBottom() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '以上关联仅作为登录方式使用',
        style: TextStyle(color: textGrey, fontSize: 12),
      ),
    );
  }

  _changeAccount(AliasItem item) {
    if (item.mobile != null && item.mobile.isNotEmpty) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '换绑',
            style: t14black,
          ),
          SizedBox(
            width: 5,
          ),
          arrowRightIcon
        ],
      );
    }
    return Container();
  }
}
