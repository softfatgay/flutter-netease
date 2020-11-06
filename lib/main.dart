import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/index.dart';
import 'package:flutter_app/ui/main/main_page.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
