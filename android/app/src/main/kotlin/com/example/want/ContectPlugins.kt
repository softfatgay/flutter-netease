package com.example.want

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.webkit.CookieManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

object ContectPlugins {
    fun initContectPlugins(flutterEngine: FlutterEngine, mainActivity: MainActivity) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, pluginKey).setMethodCallHandler(
                MethodChannel.MethodCallHandler { call, result ->
                    run {
                        when (call.method) {
                            pluginParams -> {
                                Log.e("=============","aaaaaaaaaaaaa")
                                if (call.hasArgument("url")) {
                                    //跳转到指定Activity
                                    val intent = Intent(mainActivity, WebViewActivity::class.java)
                                    val arguments = call.arguments as HashMap<*, *>
                                    val bundle = Bundle()
                                    bundle.putSerializable(pluginParams, arguments)
                                    intent.putExtras(bundle)
                                    mainActivity.startActivity(intent)
                                    //返回给flutter的参数
                                    result.success("success")
                                }
                            }
                            "globalCookieValue" -> {
                                Log.e("=============","bbbbbbbbbbbbb")
                                val arguments = call.arguments as HashMap<*, *>
                                val url = arguments["url"] as String
                                val cookieManager = CookieManager.getInstance()
                                val cookieStr = cookieManager.getCookie(url)
                                Log.e("CookieStr", cookieStr)

                                result.success(cookieStr)
                            }
                            else -> result.success("")
                        }
                        Log.e("=============", "ccccccccccccccc")
                    }
                }
        )
    }
}