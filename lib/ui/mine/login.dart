import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/tab_app_bar.dart';
import 'package:flutter_app/ui/mine/login_verification_code.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/util_mine.dart';

@Deprecated("no used")
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String imageAsset = 'assets/images/boduoxiaojie.png';
  GlobalKey _fromKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  var phone = '';
  var psw = '';
  bool checked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController.addListener(() {
      phone = _phoneController.text;
    });
    _codeController.addListener(() {
      psw = _codeController.text;
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
            title: '登录',
          ).build(context),
          Positioned(
            top: 72,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildLogo(context),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: TextField(
                            controller: _phoneController,
                            maxLines: 1,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[100],
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(2)),
                              contentPadding: EdgeInsets.only(top: 20),
                              hintText: '请输入手机号',
                              filled: true,
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
                          child: TextField(
                            controller: _codeController,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(2)),
                              hintText: '请输入密码',
                              filled: true,
                              fillColor: Colors.grey[100],
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 25,
                              ),
                            ),
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
                                            ..onTap = () {
                                              _goWebview(
                                                  'https://www.qq.com/yszc.htm');
                                            }),
                                    ]),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                          height: 44,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              if (!Util.isPhone(phone)) {
                                Toast.show('请输入正确的手机号', context);
                              } else {
                                if (psw == '') {
                                  Toast.show('请输入密码', context);
                                } else {
                                  if (!checked) {
                                    Toast.show('请同意用户协议', context);
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
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginForCode()));
              },
              child: Container(
                child: Text('验证码登录'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _goWebview(String url) {
    Routers.push(Routers.webView, context, {'url': url});
  }

  void login(BuildContext context) {
    Routers.pop(context);
  }

  buildLogo(BuildContext context) {
    return Container(
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
    );
  }
}
