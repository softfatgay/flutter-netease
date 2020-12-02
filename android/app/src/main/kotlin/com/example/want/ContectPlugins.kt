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
                        if (call.method.contentEquals(pluginParams)) {
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
                        } else if (call.method.contentEquals("globalCookieValue")) {
                            val intent = Intent(mainActivity, WebViewActivity::class.java)
                            val arguments = call.arguments as HashMap<*, *>
                            val bundle = Bundle()
                            bundle.putSerializable(pluginParams, arguments)
                            intent.putExtras(bundle)
                            mainActivity.startActivity(intent)
                            //返回给flutter的参数
                            result.success("success")
                            
                            Log.e("==============","=============")
//
//                            val arguments = call.arguments as HashMap<*, *>
//                            val url = arguments["url"] as String
//
//                            val cookieManager = CookieManager.getInstance()
//                            val CookieStr = cookieManager.getCookie(url)
//                            Log.e("CookieStr", CookieStr)
//
//                            result.success("CookieStr")
                        }
                    }
                }
        )
    }
}