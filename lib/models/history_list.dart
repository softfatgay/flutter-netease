import 'dart:convert' show json;

/// 干货历史
class HistoryList {
  bool error;
  List<HistoryInfo> results;

  HistoryList.fromParams({this.error, this.results});

  factory HistoryList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new HistoryList.fromJson(json.decode(jsonStr))
          : new HistoryList.fromJson(jsonStr);

  HistoryList.fromJson(jsonRes) {
    error = jsonRes['error'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']) {
      results.add(
          resultsItem == null ? null : new HistoryInfo.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"error": $error,"results": $results}';
  }
}

class HistoryInfo {
  String id;
  String content;
  String createdAt;
  String publishedAt;
  String randId;
  String title;
  String updatedAt;

  HistoryInfo.fromParams(
      {this.id,
      this.content,
      this.createdAt,
      this.publishedAt,
      this.randId,
      this.title,
      this.updatedAt});

  HistoryInfo.fromJson(jsonRes) {
    id = jsonRes['_id'];
    content = jsonRes['content'];
    createdAt = jsonRes['created_at'];
    publishedAt = jsonRes['publishedAt'];
    randId = jsonRes['rand_id'];
    title = jsonRes['title'];
    updatedAt = jsonRes['updated_at'];
  }

  @override
  String toString() {
    return '{"_id": ${id != null ? '${json.encode(id)}' : 'null'},'
        '"content": ${content != null ? '${json.encode(content)}' : 'null'},'
        '"created_at": ${createdAt != null ? '${json.encode(createdAt)}' : 'null'},'
        '"publishedAt": ${publishedAt != null ? '${json.encode(publishedAt)}' : 'null'},'
        '"rand_id": ${randId != null ? '${json.encode(randId)}' : 'null'},'
        '"title": ${title != null ? '${json.encode(title)}' : 'null'},'
        '"updated_at": ${updatedAt != null ? '${json.encode(updatedAt)}' : 'null'}}';
  }
}
