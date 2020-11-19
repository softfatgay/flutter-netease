import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:webview_flutter/webview_flutter.dart' as prefix0;
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  WebViewController webViewController;
  var _lastPressedAt;
  bool isLoading = true;
  var progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Material(
          child: Stack(
            children: <Widget>[
              prefix0.WebView(
                initialUrl: 'https://flutterchina.club/widgets-intro/',
                onWebViewCreated: (WebViewController webViewController) {
                  setState(() {
                    this.webViewController = webViewController;
                  });
                },
                onPageFinished: (url) {
                  LogUtil.e(url);
                  setState(() {
                    isLoading = false;
                  });
                },
                javascriptMode: JavascriptMode.unrestricted, // 是否允许js执行
              ),
              isLoading ? Loading() : Container(),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        webViewController.canGoBack().then((value) {
          if (value) {
            webViewController.goBack();
            return false;
          } else {
            if (_lastPressedAt == null) {
              //首次点击提示...信息
            }
            if (_lastPressedAt == null ||
                DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
              _lastPressedAt = DateTime.now();
              return false;
            }
            return true;
          }
        });
        return false;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
