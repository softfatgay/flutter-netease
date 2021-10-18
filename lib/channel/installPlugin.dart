import 'dart:async';

import 'package:flutter_app/channel/index.dart';

class InstallPlugin {
  /// for Android : install apk by its file absolute path;
  /// if the target platform is higher than android 24:
  /// a [appId] is required
  /// (the caller's applicationId which is defined in build.gradle)
  static Future<String?> installApk(String filePath, String appId) async {
    Map<String, String> params = {'filePath': filePath, 'appId': appId};
    return await installPluginChannel.invokeMethod('installApk', params);
  }

  /// for iOS: go to app store by the url
  static Future<String?> gotoAppStore(String urlString) async {
    Map<String, String> params = {'urlString': urlString};
    return await installPluginChannel.invokeMethod('gotoAppStore', params);
  }
}
