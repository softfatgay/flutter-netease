import 'package:dio/dio.dart';

class ResponseData<T> {
  /// Response body. may have been transformed, please refer to [ResponseType].
  final T data;

  /// AToken Server Status
  final T status;

  /// AToken Server Message
  final T code;

  /// The corresponding request info.
  final HttpRequestOptions httpRequestOptions;

  const ResponseData({
    this.data,
    this.status,
    this.code,
    this.httpRequestOptions,
  });

  static Future<ResponseData> convertData(Response response) {
    ResponseData responseData = ResponseData(
      data: response.data['data'],
      status: response.data['status'],
      code: response.data['code'],
      httpRequestOptions: HttpRequestOptions.convert(response.request),
    );
    Future<ResponseData> future;
    future = Future.value(responseData);
    return future;
  }
}

class HttpRequestOptions {
  final String method;
  final int sendTimeout;
  final int receiveTimeout;
  final String path;
  final String baseUrl;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> queryParameters;
  final ProgressCallback onReceiveProgress;
  final ProgressCallback onSendProgress;
  const HttpRequestOptions({
    this.method,
    this.sendTimeout,
    this.receiveTimeout,
    this.path,
    this.baseUrl,
    this.headers,
    this.queryParameters,
    this.onReceiveProgress,
    this.onSendProgress,
  });
  factory HttpRequestOptions.convert(RequestOptions requestOptions) {
    return HttpRequestOptions(
      method: requestOptions.method,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      path: requestOptions.path,
      baseUrl: requestOptions.baseUrl,
      headers: requestOptions.headers,
      queryParameters: requestOptions.queryParameters,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
    );
  }
}
