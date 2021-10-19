import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/http_manager/response_data.dart';
import 'package:flutter_app/utils/user_config.dart';

class HttpManager {
  static _netError() {
    BotToast.showSimpleNotification(
        title: "请检查网络是否连接",
        backgroundColor: backYellow,
        titleStyle: t16white,
        closeIcon: Icon(
          Icons.cancel,
          color: textWhite,
        ));
  }

  static Dio? _dio;

  static get dioInstance {
    if (_dio == null) {
      var baseOptions = BaseOptions(
        baseUrl: NetContants.baseUrl,
        sendTimeout: 30000,
        receiveTimeout: 30000,
        connectTimeout: 30000,
        headers: commonHeaders(),
      );
      var interceptorsWrapper = InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) {
        _print("请求数据开始 ---------->\n");
        _print("method = ${options.method.toString()}");
        _print("url = ${options.uri.toString()}");
        _print("headers = ${options.headers}");
        _print("params = ${options.queryParameters}");
        _print("body = ${options.data}");

        handler.next(options);
      }, onResponse: (Response response, ResponseInterceptorHandler handler) {
        _print("开始响应 ---------->\n");
        _print("${response.realUri}\n");
        _print("code = ${response.statusCode}");
        _print("data = ${json.encode(response.data)}");
        LogUtil.v("data = ${json.encode(response.data)}"); //打印长Log
        handler.next(response);
        _print("响应结束 ---------->\n\n\n\n\n");
      }, onError: (DioError e, ErrorInterceptorHandler handler) {
        _print("错误响应数据 ---------->\n");
        _print("type = ${e.type}");
        if (e.type == DioErrorType.other) {
          _netError();
        }
        _print("message = ${e.message}");
        _print("stackTrace = ${e.message}");
        _print("\n");
        handler.next(e);
      });
      _dio = Dio(baseOptions);
      _dio!.interceptors.add(interceptorsWrapper);
    }
    return _dio;
  }

  static Future<ResponseData> _request(
    //TODO GET和POST添加静态
    String path, {
    String method = 'GET',
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic data,
    dynamic formData,
    String? accept,
    int? sendTimeout,
    int? receiveTimeout,
    RequestCancelToken? cancelToken,
    bool? needToastMessage,
    bool? needAuthentication,
    bool? needCommonParameters,
    bool? needCommonHeaders,
    bool showProgress = false,
    SignatureCondition? signatureCondition, // 签名条件
  }) async {
    if (showProgress) {
      BotToast.showLoading(
          clickClose: true, backgroundColor: Colors.transparent);
    }
    // get native data
    cancelToken = cancelToken ?? RequestCancelToken();
    headers = headers ?? Map();
    queryParameters = queryParameters ?? Map();
    sendTimeout = sendTimeout ?? 30000;
    receiveTimeout = receiveTimeout ?? 30000;

    if (needCommonHeaders ?? true) {
      headers.addAll(commonHeaders());
    }

    ///注意代理必须配置到await dio.request之后，否则不打开抓包工具时无法访问网络
    Options options = Options(
      method: method,
      headers: headers,
    );
    try {
      Response response = await dioInstance.request(
        path,
        data: formData == null ? data : FormData.fromMap(formData),
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken.cancelToken,
        // formData:formData,
      );
      if (response.data != null) {
        return ResponseData.convertData(response);
      } else {
        return Future.value(ResponseData());
      }
    } on DioError catch (e) {
      // BotToast.showText(text: '请求失败，请稍后重试');
      return Future.value(ResponseData());
    } catch (e) {
      _netError();
    } finally {
      if (showProgress) {
        BotToast.closeAllLoading();
      }
    }
    return Future.value(ResponseData());
  }

  static Future<ResponseData> post(
    path, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    dynamic data,
    int? sendTimeout, // 毫秒
    int? receiveTimeout, // 毫秒
    RequestCancelToken? cancelToken, // 取消网络请求的Token
    bool? needToastMessage,
    bool? needAuthentication,
    bool? needCommonParameters,
    bool? needCommonHeaders,
    String? accept,
    dynamic formData,
    bool showProgress = false,
    SignatureCondition? signatureCondition, // 签名条件
  }) {
    return _request(
      path,
      queryParameters: params,
      data: data,
      formData: formData,
      method: 'POST',
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      cancelToken: cancelToken,
      needToastMessage: needToastMessage,
      needAuthentication: needAuthentication,
      needCommonParameters: needCommonParameters,
      needCommonHeaders: needCommonHeaders,
      accept: accept,
      showProgress: showProgress,
      signatureCondition: signatureCondition,
    );
  }

  static Future<ResponseData> get(
    path, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    int? sendTimeout, // 毫秒
    int? receiveTimeout, // 毫秒
    RequestCancelToken? cancelToken, // 取消网络请求的Token
    bool? needToastMessage,
    bool? needAuthentication,
    bool? needCommonParameters,
    bool? needCommonHeaders,
    String? accept,
    bool showProgress = false,
    SignatureCondition? signatureCondition, // 签名条件
  }) {
    return _request(
      path,
      queryParameters: params,
      method: 'GET',
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      cancelToken: cancelToken,
      needToastMessage: needToastMessage,
      needAuthentication: needAuthentication,
      needCommonParameters: needCommonParameters,
      needCommonHeaders: needCommonHeaders,
      accept: accept,
      showProgress: showProgress,
      signatureCondition: signatureCondition,
    );
  }

  static Map<String, dynamic> commonParameters() => {
        "csrf_token": csrf_token,
        "__timestamp": "${DateTime.now().millisecondsSinceEpoch}",
      };

  static Map<String, dynamic> commonHeaders() => {"cookie": cookie};

  static Map<String, dynamic> authenticationHeader() => {'auth': 'auth'};

  static Future<Map<String, dynamic>> signatureHeader() async => {};

  static _print(Object? object) {
    if (kDebugMode) {
      print(object ?? '');
    }
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

class SignatureCondition {
  bool? needSign = false;
  String? originalSuffix = '';

  SignatureCondition({
    this.needSign,
    this.originalSuffix,
  });
}
