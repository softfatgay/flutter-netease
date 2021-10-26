import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/eventbus_constans.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final Map? params;

  const WebViewPage(this.params);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final _webController = Completer<WebViewController>();
  final globalCookie = GlobalCookie();

  String? _url = '';
  bool hide = true;

  var _isLoading = true;

  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _url = widget.params!['url'];
      print('url=$_url');
    });
  }

  String? _title = '';

  void setCookie() async {
    if (!CookieConfig.isLogin) return;

    List<Cookie> cookies = [];

    for (var key in CookieConfig.cookieMap.keys) {
      var cookie = Cookie(key, CookieConfig.cookieMap[key]!);
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
                _url!,
                headers: {"Cookie": cookie},
              );
              _webController.complete(controller);
            },
            onPageStarted: (url) async {
              setCookie();
              hideTop();
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (url) async {
              setCookie();
              hideTop();
              String? aa =
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
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
        ],
      ),
    );
  }

  NavigationDecision _interceptUrl(String url) {
    if (url.startsWith('${NetConstants.baseUrl}item/detail')) {
      var split = url.split('id=');
      var split2 = split[1];
      var split3 = split2.split('&')[0];
      if (split3 != null && split3.isNotEmpty) {
        Routers.push(Routers.goodDetail, context, {'id': '$split3'});
      }
      return NavigationDecision.prevent;
    } else if (url.startsWith('${NetConstants.baseUrl}cart')) {
      Routers.push(Routers.shoppingCart, context, {'from': Routers.goodDetail});
      return NavigationDecision.prevent;
    } else if (url == NetConstants.baseUrl) {
      Navigator.of(context).popUntil(ModalRoute.withName(Routers.mainPage));
      HosEventBusUtils.fire(GO_HOME);
      return NavigationDecision.prevent;
    } else {
      return NavigationDecision.navigate;
    }
  }

  //隐藏一些头部信息，底部信息，隐藏打开appicon
  String hideGoCart() {
    var js =
        "var tabBar = document.querySelector('.tabBar-wrap'); if(tabBar) { tabBar.style.display = 'none' };"
        "var component = document.querySelector('.lazy-component-wrapper'); if(component) { component.style.display = 'none' };"
        "var mTopBar = document.querySelector('.m-topBar'); if(mTopBar) { mTopBar.style.display = 'none' };"
        "var hdWrap = document.querySelector('.m-hdWrap'); if(hdWrap) { hdWrap.style.display = 'none' };"
        "var mHd = document.querySelector('.m-hd'); if(mHd) { mHd.style.display = 'none' };"
        "var navbarU = document.querySelector('.index-module__navbar___2tl9U'); if(navbarU) { navbarU.style.display = 'none' };"
        "var bd = document.querySelector('.bd'); if(bd) { bd.style.display = 'none' };"
        "var YXM = document.querySelector('.YX_M_507221'); if(YXM) { YXM.style.display = 'none' };"
        "var pscTopbar = document.querySelector('.psc-m-topbar'); if(pscTopbar) { pscTopbar.style.display = 'none' };"
        "var hdWraper = document.querySelector('.hdWraper'); if(hdWraper) { hdWraper.style.display = 'none' };"
        "var XIcon = document.querySelector('.X_icon_5982'); if(XIcon) { XIcon.style.display = 'none' };";
    return js;
  }

  void hideTop() {
    _timer = Timer(Duration(milliseconds: 10), () {
      try {
        _webController.future.then((value) async {
          await value.evaluateJavascript(hideGoCart());
        });
      } catch (e) {
        _timerCancel();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timerCancel();
    super.dispose();
  }

  _timerCancel() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}
