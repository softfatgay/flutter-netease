import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class HttpOne {
  static final baseUrl = 'https://gank.io/api/';
  static final debug = !bool.fromEnvironment("dart.vm.product");
  static final Dio _dio = Dio(BaseOptions(
      method: 'get',
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      followRedirects: true));

  ///拦截器设置
  static void setInterceptor() {
    _dio.interceptors.add(
        InterceptorsWrapper(onError: (DioError e) async {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.none) {
//            e.message = "网络连接异常，请检查手机网络设置";
          } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
//            e.message = "网络连接异常，请检查手机网络设置";
          } else {
//            e.message = "未知错误";
          }
          return e; //continue
        })
    );
  }

  static void setHeader(Map<String, String> header) {
    _dio.options.headers = header;
  }

  static final HttpError httpError = HttpError(-1, '未知异常');


  static Future<Map<String, dynamic>> getJson<T>(String uri,
      Map<String, dynamic> paras) {
    return _httpJson('get', uri, data: paras).then(logicalSuccessTransform);
  }

  static Future<Map<String, dynamic>> getForm<T>(String uri,
      Map<String, dynamic> paras) =>
      _httpJson('get', uri, data: paras, dataIsJson: false).then(
          logicalSuccessTransform);

  /// 表单方式的post
  static Future<Map<String, dynamic>> postForm<T>(
      String uri, Map<String, dynamic> paras) =>
      _httpJson("post", uri, data: paras, dataIsJson: false)
          .then(logicalSuccessTransform);

  /// requestBody (json格式参数) 方式的 post
  static Future<Map<String, dynamic>> postJson(
      String uri, Map<String, dynamic> body) =>
      _httpJson("post", uri, data: body).then(logicalSuccessTransform);


  static Future<Response<Map<String, dynamic>>> _httpJson(String method,
      String uri, {Map<String, dynamic> data, bool dataIsJson = true}) async {
    if (!uri.contains('today')) setInterceptor();
    if (method == 'get') {
      dataIsJson = false;
      if (data == null) {
        data = Map<String, dynamic>();
      }
    }

    if (debug) {
      print('<net url>------$uri');
      print('<net params>------$data');
    }

    /// 根据当前 请求的类型来设置 如果是请求体形式则使用json格式
    /// 否则则是表单形式的（拼接在url上）
    Options op;
    if (dataIsJson) {
//      op = Options(contentType: ContentType.parse("application/json"));
      op = Options(method: 'application/json');
    } else {
      op = Options(method: 'application/x-www-form-urlencoded');
//      op = Options(
//          contentType: ContentType.parse('application/x-www-form-urlencoded'));
    }
    op.method = method;

    return _dio.request<Map<String, dynamic>>(
        method == 'get' ? uri : '$uri', data: data, options: op);
  }


  /// 对请求返回的数据进行统一的处理
  /// 如果成功则将我们需要的数据返回出去，否则进异常处理方法，返回异常信息
  static Future<Map<String, dynamic>> logicalSuccessTransform<T>(
      Response<Map<String, dynamic>> resp) {
    if (resp.data != null) {
      return Future.value(resp.data);
    } else {
      return Future.value(null);
    }
  }
}




/// 统一异常类
class HttpError {
  int errorCode;
  String msg;

  HttpError(errorCode, msg) {
    this.errorCode = errorCode;
    this.msg = msg;
  }
}