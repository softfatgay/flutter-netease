// import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:flutter_app/net/GlobalConfig.dart';
// import 'package:flutter_app/net/ResultCode.dart';
//
// /*
//  * 网络请求管理类
//  */
// class DioManager {
//   //写一个单例
//   //在 Dart 里，带下划线开头的变量是私有变量
//   static DioManager _instance;
//
//   static DioManager getInstance() {
//     if (_instance == null) {
//       _instance = DioManager();
//     }
//     return _instance;
//   }
//
//   static Dio dio = new Dio();
//   DioManager() {
//     // Set default configs
// //    dio.options.headers = {
// //
// //    };
//     dio.options.baseUrl = "http://m.you.163.com/";
//     dio.options.connectTimeout = 5000;
//     dio.options.receiveTimeout = 3000;
//
//     dio.interceptors
//         .add(LogInterceptor(responseBody: GlobalConfig.isDebug)); //是否开启请求日志
// //    dio.interceptors.add(CookieManager(CookieJar()));//缓存相关类，具体设置见https://github.com/flutterchina/cookie_jar
//   }
//
//   //get请求
//   static get(String url, Map params, Function successCallBack,
//       {Function errorCallBack}) async {
//     _instance = getInstance();
//     _requstHttp(url, successCallBack, 'get', params, errorCallBack);
//   }
//
//   //post请求
//   static post(String url, params, Function successCallBack,
//       {Function errorCallBack}) async {
//     _instance = getInstance();
//     _requstHttp(url, successCallBack, "post", params, errorCallBack);
//   }
//
//   //post请求
//   static postB(String baseUrl, String url, params, Function successCallBack,
//       {Function errorCallBack}) async {
//     _instance = getInstance();
//     _requstHttpB(baseUrl, url, successCallBack, "post", params, errorCallBack);
//   }
//
//   static _requstHttpB(String baseUrl, String url, Function successCallBack,
//       [String method, Map params, Function errorCallBack]) async {
//     Response response;
//     try {
//       if (method == 'get') {
//         if (params != null && params.isNotEmpty) {
//           response = await dio.get(url, queryParameters: params);
//         } else {
//           response = await dio.get(url);
//         }
//       } else if (method == 'post') {
//         if (params != null && params.isNotEmpty) {
//           response = await dio.post(url, queryParameters: params);
//         } else {
//           response = await dio.post(url);
//         }
//       }
//     } on DioError catch (error) {
//       // 请求错误处理
//       Response errorResponse;
//       if (error.response != null) {
//         errorResponse = error.response;
//       } else {
//         errorResponse = new Response(statusCode: 666);
//       }
//       // 请求超时
//       if (error.type == DioErrorType.connectTimeout) {
//         errorResponse.statusCode = ResultCode.CONNECT_TIMEOUT;
//       }
//       // 一般服务器错误
//       else if (error.type == DioErrorType.receiveTimeout) {
//         errorResponse.statusCode = ResultCode.RECEIVE_TIMEOUT;
//       }
//
//       // debug模式才打印
//       if (GlobalConfig.isDebug) {
//         print('请求异常: ' + error.toString());
//         print('请求异常url: ' + url);
//         print('请求头: ' + dio.options.headers.toString());
//         print('method: ' + dio.options.method);
//       }
//       _error(errorCallBack, error.message);
//       return '';
//     }
//     // debug模式打印相关数据
//     if (GlobalConfig.isDebug) {
//       print('请求url: ' + url);
//       print('请求头: ' + dio.options.headers.toString());
//       if (params != null) {
//         print('请求参数: ' + params.toString());
//       }
//       if (response != null) {
//         print('返回参数: ' + response.toString());
//       }
//     }
//     String dataStr = json.encode(response.data);
//     Map<String, dynamic> dataMap = json.decode(dataStr);
//     if (dataMap == null || dataMap['code'] == 0) {
//       _error(
//           errorCallBack,
//           '错误码：' +
//               dataMap['errorCode'].toString() +
//               '，' +
//               response.data.toString());
//     } else if (successCallBack != null) {
//       successCallBack(dataMap);
//     }
//   }
//
//   static _requstHttp(String url, Function successCallBack,
//       [String method, Map params, Function errorCallBack]) async {
//     Response response;
//     try {
//       if (method == 'get') {
//         if (params != null && params.isNotEmpty) {
//           response = await dio.get(url, queryParameters: params);
//         } else {
//           response = await dio.get(url);
//         }
//       } else if (method == 'post') {
//         if (params != null && params.isNotEmpty) {
//           response = await dio.post(url, queryParameters: params);
//         } else {
//           response = await dio.post(url);
//         }
//       }
//     } on DioError catch (error) {
//       // 请求错误处理
//       Response errorResponse;
//       if (error.response != null) {
//         errorResponse = error.response;
//       } else {
//         errorResponse = new Response(statusCode: 666);
//       }
//       // 请求超时
//       if (error.type == DioErrorType.connectTimeout) {
//         errorResponse.statusCode = ResultCode.CONNECT_TIMEOUT;
//       }
//       // 一般服务器错误
//       else if (error.type == DioErrorType.receiveTimeout) {
//         errorResponse.statusCode = ResultCode.RECEIVE_TIMEOUT;
//       }
//
//       // debug模式才打印
//       if (GlobalConfig.isDebug) {
//         print('请求异常: ' + error.toString());
//         print('请求异常url: ' + url);
//         print('请求头: ' + dio.options.headers.toString());
//         print('method: ' + dio.options.method);
//       }
//       _error(errorCallBack, error.message);
//       return '';
//     }
//     // debug模式打印相关数据
//     if (GlobalConfig.isDebug) {
//       print('请求url: ' + url);
//       print('请求头: ' + dio.options.headers.toString());
//       if (params != null) {
//         print('请求参数: ' + params.toString());
//       }
//       if (response != null) {
//         print('返回参数: ' + response.toString());
//       }
//     }
//     String dataStr = json.encode(response.data);
//     Map<String, dynamic> dataMap = json.decode(dataStr);
//     if (dataMap == null || dataMap['code'] == 0) {
//       _error(
//           errorCallBack,
//           '错误码：' +
//               dataMap['errorCode'].toString() +
//               '，' +
//               response.data.toString());
//     } else if (successCallBack != null) {
//       successCallBack(dataMap);
//     }
//   }
//
//   static _error(Function errorCallBack, String error) {
//     if (errorCallBack != null) {
//       errorCallBack(error);
//     }
//   }
// }
