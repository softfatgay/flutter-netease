import 'package:flutter/material.dart';
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
          onWebViewCreated: (controller){
            _controller = controller;
          },
          onPageFinished: (url){
            _controller.evaluateJavascript("document.title").then((value) {
              setState(() {
                _title = value;
              });
            }
            );
          },
        ),
      ),
    );
  }
}
