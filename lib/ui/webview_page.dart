import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final Map arguments;

  const WebViewPage(this.arguments);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: widget.arguments['id'],
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
