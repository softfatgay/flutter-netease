package com.example.want

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.webkit.CookieManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.net.URL
import java.util.*

object ConnectPlugins {

    fun initConnectPlugins(flutterEngine: FlutterEngine, mainActivity: MainActivity) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            pluginKey
        ).setMethodCallHandler { call, result ->
            run {
                when (call.method) {
                    pluginParams -> {
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
                        Log.e("----------", "getGlobalCookieValue")
                        val arguments = call.arguments as HashMap<*, *>
                        val url = arguments["url"] as String
                        val mUrl = URL(url)
                        val cookieManager = CookieManager.getInstance()
                        val cookieStr = cookieManager.getCookie(mUrl.host)
                        Log.e("CookieStr", cookieStr + "")
                        result.success(cookieStr)
                    }

                    "clearCookie" -> {
                        Log.e("----------", "clearGlobalCookieValue")
                        val arguments = call.arguments as HashMap<*, *>
                        val url = arguments["url"] as String
                        val mUrl = URL(url)

                        val mCookieManager = CookieManager.getInstance()
                        mCookieManager.removeAllCookies(null)
                        CookieManager.getInstance().flush()
                        mCookieManager.setAcceptCookie(true)
                        mCookieManager.setCookie(mUrl.host, "")
                        result.success(true)
                    }
                    else -> result.success("")
                }
            }
        }
    }
}