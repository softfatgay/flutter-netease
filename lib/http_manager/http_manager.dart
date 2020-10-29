import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/http_manager/response_data.dart';

import '../utils/toast.dart';

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
  }) async {
    // get native data
    Map<String, dynamic> postHeader = (headers == null) ? Map() : headers;

    postHeader['Content-Type'] = 'application/x-www-form-urlencoded';

    Map<String, dynamic> header = (headers == null) ? Map() : headers;
    Dio dio = Dio();

    Options options = Options(
      method: method == "GET" ? "GET" : "POST",
      headers: method == "GET" ? header : postHeader,
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
        // if (response.data['status'] == null || (response.data['status'] != 0 && _needToastMessage)) {
        //   ///错误提醒
        //
        // }
        print(response.data);
        if (_needApiFeedBack) {
          // TODO: 可在此添加错误收集接口
        }
        return ResponseData.convertData(response);
      });
    } else {
      Future<ResponseData> future = Future.value(ResponseData());
      return future;
    }
  }

  static Future<ResponseData> post(
    path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
  }) {
    return HttpManager.request(path,
        queryParameters: queryParameters, method: 'POST', headers: headers);
  }

  static Future<ResponseData> get(
    path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
  }) {
    return HttpManager.request(path,
        queryParameters: queryParameters, method: 'GET', headers: headers);
  }
}