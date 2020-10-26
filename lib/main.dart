import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/index.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.transparent),
      title: 'Flutter Demo',
      onGenerateRoute: (RouteSettings settings) {
        return Routers.run(settings);
      },

      //国际化-----------------------------------------------
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
      //国际化-----------------------------------------------

      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: PageStart(),
      ),
    );
  }
}
