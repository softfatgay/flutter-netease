import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/tab_app_bar.dart';

// import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final Map params;

  const WebViewPage(this.params);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final _webController = Completer<WebViewController>();
  // final cookieManager = WebviewCookieManager();
  final globalCookie = GlobalCookie();

  String _url = '';
  bool hide = true;

  var _isLoading = true;

  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _url = widget.params['url'];
      print('url=$_url');
    });
  }

  var _title = '';

  void setcookie() async {
    if (!CookieConfig.isLogin) return;

    List<Cookie> cookies = [];

    for (var key in CookieConfig.cookieMap.keys) {
      var cookie = Cookie(key, CookieConfig.cookieMap[key]);
      cookies.add(cookie);
    }
    // await cookieManager.setCookies(cookies);

    String cookie = '';
    for (var item in cookies) {
      cookie += 'document.cookie = ' + "'${item.name}=" + "${item.value}';";
    }
    _webController.future.then((value) {
      value.evaluateJavascript(cookie).then((result) {});
    });

    // await cookieManager.setCookies([
    //   Cookie("NTES_YD_SESS", CookieConfig.NTES_YD_SESS)
    //     ..domain = '.163.com'
    //     ..path = '/'
    //     ..httpOnly = true,
    //   Cookie("P_INFO", CookieConfig.P_INFO)
    //     ..domain = '.163.com'
    //     ..path = '/'
    //     ..httpOnly = false,
    //   Cookie("yx_csrf", CookieConfig.token)
    //     ..domain = '.163.com'
    //     ..path = '/'
    //     ..httpOnly = false,
    //   Cookie("yx_app_type", 'android')
    //     ..domain = '.163.com'
    //     ..path = '/'
    //     ..httpOnly = false,
    //   Cookie("yx_app_chann", 'aos_market_oppo')
    //     ..domain = '.163.com'
    //     ..path = '/'
    //     ..httpOnly = false,
    //   Cookie("yx_from", '')
    //     ..domain = '.163.com'
    //     ..path = '/'
    //     ..httpOnly = false,
    //   Cookie("YX_SUPPORT_WEBP", '')
    //     ..domain = '.163.com'
    //     ..path = '/'
    //     ..httpOnly = false,
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backPress(context);
        return false;
      },
      child: Scaffold(
        appBar: TopAppBar(
          title: _title,
          closeIcon: true,
          backPress: () {
            _backPress(context);
          },
        ).build(context),
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
    return Container(
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
              _webController.complete(controller);
            },
            onPageStarted: (url) async {
              setcookie();
              hideTop();
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (url) async {
              setcookie();
              hideTop();
              String aa =
                  await _webController.future.then((value) => value.getTitle());
              setState(() {
                _title = aa;
                _isLoading = false;
              });
              final updateCookie = await globalCookie.globalCookieValue(url);
              if (updateCookie.length > 0 && updateCookie.contains('yx_csrf')) {
                setState(() {
                  CookieConfig.cookie = updateCookie;
                });
              }
            },
            navigationDelegate: (NavigationRequest request) {
              var url = request.url;
              return _interceptUrl(url);
            },
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  NavigationDecision _interceptUrl(String url) {
    if (url.startsWith('${NetContants.baseUrl}item/detail')) {
      var split = url.split('id=');
      var split2 = split[1];
      var split3 = split2.split('&')[0];
      if (split3 != null && split3.isNotEmpty) {
        Routers.push(Routers.goodDetail, context, {'id': '$split3'});
      }
      return NavigationDecision.prevent;
    } else if (url.startsWith('${NetContants.baseUrl}cart')) {
      Routers.push(Routers.shoppingCart, context, {'from': Routers.goodDetail});
      return NavigationDecision.prevent;
    } else {
      return NavigationDecision.navigate;
    }
  }

  //隐藏头部
  String hideBottom1() {
    var js = "document.querySelector('.tabBar-wrap').style.display = 'none';";
    return js;
  }

  //隐藏头部
  String hideBottom2() {
    var js =
        "document.querySelector('.lazy-component-wrapper').style.display = 'none';";
    if (js == 'null') {
      return '';
    }
    return js;
  }

  //隐藏头部
  String hideHeaderJs1() {
    var js = "document.querySelector('.m-topBar').style.display = 'none';";
    if (js == 'null') {
      return '';
    }
    return js;
  }

  //隐藏头部
  String hideHeaderJs2() {
    var js = "document.querySelector('.m-hd').style.display = 'none';";
    if (js == 'null') {
      return '';
    }
    return js;
  }

  //隐藏头部
  String hideHeaderJs3() {
    var js = "document.querySelector('.YX_M_507221').style.display = 'none';";
    if (js == 'null') {
      return '';
    }
    return js;
  }

  //隐藏头部
  String hideHeaderJs4() {
    var js = "document.querySelector('.psc-m-topbar').style.display = 'none';";
    if (js == 'null') {
      return '';
    }
    return js;
  }

  //隐藏头部
  String hideHeaderJs() {
    var js = "document.querySelector('.hdWraper').style.display = 'none';";
    if (js == 'null') {
      return '';
    }
    return js;
  }

  //隐藏打开appicon
  String hideOpenAppJs() {
    var js = "document.querySelector('.X_icon_5982').style.display = 'none';";
    if (js == 'null') {
      return '';
    }
    return js;
  }

  void hideTop() {
    _timer = Timer(Duration(milliseconds: 10), () {
      try {
        if (_webController != null) {
          _webController.future.then((value) async {
            await value.evaluateJavascript(hideHeaderJs() ?? '');
          });
          _webController.future.then((value) async {
            await value.evaluateJavascript(hideHeaderJs1() ?? '');
          });
          _webController.future.then((value) async {
            await value.evaluateJavascript(hideHeaderJs2() ?? '');
          });
          _webController.future.then((value) async {
            await value.evaluateJavascript(hideHeaderJs3() ?? '');
          });
          _webController.future.then((value) async {
            await value.evaluateJavascript(hideHeaderJs4() ?? '');
          });
          _webController.future.then((value) async {
            await value.evaluateJavascript(hideOpenAppJs() ?? '');
          });
          _webController.future.then((value) async {
            await value.evaluateJavascript(hideHeaderJs() ?? '');
          });
          _webController.future.then((value) async {
            await value.evaluateJavascript(hideBottom1() ?? '');
          });
          _webController.future.then((value) async {
            await value.evaluateJavascript(hideBottom2() ?? '');
          });
        }
      } catch (e) {
        _timerCancel();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _webController.future.then((value) {
    //   value.clearCache();
    // });
    _timerCancel();
    super.dispose();
  }

  _timerCancel() {
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
