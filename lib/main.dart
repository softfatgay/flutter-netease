import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/statusbar_style.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/http_manager/api_service.dart';
import 'package:flutter_app/ui/home/home_page.dart';
import 'package:flutter_app/ui/main/index.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'channel/globalCookie.dart';
import 'config/cookieConfig.dart';

void main() async {
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
    csrf_token;
    return MaterialApp(
      builder: BotToastInit(),
      theme: ThemeData(
        platform: TargetPlatform.iOS, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(background: backColor),
      ),
      title: '仿网易严选-Flutter',
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

      routes: {
        Routers.mainPage: (context) => MainPage(),
        Routers.homePage: (context) => HomePage(),
      },
      initialRoute: Routers.mainPage,
      // onGenerateInitialRoutes: (name) {
      //   return [
      //     MaterialPageRoute(builder: (context) {
      //       return MainPage();
      //     })
      //   ];
      // },
      // home: MainPage(),
    );
  }
}
