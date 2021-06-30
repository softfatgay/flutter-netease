import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageAPP extends StatefulWidget {
  final Map arguments;

  const WebViewPageAPP(this.arguments);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPageAPP> {
  WebViewController _webController;
  final cookieManager = WebviewCookieManager();
  final globalCookie = GlobalCookie();

  String _url = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _url = widget.arguments['url'];
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
        ..httpOnly = false
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            WebView(
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
                String aa = await _webController.getTitle();
                setState(() {
                  _title = aa;
                });
                final updateCookie = await globalCookie.globalCookieValue(url);
                print('更新Cookie========================>');
                print(updateCookie);
                if (updateCookie.length > 0 &&
                    updateCookie.contains('yx_csrf')) {
                  CookieConfig.cookie = updateCookie;
                }
              },
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(bottom: BorderSide(color: lineColor, width: 0.5))),
              height: 46,
              child: Row(
                children: <Widget>[
                  InkResponse(
                    child: Container(
                      width: 50,
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: textBlack,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        _title == null ? '' : _title,
                        style: t16black,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
