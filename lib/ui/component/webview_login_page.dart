import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

typedef void OnValueChanged(bool result);

class WebLoginWidget extends StatefulWidget {
  final OnValueChanged? onValueChanged;

  const WebLoginWidget({Key? key, this.onValueChanged}) : super(key: key);

  @override
  _WebLoginWidgetState createState() => _WebLoginWidgetState();
}

class _WebLoginWidgetState extends State<WebLoginWidget> {
  bool hide = true;
  var globalCookie = GlobalCookie();

  Timer? _timer;

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: true,
    applicationNameForUserAgent: "dface-yjxdh-webview",
  );

  _buildBody() {
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height - 45,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
              url: WebUri(LOGIN_PAGE_URL), headers: {'Cookie': cookie}),
          initialSettings: settings,
          onWebViewCreated: (controller) {
            this.webViewController = controller;
          },
          onLoadStart: (controller, url) async {
            print("------------onLoadStart");
            print(url?.uriValue.toString());
            hideTop();
            print("------------onLoadStart11111");
            final updateCookie = await globalCookie
                .globalCookieValue(
                url?.uriValue.toString() ?? NetConstants.baseURL);
            print('更新Cookie-------------->${updateCookie.toString()}');
            print(updateCookie.toString());
          },
          onLoadStop: (controller, url) async {
            print("------------onLoadStop");
            hideTop();
            await saveCookie(url);
          },
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            return ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED);
          },
          shouldOverrideUrlLoading: (controller, navigation) async {
            print("------------11111111");
            var url = navigation.request.url?.uriValue.toString() ?? '';
            print(url);
            print("------------22222222");
            var path = navigation.request.url?.path ?? '';
            print(path);
            if (path == '/') {
              await saveCookie(navigation.request.url);
              _checkLogin();
              int count = 0;
              _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
                _checkLogin();
                count += 2;
                if (count == 10) {
                  _timer?.cancel();
                }
              });
            }
          },
          onNavigationResponse: (controller, request) async {
            var path = request.response?.url?.path ?? '';
            if (path.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${path}');
              return NavigationResponseAction.ALLOW;
            }
            debugPrint('allowing navigation to ${path}');
            return NavigationResponseAction.CANCEL;
          },
        ));
  }

  Future<void> saveCookie(WebUri? url) async {
    final updateCookie = await globalCookie
        .globalCookieValue(url?.uriValue.toString() ?? NetConstants.baseURL);
    print('更新Cookie-------------->${updateCookie.toString()}');
    print(updateCookie.toString());
    if (updateCookie.isNotEmpty) {
      CookieConfig.cookie = updateCookie;
      _checkLogin();
    }
  }

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
    if (await webViewController!.canGoBack()) {
      webViewController!.canGoForward();
    } else {
      Navigator.pop(context);
    }
  }

//  /检查是否登录
  _checkLogin() async {
    if (CookieConfig.token.isEmpty) return;
    var responseData = await checkLogin();
    var isLogin = responseData.data;
    print("------------3333333");
    print('isLogin = $isLogin');
    setState(() {
      if (isLogin != null && isLogin) {
        widget.onValueChanged!(isLogin);
      }
    });
  }

//隐藏头部
  String hideHeaderJs() {
    var js =
        "var wrap = document.querySelector('.hdWraper'); if(wrap != null){wrap.style.display = 'none';}";
    return js;
  }

//隐藏打开appicon
  String hideOpenAppJs() {
    var js =
        "var head = document.querySelector('.X_icon_5982'); if(head != null){head.style.display = 'none';}";
    return js;
  }

  void hideTop() {
    webViewController
        ?.callAsyncJavaScript(functionBody: hideHeaderJs())
        .then((value) => {});
    webViewController
        ?.callAsyncJavaScript(functionBody: hideOpenAppJs())
        .then((value) => {});
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    InAppWebViewController.clearAllCache();
    super.dispose();
  }
}
