import 'package:intl/intl.dart';

class TimeUtil {
  static String formatLong(num? ms) {
    if (ms == null || ms == 0) {
      return "";
    }
    final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');
    var format = fmt.format(DateTime.fromMillisecondsSinceEpoch(ms as int));
    return format;
  }
}
