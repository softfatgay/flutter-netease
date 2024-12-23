// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemPicBeanList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemPicBeanList _$ItemPicBeanListFromJson(Map<String, dynamic> json) =>
    ItemPicBeanList()
      ..itemId = (json['itemId'] as num?)?.toInt()
      ..picUrl = json['picUrl'] as String?;

Map<String, dynamic> _$ItemPicBeanListToJson(ItemPicBeanList instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'picUrl': instance.picUrl,
    };
