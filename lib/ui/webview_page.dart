import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  final Map? params;

  const WebViewPage(this.params);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final _globalCookie = GlobalCookie();
  String? _url = '';
  bool _hide = true;
  String? _title = '';

  InAppWebViewController? _webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: true,
  );

  _buildBody() {
    return Container(
        height: MediaQuery.of(context).size.height - 45,
        child: InAppWebView(
            initialUrlRequest: URLRequest(
                url: WebUri(_url ?? ''), headers: {'Cookie': cookie}),
            initialSettings: settings,
            onWebViewCreated: (controller) {
              this._webViewController = controller;
              CookieManager.instance().setCookie(
                  url: WebUri(_url ?? NetConstants.baseURL),
                  name: "document.cookie =",
                  value: CookieConfig.cookie);
            },
            onLoadStart: (controller, url) {
              hideTop();
            },
            onLoadStop: (controller, url) async {
              print('---------pageStart');
              print(url?.uriValue.toString());
              hideTop();
              String? aa = await controller.getTitle();
              setState(() {
                _title = aa;
              });
              final updateCookie =
                  await _globalCookie.globalCookieValue(url?.path ?? '');
              if (updateCookie.isEmpty &&
                  updateCookie.length > 0 &&
                  updateCookie.contains('yx_csrf')) {
                setState(() {
                  CookieConfig.cookie = updateCookie;
                });
              }
            },
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              return ServerTrustAuthResponse(
                  action: ServerTrustAuthResponseAction.PROCEED);
            },
            shouldOverrideUrlLoading: (controller, navigation) async {
              print("------------11111111");
              var path = navigation.request.url?.path ?? '';
              print(path);
              if (path == '/item/detail') {
                print("------------222222222");
                var params = navigation.request.url?.queryParameters;
                var id = params!['id'];
                if (id != null && id.isNotEmpty) {
                  Routers.push(Routers.goodDetail, context, {'id': '$id'});
                }
                return NavigationActionPolicy.CANCEL;
              } else if (path == '/cart') {
                Routers.push(Routers.shoppingCart, context,
                    {'from': Routers.goodDetail});
                return NavigationActionPolicy.CANCEL;
              }
              return NavigationActionPolicy.ALLOW;
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _url = widget.params!['url'];
      print('url=$_url');
      print("-----------------------------");
      print('$_url');
    });
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
    if (await _webViewController!.canGoBack()) {
      await _webViewController!.goBack();
    } else {
      Navigator.pop(context);
    }
  }

  //隐藏一些头部信息，底部信息，隐藏打开appicon
  String hideGoCart() {
    var js =
        "var hdWraper = document.querySelector('.hdWraper'); if(hdWraper) { hdWraper.style.display = 'none' };"
        "var tabBar = document.querySelector('.tabBar-wrap'); if(tabBar) { tabBar.style.display = 'none' };"
        "var component = document.querySelector('.lazy-component-wrapper'); if(component) { component.style.display = 'none' };"
        "var mTopBar = document.querySelector('.m-topBar'); if(mTopBar) { mTopBar.style.display = 'none' };"
        "var hdWrap = document.querySelector('.m-hdWrap'); if(hdWrap) { hdWrap.style.display = 'none' };"
        "var mHd = document.querySelector('.m-hd'); if(mHd) { mHd.style.display = 'none' };"
        "var navbarU = document.querySelector('.index-module__navbar___2tl9U'); if(navbarU) { navbarU.style.display = 'none' };"
        "var bd = document.querySelector('.bd'); if(bd) { bd.style.display = 'none' };"
        "var YXM = document.querySelector('.YX_M_507221'); if(YXM) { YXM.style.display = 'none' };"
        "var pscTopbar = document.querySelector('.psc-m-topbar'); if(pscTopbar) { pscTopbar.style.display = 'none' };"
        "var XIcon = document.querySelector('.X_icon_5982'); if(XIcon) { XIcon.style.display = 'none' };";
    return js;
  }

  void hideTop() {
    _webViewController
        ?.callAsyncJavaScript(functionBody: hideGoCart())
        .then((value) => {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    InAppWebViewController.clearAllCache();
    super.dispose();
  }
}
