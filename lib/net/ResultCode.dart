/*
 * dio网络请求失败的回调错误码 
 */
class ResultCode {

  //正常返回是1
  static const SUCCESS = 1;
  
  //异常返回是0
  static const ERROR = 0;
  
  /// When opening  url timeout, it occurs.
  static const CONNECT_TIMEOUT = -1;

  ///It occurs when receiving timeout.
  static const RECEIVE_TIMEOUT = -2;

  /// When the server response, but with a incorrect status, such as 404, 503...
  static const RESPONSE = -3;
  /// When the request is cancelled, dio will throw a error with this type.
  static const CANCEL = -4;

  /// read the DioError.error if it is not null.
  static const DEFAULT = -5;
}
