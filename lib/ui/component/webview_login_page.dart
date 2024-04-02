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

// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

typedef void OnValueChanged(bool result);

const _tips = '部分手机登录页面，邮箱登录密码弹出软键盘导致页面空白，没有找到解决办法，正常输入就可以，收回键盘页面会正常显示';

class WebLoginWidget extends StatefulWidget {
  final OnValueChanged? onValueChanged;

  const WebLoginWidget({Key? key, this.onValueChanged}) : super(key: key);

  @override
  _WebLoginWidgetState createState() => _WebLoginWidgetState();
}

class _WebLoginWidgetState extends State<WebLoginWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final globalCookie = GlobalCookie();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            hideTop();
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');
            hideTop();
            final updateCookie = await globalCookie.globalCookieValue(url);
            print('更新Cookie-------------->${updateCookie.toString()}');
            print(updateCookie.toString());
            if (updateCookie.isNotEmpty) {
              CookieConfig.cookie = updateCookie;
              _checkLogin();
            }

          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {},
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(
        Uri.parse(LOGIN_PAGE_URL),
        headers: {'Cookie': cookie},
      );

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }











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
    if (await _controller.canGoBack()) {
      _controller.canGoForward();
    } else {
      Navigator.pop(context);
    }
  }

  _buildBody() {
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
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }

  ///检查是否登录
  _checkLogin() async {
    Map<String, dynamic> postParams = {
      'csrf_token': CookieConfig.token,
      '__timestamp': '${DateTime.now().millisecondsSinceEpoch}',
    };
    var responseData = await checkLoginP(postParams);
    var isLogin = responseData.data;
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
    Timer(Duration(milliseconds: 10), () {
      try {
        _controller.platform.runJavaScript(hideHeaderJs()).then((result) {});
        _controller.platform.runJavaScript(hideOpenAppJs()).then((result) {});
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    _controller.clearCache();
    super.dispose();
  }
}
