package com.example.want;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;

import java.io.Serializable;
import java.util.HashMap;

import static com.example.want.ConstsKt.pluginParams;

public class WebViewActivity extends Activity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.webview);
        WebView webView = findViewById(R.id.webView);
        Intent intent = getIntent();
        HashMap<String, String> map = (HashMap<String, String>) intent.getSerializableExtra(ConstsKt.pluginParams);
        WebChromeClient webViewClient = new WebChromeClient();
        webView.setWebChromeClient(webViewClient);
        webView.loadUrl(map.get("url"));
    }
}
