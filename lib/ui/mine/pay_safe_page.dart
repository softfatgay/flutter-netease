import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class PaySafeCenterPage extends StatefulWidget {
  @override
  _PaySafeCenterPageState createState() => _PaySafeCenterPageState();
}

class _PaySafeCenterPageState extends State<PaySafeCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        title: '支付安全',
      ).build(context),
      body: Container(
        child: Column(
          children: tabs.map((item) {
            return GestureDetector(
              child: Container(
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                      border: item['id'] == 7
                          ? null
                          : Border(
                              bottom: BorderSide(color: lineColor, width: 1))),
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            '${item['name']}',
                            style: t16black,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: textGrey,
                        size: 16,
                      )
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
          'https://m.you.163.com/user/securityCenter/setPayPwd?fromSource=securityCenterV2',
      'name': '应用支付密码',
      'icon': Icons.loop
    },
  ];
}
