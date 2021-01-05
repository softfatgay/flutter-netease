import 'dart:async';
import 'package:flutter/services.dart';

class GlobalCookie {
  static const _channel =
      MethodChannel('plugins.want.flutter.io.GloableCookie');

  factory GlobalCookie() {
    return _instance ??= GlobalCookie._();
  }

  GlobalCookie._();

  static GlobalCookie _instance;

  /// Get globalCookieValue
  Future<String> globalCookieValue(String url) {
   return  _channel
       .invokeMethod<String>('globalCookieValue', {'url': url})
       .then<String>((String result) {
           return result;
        });
  }
}
