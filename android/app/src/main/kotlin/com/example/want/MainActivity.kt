package com.example.want

import android.os.Bundle
import android.os.Build
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
//    if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.LOLLIPOP) {//API>21,设置状态栏颜色透明
//      window.statusBarColor = 0
//    }
    GeneratedPluginRegistrant.registerWith(this)
    registerCustomPlusgin(this)
  }

  private fun registerCustomPlusgin(registrar: PluginRegistry) {
    FlutterPluginJumpToActivity.registerWith(registrar.registrarFor(FlutterPluginJumpToActivity.CHANNEL))
    FlutterPluginCounter.registerWith(registrar.registrarFor(FlutterPluginCounter.CHANNEL))
  }
}
