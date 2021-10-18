// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kingKongModule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KingKongModule _$KingKongModuleFromJson(Map<String, dynamic> json) =>
    KingKongModule()
      ..norColor = json['norColor'] as String?
      ..background = json['background'] as String?
      ..selectedColor = json['selectedColor'] as String?
      ..kingKongList = (json['kingKongList'] as List<dynamic>?)
          ?.map((e) => KingKongItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$KingKongModuleToJson(KingKongModule instance) =>
    <String, dynamic>{
      'norColor': instance.norColor,
      'background': instance.background,
      'selectedColor': instance.selectedColor,
      'kingKongList': instance.kingKongList,
    };

KingKongItem _$KingKongItemFromJson(Map<String, dynamic> json) => KingKongItem()
  ..picUrl = json['picUrl'] as String?
  ..schemeUrl = json['schemeUrl'] as String?
  ..text = json['text'] as String?
  ..textColor = json['textColor'] as String?;

Map<String, dynamic> _$KingKongItemToJson(KingKongItem instance) =>
    <String, dynamic>{
      'picUrl': instance.picUrl,
      'schemeUrl': instance.schemeUrl,
      'text': instance.text,
      'textColor': instance.textColor,
    };
