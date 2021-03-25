// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focusItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FocusItem _$FocusItemFromJson(Map<String, dynamic> json) {
  return FocusItem()
    ..picUrl = json['picUrl'] as String
    ..expireTime = json['expireTime'] as num
    ..name = json['name'] as String
    ..onlineTime = json['onlineTime'] as num
    ..id = json['id'] as num
    ..originSchemeUrl = json['originSchemeUrl'] as String
    ..targetUrl = json['targetUrl'] as String;
}

Map<String, dynamic> _$FocusItemToJson(FocusItem instance) => <String, dynamic>{
      'picUrl': instance.picUrl,
      'expireTime': instance.expireTime,
      'name': instance.name,
      'onlineTime': instance.onlineTime,
      'id': instance.id,
      'originSchemeUrl': instance.originSchemeUrl,
      'targetUrl': instance.targetUrl,
    };
