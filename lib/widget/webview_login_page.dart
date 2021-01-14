import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef void OnValueChanged(bool result);

class WebLoginWidget extends StatefulWidget {
  final OnValueChanged onValueChanged;

  const WebLoginWidget({Key key, this.onValueChanged}) : super(key: key);

  @override
  _WebLoginState createState() => _WebLoginState();
}

class _WebLoginState extends State<WebLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _loginPage(context),
        Container(
          height: ScreenUtil().setHeight(120),
          color: Color(0xFFF2F5F4),
        )
      ],
    );
  }

  _loginPage(BuildContext context) {
    final globalCookie = GlobalCookie();
    Widget webLogin = WebView(
      //JS执行模式 是否允许JS执行
      initialUrl: LOGIN_PAGE_URL,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (url) async {},
      onPageFinished: (url) async {
        final updateCookie = await globalCookie.globalCookieValue(url);
        print('更新Cookie-------------->');
        print(updateCookie.toString());
        if (updateCookie.length > 0) {
          CookieConfig.cookie = updateCookie;
          _checkLogin();
        }
      },
    );
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Colors.white,
      child: webLogin,
    );
  }

  ///检查是否登录
  _checkLogin() async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    };
    Map<String, dynamic> header = {"Cookie": cookie};
    var responseData = await checkLogin(params, header: header);
    var isLogin = responseData.data;
    setState(() {
      if (isLogin) {
        widget.onValueChanged(isLogin);
      }
    });
  }
}
