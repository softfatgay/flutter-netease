import 'package:json_annotation/json_annotation.dart';

part 'noticeListModel.g.dart';

@JsonSerializable()
class NoticeListModel {
  num type;
  String content;
  String targetUrl;

  NoticeListModel();

  factory NoticeListModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeListModelFromJson(json);
}
