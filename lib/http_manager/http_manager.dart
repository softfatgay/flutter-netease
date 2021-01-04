import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/response_data.dart';
import 'package:flutter_app/main/mainContex.dart';

import '../ui/webview_page.dart';

class HttpManager {
  static bool _needApiFeedBack = false;
  static String newBaseUrl = "https://m.you.163.com/xhr/index.json";
  static int sendTimeout = 30000;
  static int receiveTimeout = 30000;

  static Future<ResponseData> request(
    //TODO GET和POST添加静态
    String path, {
    String method = 'GET',
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    String accept,
  }) async {
    // get native data
    Map<String, dynamic> postHeader = (headers == null) ? Map() : headers;

    if (accept != null) {
      postHeader['Accept'] = 'application/json, text/javascript, */*; q=0.01';
      postHeader['Content-Type'] = 'application/json';
    } else {
      postHeader['Content-Type'] =
          'application/x-www-form-urlencoded; charset=UTF-8';
    }

    try {
      Map<String, dynamic> header = (headers == null) ? Map() : headers;
      Dio dio = Dio();

      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        return options;
      }, onResponse: (Response response) {
        return response.data;
      }, onError: (DioError error) {
        print(error);
        return Future;
      }));
      // 开启日志
      dio.interceptors.add(LogInterceptor(responseBody: false));

      Options options = Options(
        method: method == "GET" ? "GET" : "POST",
        headers: method == "GET" ? header : postHeader,
        contentType: Headers.formUrlEncodedContentType,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
      );
      options.headers = header;

      Future<Response> response = dio.request(
        path,
        data: method == 'POST' ? queryParameters : {},
        options: options,
        queryParameters: method == 'GET' ? queryParameters : {},
      );
      if (response != null) {
        return response.then((Response response) {
          print(">>>>>>>>>>>>>>>>>>>111111");
          print(response.data);
          if (response.data == '{"code":"403"}' ||
              response.data == '{"code":"401"}') {
            // 拦截到Token失效
            print('拦截到Token失效');
            Navigator.push(mainContext, MaterialPageRoute(builder: (context) {
              return WebViewPage(
                  {'id': 'https://m.you.163.com/login', "type": -1});
            }));
            return ResponseData.convertData(response);
          }
          if (_needApiFeedBack) {
            // TODO: 可在此添加错误收集接口
          }
          print(response.data);
          return ResponseData.convertData(response);
        });
      } else {
        Future<ResponseData> future = Future.value(ResponseData());
        return future;
      }
    } catch (e) {}
  }

  static Future<ResponseData> post(
    path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    String accept,
  }) {
    return HttpManager.request(path,
        queryParameters: queryParameters,
        method: 'POST',
        headers: headers,
        accept: accept);
  }

  static Future<ResponseData> get(
    path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    String accept,
  }) {
    return HttpManager.request(path,
        queryParameters: queryParameters,
        method: 'GET',
        headers: headers,
        accept: accept);
  }
}
