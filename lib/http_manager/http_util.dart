import 'package:flutter_app/utils/user_config.dart';

class HttpUtil {
  static Map<String, dynamic> getHeader() {
    return {"Cookie": cookie};
  }
}
