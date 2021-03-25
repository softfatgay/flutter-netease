// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexActivityModule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexActivityModule _$IndexActivityModuleFromJson(Map<String, dynamic> json) {
  return IndexActivityModule()
    ..backgroundUrl = json['backgroundUrl'] as String
    ..picUrl = json['picUrl'] as String
    ..activityPrice = json['activityPrice'] as String
    ..subTitle = json['subTitle'] as String
    ..originPrice = json['originPrice'] as String
    ..tag = json['tag'] as String
    ..title = json['title'] as String
    ..targetUrl = json['targetUrl'] as String
    ..showPicUrl = json['showPicUrl'] as String;
}

Map<String, dynamic> _$IndexActivityModuleToJson(
        IndexActivityModule instance) =>
    <String, dynamic>{
      'backgroundUrl': instance.backgroundUrl,
      'picUrl': instance.picUrl,
      'activityPrice': instance.activityPrice,
      'subTitle': instance.subTitle,
      'originPrice': instance.originPrice,
      'tag': instance.tag,
      'title': instance.title,
      'targetUrl': instance.targetUrl,
      'showPicUrl': instance.showPicUrl,
    };
