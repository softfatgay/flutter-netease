import 'dart:async';
import 'dart:io';
import 'package:flutter_app/channel/index.dart';
import 'package:flutter_app/http_manager/net_contants.dart';

class GlobalCookie {
  factory GlobalCookie() {
    return _instance ??= GlobalCookie._();
  }

  GlobalCookie._();

  static GlobalCookie _instance;

  /// Get globalCookieValue
  Future<String> globalCookieValue(String url) {
    return channel.invokeMethod<String>(
        'globalCookieValue', {'url': url}).then<String>((String result) {
      return result;
    });
  }

  /// Get globalCookieValue
  Future<bool> clearCookie() {
    return channel.invokeMethod<bool>(
        'clearCookie', {'url': NetContants.baseUrl}).then<bool>((bool result) {
      return result;
    });
  }

  /// Get globalCookieValue
  Future<bool> install() {
    return channel.invokeMethod<bool>(
        Platform.isIOS ? 'gotoAppStore' : 'installApk',
        {'url': NetContants.baseUrl}).then<bool>((bool result) {
      return result;
    });
  }
}
