import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/channel/globalCookie.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef void OnValueChanged(bool result);

// class WebLoginWidget extends StatefulWidget {
//   final OnValueChanged onValueChanged;
//
//   const WebLoginWidget({Key key, this.onValueChanged}) : super(key: key);
//
//   @override
//   _WebLoginState createState() => _WebLoginState();
// }
//
// class _WebLoginState extends State<WebLoginWidget> {
//
//   final Completer<WebViewController> _webController =
//   Completer<WebViewController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         _loginPage(context),
//         Container(
//           height: ScreenUtil().setHeight(50),
//           color: Color(0xFFF2F5F4),
//         )
//       ],
//     );
//   }
//
//   _loginPage(BuildContext context) {
//     final globalCookie = GlobalCookie();
//     Widget webLogin = WebView(
//       //JS执行模式 是否允许JS执行
//       initialUrl: LOGIN_PAGE_URL,
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebViewCreated: (controller) async {
//         _webController.complete(controller);
//       },
//       onPageStarted: (url) async {
//         hideTop();
//       },
//       onPageFinished: (url) async {
//         hideTop();
//         final updateCookie = await globalCookie.globalCookieValue(url);
//         print('更新Cookie-------------->');
//         print(updateCookie.toString());
//         if (updateCookie.length > 0) {
//           CookieConfig.cookie = updateCookie;
//           _checkLogin();
//         }
//       },
//     );
//     return Container(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//       color: Colors.white,
//       child: webLogin,
//     );
//   }
//
//
//
//   ///检查是否登录
//   _checkLogin() async {
//     var responseData = await checkLogin();
//     var isLogin = responseData.data;
//     setState(() {
//       if (isLogin) {
//         widget.onValueChanged(isLogin);
//       }
//     });
//   }
//
//   //隐藏头部
//   String setHeaderJs() {
//     var js = "document.querySelector('.hdWraper').style.display = 'none';";
//     return js;
//   }
//
//   //隐藏头部
//   String hideHeaderJs() {
//     var js = "document.querySelector('.hdWraper').style.display = 'none';";
//     return js;
//   }
//
//   //隐藏打开appicon
//   String hideOpenAppJs() {
//     var js = "document.querySelector('.X_icon_5982').style.display = 'none';";
//     return js;
//   }
//
//   void hideTop() {
//     Timer(Duration(milliseconds: 10), () {
//       try {
//         if (_webController != null) {
//           _webController.future.then((value) => value.evaluateJavascript(hideHeaderJs()).then((result) {}));
//         }
//       } catch (e) {}
//     });
//
//     Timer(Duration(milliseconds: 100), () {
//       try {
//         if (_webController != null) {
//           _webController.future.then((value) => value.evaluateJavascript(setHeaderJs()).then((result) {}));
//         }
//       } catch (e) {}
//     });
//
//     Timer(Duration(milliseconds: 100), () {
//       try {
//         if (_webController != null) {
//           _webController.future.then((value) => value.evaluateJavascript(hideOpenAppJs()).then((result) {}));
//         }
//       } catch (e) {}
//     });
//   }
//
// }
//

class WebLoginWidget extends StatefulWidget {
  final OnValueChanged onValueChanged;

  const WebLoginWidget({Key key, this.onValueChanged}) : super(key: key);

  @override
  _WebLoginWidgetState createState() => _WebLoginWidgetState();
}

class _WebLoginWidgetState extends State<WebLoginWidget> {
  final Completer<WebViewController> _webController =
      Completer<WebViewController>();

  String _url = '';
  bool hide = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var _title = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(

        resizeToAvoidBottomInset: false,
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    final globalCookie = GlobalCookie();
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: WebView(
          initialUrl: LOGIN_PAGE_URL,
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
  String setHeaderJs() {
    var js = "document.querySelector('.hdWraper').style.display = 'none';";
    return js;
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
          _webController.future.then((value) =>
              value.evaluateJavascript(hideHeaderJs()).then((result) {}));
        }
      } catch (e) {}
    });

    Timer(Duration(milliseconds: 100), () {
      try {
        if (_webController != null) {
          _webController.future.then((value) =>
              value.evaluateJavascript(setHeaderJs()).then((result) {}));
        }
      } catch (e) {}
    });

    Timer(Duration(milliseconds: 100), () {
      try {
        if (_webController != null) {
          _webController.future.then((value) =>
              value.evaluateJavascript(hideOpenAppJs()).then((result) {}));
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
