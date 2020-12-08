import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/ui/main/main_page.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'channel/globalCookie.dart';
import 'config/cookieConfig.dart';

void main() {
  runApp(MyApp());
  // 导航的颜色为白色  设置状态栏文字黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final globalCookie = GlobalCookie();

  @override
  void initState() {
    super.initState();
    // _getCookie();
  }

  _getCookie() async {
    // CookieConfig.cookie = await globalCookie.globalCookieValue("https://m.you.163.com/");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // flutter build appbundle --target-platform android-arm
      theme: ThemeData(backgroundColor: Colors.transparent,
        primarySwatch: Colors.red,),
      title: 'Flutter Demo',
      onGenerateRoute: (RouteSettings settings) {
        return Routers.run(settings);
      },
      // showPerformanceOverlay: true, // 开启
      //国际化-----------------------------------------------
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      //国际化-----------------------------------------------

      home: MainPage(),
    );
  }
}