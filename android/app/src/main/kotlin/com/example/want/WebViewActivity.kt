package com.example.want

import android.app.Activity
import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.annotation.Nullable
import java.util.*

class WebViewActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)
        val webview = findViewById<WebView>(R.id.webview)
        val extras = intent.extras
        val arguments =extras.getSerializable(pluginParams) as HashMap<String, Any>
        webview.webViewClient = WebViewClient() //添加WebViewClient实例
        webview.loadUrl(arguments["url"] as String) //添加浏览器地址
    }
}