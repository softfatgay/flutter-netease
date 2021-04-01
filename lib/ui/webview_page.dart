import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      _url = widget.arguments['url'];
      print('url=$_url');
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
            hideTop();
          },
          onPageFinished: (url) async {
            hideTop();
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
          },
          navigationDelegate: (NavigationRequest request) {
            var url = request.url;
            if (url.startsWith('https://m.you.163.com/item/detail?id=')) {
              var split = url.split('id=');
              var split2 = split[1];
              var split3 = split2.split('&')[0];
              if (split3 != null && split3.isNotEmpty) {
                Routers.push(Util.goodDetailTag, context, {'id': '$split3'});
              }
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      ),
    );
  }

  //隐藏头部
  String setJs() {
    var js = "document.querySelector('.hdWraper').style.display = 'none';";
    return js;
  }

  void hideTop() {
    Timer.periodic(Duration(milliseconds: 10), (timer) async {
      try {
        if (_webController != null) {
          _webController.evaluateJavascript(setJs()).then((result) {
            print('>>>>>>>>>>>>>>>>>>>>>>>');
            print(result);
          });
        }
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
