// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preNewItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreNewItem _$PreNewItemFromJson(Map<String, dynamic> json) => PreNewItem()
  ..listPicUrl = json['listPicUrl'] as String?
  ..retailPrice = json['retailPrice'] as num?
  ..name = json['name'] as String?
  ..id = json['id'] as num?;

Map<String, dynamic> _$PreNewItemToJson(PreNewItem instance) =>
    <String, dynamic>{
      'listPicUrl': instance.listPicUrl,
      'retailPrice': instance.retailPrice,
      'name': instance.name,
      'id': instance.id,
    };
