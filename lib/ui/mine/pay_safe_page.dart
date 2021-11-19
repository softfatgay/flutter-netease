import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/global.dart';

class PaySafeCenterPage extends StatefulWidget {
  @override
  _PaySafeCenterPageState createState() => _PaySafeCenterPageState();
}

class _PaySafeCenterPageState extends State<PaySafeCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '账号安全',
      ).build(context),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: tabs.map((item) {
          return GestureDetector(
            child: Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  border: item['id'] == 1
                      ? null
                      : Border(
                          bottom: BorderSide(color: lineColor, width: 0.5),
                        ),
                ),
                margin: EdgeInsets.only(left: 15),
                padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          '${item['name']}',
                          style: t14black,
                        ),
                      ),
                    ),
                    arrowRightIcon
                  ],
                ),
              ),
            ),
            onTap: () {
              Routers.push(Routers.webView, context, {'url': item['url']});
            },
          );
        }).toList(),
      ),
    );
  }

  List tabs = [
    {
      'id': 0,
      'type': 2,
      'url': 'https://reg.163.com/reg/reg_mob2_retake_pw.jsp#/verifyAccount',
      'name': '修改登录密码',
      'icon': Icons.access_time_outlined
    },
    {
      'id': 1,
      'type': 2,
      'url':
          '${NetConstants.baseUrl}user/securityCenter/setPayPwd?fromSource=securityCenterV2',
      'name': '应用支付密码',
      'icon': Icons.loop
    },
  ];
}
