import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../utils/flutter_activity.dart';

class WebViewPage extends StatefulWidget {
  final Map arguments;

  const WebViewPage(this.arguments);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _webController;
  final cookieManager = WebviewCookieManager();
  final globalCookie = GlobalCookie();

  String _url = '';
  bool hide = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _url = widget.arguments['id'];
    });
  }

  var _title = '';

  void setcookie() async {
    if (!CookieConfig.isLogin) return;
    await cookieManager.setCookies([
      Cookie("NTES_YD_SESS", CookieConfig.NTES_YD_SESS)
        ..domain = '.163.com'
        ..path = '/'
        ..httpOnly = true,
      Cookie("P_INFO", CookieConfig.P_INFO)
        ..domain = '.163.com'
        ..path = '/'
        ..httpOnly = false,
      Cookie("yx_csrf", CookieConfig.token)
        ..domain = '.163.com'
        ..path = '/'
        ..httpOnly = false,
      Cookie("yx_app_type", 'android')
        ..domain = '.163.com'
        ..path = '/'
        ..httpOnly = false,
      Cookie("yx_app_chann", 'aos_market_oppo')
        ..domain = '.163.com'
        ..path = '/'
        ..httpOnly = false,
      Cookie("yx_from", '')
        ..domain = '.163.com'
        ..path = '/'
        ..httpOnly = false,
      Cookie("YX_SUPPORT_WEBP", '')
        ..domain = '.163.com'
        ..path = '/'
        ..httpOnly = false,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        tabs: [],
        title: _title,
      ).build(context),
      body: Container(
        child: WebView(
          initialUrl: _url,
          //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) async {
            controller.loadUrl(
              _url,
              headers: {"Cookie": cookie},
            );
            _webController = controller;
          },
          onPageStarted: (url) async {
            setcookie();
          },
          onPageFinished: (url) async {
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
            String aa = await _webController.getTitle();
            setState(() {
              _title = aa;
            });
            final updateCookie = await globalCookie.globalCookieValue(url);
            print('更新Cookie========================>');
            print(updateCookie);
            if (updateCookie.length > 0 && updateCookie.contains('yx_csrf')) {
              setState(() {
                CookieConfig.cookie = updateCookie;
              });
            }

            hideTop();
          },
        ),
      ),
    );
  }

  //
  String setJs() {
    var js = "document.querySelector('.hdWraper').style.display = 'none';";
    return js;
  }

  void hideTop() {
    _webController.evaluateJavascript(setJs()).then((result) {});
  }
}
