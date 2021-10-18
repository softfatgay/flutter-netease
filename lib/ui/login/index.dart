import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/ui/component/webview_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '登录',
      ).build(context),
      body: WebLoginWidget(
        onValueChanged: (value) {
          if (value) {
            setState(() {
              Navigator.pop(context, 'success');
            });
          }
        },
      ),
    );
  }
}
