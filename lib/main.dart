import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constant/statusbar_style.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/ui/main/main_page.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'channel/globalCookie.dart';
import 'config/cookieConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final globalCookie = GlobalCookie();

  @override
  void initState() {
    super.initState();
    _getCookie();
  }

  _getCookie() async {
    CookieConfig.cookie = await globalCookie.globalCookieValue(LOGIN_PAGE_URL);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(statusBarDark);
    return ScreenUtilInit(
      designSize: Size(360, 690),
      allowFontScaling: false,
      child: MaterialApp(
        // flutter build appbundle --target-platform android-arm
        theme: ThemeData(
          backgroundColor: Colors.transparent,
          primarySwatch: Colors.red,
        ),
        title: 'FlutterWant',
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
      ),
    );
  }
}
