package com.example.want;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;


import java.util.HashMap;

public class WebViewActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_splash);
        WebView webview = findViewById(R.id.webview);

        Bundle extras = getIntent().getExtras();
        HashMap<String,String> arguments = (HashMap<String, String>) extras.getSerializable("arguments");

        webview.setWebViewClient(new WebViewClient());//添加WebViewClient实例
        webview.loadUrl(arguments.get("url"));//添加浏览器地址
    }
}
