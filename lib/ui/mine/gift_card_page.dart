import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/component/app_bar.dart';

///账户中没有礼品
class GiftCardPage extends StatefulWidget {
  final Map? params;

  const GiftCardPage({Key? key, this.params}) : super(key: key);

  @override
  _GiftCardPageState createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: TopAppBar(
        title: '礼品卡',
      ).build(context),
      body: Column(
        children: [
          _buildCard(),
          Expanded(
            child: _noCard(),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  10, 10, 10, MediaQuery.of(context).padding.bottom + 10),
              height: 65 + MediaQuery.of(context).padding.bottom,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: redColor, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 16,
                      color: textRed,
                    ),
                    Text(
                      '添加礼品卡',
                      style: t16red,
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              _checkIfSetPsw();
            },
          )
        ],
      ),
    );
  }

  _checkIfSetPsw() async {
    var responseData = await checkIfSetPsw();
    if (responseData.code == '200') {
      if (responseData.data) {
      } else {
        _showSetPswDialog();
      }
    }
  }

  _buildCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/lipinka_header_back.png'),
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '礼品卡余额',
                  style: t14white,
                ),
                SizedBox(height: 5),
                Text(
                  '¥${double.parse(widget.params!['value'].toString())}',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: textWhite),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      '支付安全',
                      style: t12white,
                    ),
                  ),
                  onTap: () {
                    _goWebView('${NetContants.baseUrl}user/securityCenter');
                  },
                )
              ],
            ),
          ),
          Positioned(
            right: 15,
            child: GestureDetector(
              child: Container(
                child: Row(
                  children: [
                    Text(
                      '交易记录',
                      style: t12white,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              onTap: () {
                _goWebView(
                    '${NetContants.baseUrl}giftCard/records?giftCardGroup=0');
              },
            ),
          )
        ],
      ),
    );
  }

  _goWebView(String url) {
    Routers.push(Routers.webView, context, {'url': url});
  }

  _noCard() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          child: Column(
            children: [
              Image.asset(
                'assets/images/no_gift_card.png',
                width: 100,
                height: 120,
                fit: BoxFit.fitWidth,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  '去买张礼品卡充值吧',
                  style: t12grey,
                ),
              ),
              GestureDetector(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '了解详情 >',
                        style: t12grey,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Routers.push(Routers.webView, context,
                      {'url': '${NetContants.baseUrl}help/new#/29'});
                },
              )
            ],
          ),
        )
      ],
    );
  }

  void _showSetPswDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                // border: Border.all(color: textGrey, width: 1),
                // borderRadius: BorderRadius.circular(4),
                ),
            child: Text(
              '使用礼品卡必须启用支付密码',
              style: t16black,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: t14grey,
              ),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '前去设置',
                style: t14red,
              ),
              onPressed: () {
                Routers.push(Routers.mineItems, context, {'id': 9}, (value) {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
