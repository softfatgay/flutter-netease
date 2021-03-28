// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skuSpecValue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkuSpecValue _$SkuSpecValueFromJson(Map<String, dynamic> json) {
  return SkuSpecValue()
    ..id = json['id'] as num
    ..skuSpecId = json['skuSpecId'] as num
    ..picUrl = json['picUrl'] as String
    ..value = json['value'] as String;
}

Map<String, dynamic> _$SkuSpecValueToJson(SkuSpecValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'skuSpecId': instance.skuSpecId,
      'picUrl': instance.picUrl,
      'value': instance.value,
    };
