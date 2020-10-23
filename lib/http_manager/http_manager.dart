import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/http_manager/response_data.dart';

import '../utils/toast.dart';

class HttpManager {
  static bool _needApiFeedBack = false;
  static String newBaseUrl = "https://m.you.163.com/xhr/index.json";

  static Future<ResponseData> request(
    //TODO GET和POST添加静态
    String path, {
    String method = 'GET',
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    int sendTimeout,
    int receiveTimeout,
  }) async {
    // get native data
    headers = (headers == null) ? Map() : headers;
    print("////////////////////");
    print(headers);
    queryParameters = (queryParameters == null) ? Map() : queryParameters;

    Dio dio = Dio();
    Options options = Options(
      method: method,
      headers: headers,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
    );

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
        if (_needApiFeedBack) {
          // TODO: 可在此添加错误收集接口
        }
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        print(response.data);
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
    int sendTimeout, // 毫秒
    int receiveTimeout, // 毫秒
  }) {
    return HttpManager.request(
      path,
      queryParameters: queryParameters,
      method: 'POST',
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
    );
  }

  static Future<ResponseData> get(
    path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    int sendTimeout, // 毫秒
    int receiveTimeout, // 毫秒
  }) {
    return HttpManager.request(
      path,
      queryParameters: queryParameters,
      method: 'GET',
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
    );
  }

}
