// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'styleItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleItem _$StyleItemFromJson(Map<String, dynamic> json) => StyleItem()
  ..targetUrl = json['targetUrl'] as String?
  ..title = json['title'] as String?
  ..picUrl = json['picUrl'] as String?
  ..originSchemeUrl = json['originSchemeUrl'] as String?
  ..descColor = json['descColor'] as String?
  ..titleColor = json['titleColor'] as String?
  ..desc = json['desc'] as String?
  ..picUrlList =
      (json['picUrlList'] as List<dynamic>?)?.map((e) => e as String?).toList();

Map<String, dynamic> _$StyleItemToJson(StyleItem instance) => <String, dynamic>{
      'targetUrl': instance.targetUrl,
      'title': instance.title,
      'picUrl': instance.picUrl,
      'originSchemeUrl': instance.originSchemeUrl,
      'descColor': instance.descColor,
      'titleColor': instance.titleColor,
      'desc': instance.desc,
      'picUrlList': instance.picUrlList,
    };
