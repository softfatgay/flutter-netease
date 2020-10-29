import 'package:flutter/material.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final Map arguments;

  const WebViewPage(this.arguments);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;

  String _title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        tabs: [],
        title: _title,
      ).build(context),
      body: Container(
        child: WebView(
          initialUrl: widget.arguments['id'],
          //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onPageFinished: (url) {
            String cookie = '''
          document.cookie = 'yx_csrf=61f57b79a343933be0cb10aa37a51cc8';
          document.cookie = 'NTES_YD_SESS=CeSW42ks.2zHbRG87vm8zIICA6Iz26O2Tk1c.zRjbbU2JYRBJ0rMWQAa3mSPwzgyNUot7ky9t19g_sPefQ.FztFjefQgJZxUEtxTFQlvuxOtF9_xQk2bxRZJVe0syMAcjCrBL3xGbWLKBqtQrgTgVMSmCYedIbiww8fzdwKYU7RYDRwhNU2VYckSVJKddnEhim1Fd49owd8sWYhvaGCh18EjA17quaiQQEomqoyqIergf';
          document.cookie = 'P_INFO=17621577088|1603968997|1|yanxuan_web';
        ''';
            _controller.evaluateJavascript(cookie);
            _controller.evaluateJavascript("document.title").then((value) {
              setState(() {
                _title = value;
              });
            });
          },
        ),
      ),
    );
  }
}
