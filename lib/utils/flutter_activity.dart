import 'package:flutter/services.dart';
import 'package:flutter_app/utils/util_mine.dart';

class Flutter2Activity {
  static var demoPlugin = const MethodChannel(Util.flutter2activity);
  static const String webView = 'webView';

  static toActivity(String tag, {dynamic arguments}) async {
    switch (tag) {
      case webView:
        demoPlugin.invokeMethod(Util.flutter2activityParams, arguments);
        break;
    }
  }
}
