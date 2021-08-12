// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noticeListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeListModel _$NoticeListModelFromJson(Map<String, dynamic> json) {
  return NoticeListModel()
    ..type = json['type'] as num
    ..content = json['content'] as String
    ..targetUrl = json['targetUrl'] as String;
}

Map<String, dynamic> _$NoticeListModelToJson(NoticeListModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'content': instance.content,
      'targetUrl': instance.targetUrl,
    };
