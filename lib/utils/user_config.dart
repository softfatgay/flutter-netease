import 'package:flutter_app/config/cookieConfig.dart';

const String user_icon_url =
    'http://yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png';

String get cookie {
  return CookieConfig.cookie;
}

String get csrf_token {
  return CookieConfig.token;
}

//yx_csrf;NTES_SESS
//yx_csrf;NTES_YD_SESS;P_INFO
//flutter build apk --target-platform android-arm
