package com.example.want

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        registerCustomPlusgin(this)
    }
    private fun registerCustomPlusgin(registrar: PluginRegistry) {
        FlutterPluginJumpToActivity.registerWith(registrar.registrarFor(FlutterPluginJumpToActivity.CHANNEL))
        FlutterPluginCounter.registerWith(registrar.registrarFor(FlutterPluginCounter.CHANNEL))
    }
}
