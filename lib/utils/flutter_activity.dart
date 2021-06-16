import 'package:flutter/services.dart';
import 'package:flutter_app/utils/constans.dart';

class Flutter2Activity {
  static var demoPlugin = const MethodChannel(flutter2activity);
  static const String webView = 'webView';

  static toActivity(String tag, {dynamic arguments}) async {
    switch (tag) {
      case webView:
        demoPlugin.invokeMethod(flutter2activityParams, arguments);
        break;
    }
  }
}
