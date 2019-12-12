package com.example.want;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class FlutterPluginJumpToActivity implements MethodChannel.MethodCallHandler {

    public static String CHANNEL = Const.flutterJumpActivity;

    static MethodChannel channel;

    private Activity activity;

    private FlutterPluginJumpToActivity(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        FlutterPluginJumpToActivity instance = new FlutterPluginJumpToActivity(registrar.activity());
        //setMethodCallHandler在此通道上接收方法调用的回调
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        //通过MethodCall可以获取参数和方法名，然后再寻找对应的平台业务，本案例做了2个跳转的业务
        //接收来自flutter的指令oneAct
        if (call.method.equals(Const.webView)) {
            //跳转到指定Activity
            Intent intent = new Intent(activity, WebViewActivity.class);
            HashMap<String,String> arguments = (HashMap<String, String>) call.arguments;
            Bundle bundle = new Bundle();
            bundle.putSerializable("arguments", arguments);
            intent.putExtras(bundle);
            activity.startActivity(intent);

            //返回给flutter的参数
            result.success("success");
        } else {
            result.notImplemented();
        }
    }

}