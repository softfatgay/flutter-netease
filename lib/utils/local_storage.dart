import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static String keyWord = "key_word";
  static String userName = "user_name";
  static String userIcon = "user_icon";
  static String pointsCnt = "points_cnt";
  static String noticeList = "notice_list";
  static String totalNum = 'total_num';
  static String dftAddress = 'dft_address';

  static SharedPreferences? _sp;

  // 如果_sp已存在，直接返回，为null时创建
  static Future<SharedPreferences?> get sp async {
    if (_sp == null) {
      _sp = await SharedPreferences.getInstance();
    }
    return _sp;
  }

  static Future<bool> save(String key, String value) async {
    return (await sp)!.setString(key, value);
  }

  static dynamic get(String key) async {
    return (await sp)!.get(key);
  }

  static Future<bool> saveInt(String key, int value) async {
    return (await sp)!.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    return (await sp)!.getInt(key);
  }

  static Future<bool> remove(String key) async {
    return (await sp)!.remove(key);
  }
}
