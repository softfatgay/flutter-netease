import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/http_manager/response_data.dart';

import '../utils/toast.dart';

class HttpManager {
  static bool _needToastMessage = true;
  static bool _needAuthentication = false;
  static bool _needCommonParameters = true;
  static bool _needCommonHeaders = true;
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
    RequestCancelToken cancelToken,
    bool needToastMessage,
    bool needAuthentication,
    bool needCommonParameters,
    bool needCommonHeaders,
    bool needApiFeedBack,
  }) async {
    // get native data

    cancelToken = (cancelToken == null) ? RequestCancelToken() : cancelToken;
    headers = (headers == null) ? Map() : headers;
    queryParameters = (queryParameters == null) ? Map() : queryParameters;

    _needToastMessage =
        (needToastMessage == null) ? _needToastMessage : needToastMessage;
    _needAuthentication =
        (needAuthentication == null) ? _needAuthentication : needAuthentication;
    _needCommonParameters = (needCommonParameters == null)
        ? _needCommonParameters
        : needCommonParameters;
    _needCommonHeaders =
        (needCommonHeaders == null) ? _needCommonHeaders : needCommonHeaders;
    _needApiFeedBack =
        (needApiFeedBack == null) ? _needApiFeedBack : needApiFeedBack;

    // BaseOptions baseOptions = BaseOptions(
    //   baseUrl: newBaseUrl,
    // );

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
      cancelToken: cancelToken.cancelToken,
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
    RequestCancelToken cancelToken, // 取消网络请求的Token
    bool needToastMessage,
    bool needAuthentication,
    bool needCommonParameters,
    bool needCommonHeaders,
    bool needApiFeedBack,
  }) {
    return HttpManager.request(
      path,
      queryParameters: queryParameters,
      method: 'POST',
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      cancelToken: cancelToken,
      needToastMessage: needToastMessage,
      needAuthentication: needAuthentication,
      needCommonParameters: needCommonParameters,
      needCommonHeaders: needCommonHeaders,
      needApiFeedBack: needApiFeedBack,
    );
  }

  static Future<ResponseData> get(
    path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    int sendTimeout, // 毫秒
    int receiveTimeout, // 毫秒
    RequestCancelToken cancelToken, // 取消网络请求的Token
    bool needToastMessage,
    bool needAuthentication,
    bool needCommonParameters,
    bool needCommonHeaders,
    bool needApiFeedBack,
  }) {
    return HttpManager.request(
      path,
      queryParameters: queryParameters,
      method: 'GET',
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      cancelToken: cancelToken,
      needToastMessage: needToastMessage,
      needAuthentication: needAuthentication,
      needCommonParameters: needCommonParameters,
      needCommonHeaders: needCommonHeaders,
      needApiFeedBack: needApiFeedBack,
    );
  }

  static Map<String, dynamic> commonParameters() {
    Map<String, dynamic> parameters = {
      'version': "1.0.0",
    };
    return parameters;
  }

  static Map<String, dynamic> commonHeaders() {
    Map<String, dynamic> headers = {
      'Authorization': "",
    };
    return headers;
  }

  static Map<String, dynamic> authenticationHeader() {
    Map<String, dynamic> auth = {'auth': 'auth'};
    return auth;
  }
}

class RequestCancelToken {
  CancelToken _cancelToken = CancelToken();

  RequestCancelToken() : _cancelToken = CancelToken();

  CancelToken get cancelToken => _cancelToken;

  void cancel() {
    _cancelToken.cancel('App取消HTTP请求');
  }
}
