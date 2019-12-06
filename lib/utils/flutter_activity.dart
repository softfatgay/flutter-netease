import 'package:flutter/services.dart';
import 'package:flutter_app/utils/util_mine.dart';

class Flutter2Activity {
  static const String plugin = Util.flutter2activity;
  static var demoPlugin = const MethodChannel(plugin);
  static const String webView = 'webView';

  static toActivity(String tag,{dynamic arguments}){
    switch(tag){
      case webView:
        demoPlugin.invokeMethod(Util.webView,arguments);
        break;
    }
  }
}
