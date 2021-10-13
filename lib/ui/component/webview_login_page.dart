import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef void OnValueChanged(bool result);

const _tips = '部分手机登录页面，邮箱登录密码弹出软键盘导致页面空白，没有找到解决办法，正常输入就可以，收回键盘页面会正常显示';

class WebLoginWidget extends StatefulWidget {
  final OnValueChanged onValueChanged;

  const WebLoginWidget({Key key, this.onValueChanged}) : super(key: key);

  @override
  _WebLoginWidgetState createState() => _WebLoginWidgetState();
}

class _WebLoginWidgetState extends State<WebLoginWidget> {
  final _webController = Completer<WebViewController>();

  String _url = '';
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backPress(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildBody(),
      ),
    );
  }

  _backPress(BuildContext context) async {
    var controller = await _webController.future.then((value) => value);
    print(await controller.canGoBack());
    if (await controller.canGoBack()) {
      _webController.future.then((value) => value.goBack());
    } else {
      Navigator.pop(context);
    }
  }

  _buildBody() {
    final globalCookie = GlobalCookie();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            alignment: Alignment.center,
            child: Text(
              '$_tips',
              style: t10red,
            ),
            height: 45,
            color: warmingBack,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 45,
            child: WebView(
              initialUrl: LOGIN_PAGE_URL,
              //JS执行模式 是否允许JS执行
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) async {
                controller.loadUrl(
                  LOGIN_PAGE_URL,
                  headers: {"Cookie": cookie},
                );
                _webController.complete(controller);
              },
              onPageStarted: (url) async {
                hideTop();
              },
              onPageFinished: (url) async {
                hideTop();
                final updateCookie = await globalCookie.globalCookieValue(url);
                print('更新Cookie-------------->');
                print(updateCookie.toString());
                if (updateCookie.length > 0) {
                  CookieConfig.cookie = updateCookie;
                  _checkLogin();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  ///检查是否登录
  _checkLogin() async {
    var responseData = await checkLogin();
    var isLogin = responseData.data;
    setState(() {
      if (isLogin) {
        widget.onValueChanged(isLogin);
      }
    });
  }

  //隐藏头部
  String hideHeaderJs() {
    var js = "document.querySelector('.hdWraper').style.display = 'none';";
    return js;
  }

  //隐藏打开appicon
  String hideOpenAppJs() {
    var js = "document.querySelector('.X_icon_5982').style.display = 'none';";
    return js;
  }

  void hideTop() {
    Timer(Duration(milliseconds: 10), () {
      try {
        if (_webController != null) {
          _webController.future.then((value) {
            value.evaluateJavascript(hideHeaderJs()).then((result) {});
            value.evaluateJavascript(hideOpenAppJs()).then((result) {});
          });
        }
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _webController.future.then((value) => value.clearCache());
    super.dispose();
  }
}
