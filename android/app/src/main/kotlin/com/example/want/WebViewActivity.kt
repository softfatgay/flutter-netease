package com.example.want

import android.app.Activity
import android.os.Bundle
import android.webkit.WebChromeClient
import android.webkit.WebView
import com.example.untitled.R
import java.util.HashMap

class WebViewActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.webview)
        val webView = findViewById<WebView>(R.id.webView)
        val intent = intent
        val map = intent.getSerializableExtra(pluginParams)

        var hashMap = HashMap<String, String>()
        if (map != null) {
            @Suppress("UNCHECKED_CAST")
            hashMap = map as HashMap<String, String>
        }
        val webViewClient = WebChromeClient()
        webView.webChromeClient = webViewClient
        webView.loadUrl(hashMap["url"].toString())
    }
}