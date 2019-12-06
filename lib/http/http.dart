import 'package:dio/dio.dart';

class HttpUtils {
  static Dio http;
  String baseApi = 'http://202.96.155.121:8888/api';

  String baseUrl = "http://202.96.155.121:8888/api";
//  https://pages.kaola.com/pages/region/advance/kaola123.html?type=2

  HttpUtils() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
    );
    http = Dio(options);
    //添加拦截器
    http.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      return options;
    }, onResponse: (Response response) {
      if (response.data['errno'] == 0) {
        return response.data['data'];
      } else {
        return null;
      }
    }, onError: (DioError error) {
      print(error);
      return error;
    }));
    // 开启日志
     http.interceptors.add(LogInterceptor(responseBody: false));
  }

  Future get(String url, [Map<String, dynamic> params]) {
    return http.get(url, queryParameters: params == null ? {} : params);
  }

  Future post(String url, [Map<String, dynamic> params]) {
    return http.post(url, queryParameters: params == null ? {} : params);
  }

  Future postToken(String url, String token, [Map<String, dynamic> params]) {
    Dio dio = setToken(token);
    return dio.post(url, queryParameters: params == null ? {} : params);
  }

  Future getToken(String url, String token, [Map<String, dynamic> params]) {
    Dio req = setToken(token);
    return req.get(url, queryParameters: params == null ? {} : params);
  }

  Dio setToken(String token) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'x-nideshop-token': token,
      },
    );

    Dio req = Dio(options);
    // 添加拦截器
    req.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      return options; //continue
    }, onResponse: (Response response) {
      if (response.data['errno'] == 0) {
        return response.data['data'];
      } else {
        return null;
      }
    }, onError: (DioError e) {
      print(e);
      return e; //continue
    }));
    return req;
  }
}
