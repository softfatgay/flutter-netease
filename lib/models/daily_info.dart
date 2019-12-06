/// 某个日期网站数据
class DailyInfo {
  List<String> category;
  bool error;
  Map<String, dynamic> results;

  DailyInfo({this.category, this.error, this.results});

  DailyInfo.fromJson(Map<String, dynamic> json) {
    category = json['category'].cast<String>();
    error = json['error'];
    results = json['results'] != null ? json['results'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['error'] = this.error;
    if (this.results != null) {
      data['results'] = this.results;
    }
    return data;
  }
}
