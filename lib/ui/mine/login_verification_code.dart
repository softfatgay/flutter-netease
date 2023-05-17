import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/tab_app_bar.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/util_mine.dart';

@Deprecated("no used")
class LoginForCode extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginForCode> {
  final String imageAsset = 'assets/images/boduoxiaojie.png';
  Timer? _timer;
  var btnStr = '获取验证码';
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  int _time = 5;
  bool btnEnable = true;

  String phone = '';
  String code = '';
  bool isPostKeyBord = false;
  bool checked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController.addListener(() {
      phone = _phoneController.text;
    });
    _codeController.addListener(() {
      code = _codeController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          TabAppBar(
            tabs: [],
            title: '验证码登录',
          ).build(context),
          Positioned(
            top: 72,
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 90,
                            width: 90,
                            child: ClipOval(
                              child: Image.asset(
                                imageAsset,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.fromLTRB(15, 50, 15, 0),
                      child: TextField(
                        controller: _phoneController,
                        maxLines: 1,
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(2)),
                          contentPadding: EdgeInsets.only(top: 20),
                          hintText: '请输入手机号',
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: Icon(
                            Icons.mobile_screen_share,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 42,
                      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.start,
                              controller: _codeController,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(2)),
                                hintText: '请输入验证码',
                                filled: true,
                                fillColor: Colors.grey[100],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: TextButton(
                              onPressed: () {
                                if (btnStr == '获取验证码') {
                                  if (!Util.isPhone(phone)) {
                                    Toast.show('请输入正确的手机号', context);
                                  } else {
                                    _getVerification();
                                  }
                                }
                              },
                              child: Text(btnStr),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        //保持横向的子view居中
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Checkbox(
                              value: this.checked,
                              onChanged: (check) {
                                setState(() {
                                  this.checked = !this.checked;
                                });
                              },
                            ),
                          ),
                          Expanded(
                              child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14),
                                children: [
                                  TextSpan(text: '勾选即代表您同意'),
                                  TextSpan(
                                      text: '《隐私协议》',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          decoration: TextDecoration.none),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {}),
                                ]),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 50, 15, 0),
                      height: 44,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if (!Util.isPhone(phone)) {
                            Toast.show('请输入正确的手机号', context);
                          } else {
                            if (code.isEmpty) {
                              Toast.show('请输入验证码', context);
                            } else {
                              if (!checked) {
                                Toast.show('请勾选用户协议', context);
                              } else {
                                Routers.pop(context);
                              }
                            }
                          }
                        },
                        child: Text(
                          '登录',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: Container(
                child: GestureDetector(
              onTap: () {
                Routers.pop(context);
              },
              child: Text('密码登录'),
            )),
          )
        ],
      ),
    );
  }

  void login(BuildContext context) {
    Routers.pop(context);
  }

  void _getVerification() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_time > 0) {
          btnStr = '${_time--}s后重新获取';
        } else {
          btnStr = '获取验证码';
          _time = 5;
          _timer!.cancel();
          _timer = null;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer!.cancel();
    _phoneController.dispose();
    _codeController.dispose();
  }
}
