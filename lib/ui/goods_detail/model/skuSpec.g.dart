// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skuSpec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkuSpec _$SkuSpecFromJson(Map<String, dynamic> json) => SkuSpec()
  ..id = json['id'] as num?
  ..name = json['name'] as String?
  ..type = json['type'] as num?
  ..skuSpecValueList = (json['skuSpecValueList'] as List<dynamic>?)
      ?.map((e) => SkuSpecValueListItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$SkuSpecToJson(SkuSpec instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'skuSpecValueList': instance.skuSpecValueList,
    };

SkuSpecValueListItem _$SkuSpecValueListItemFromJson(
        Map<String, dynamic> json) =>
    SkuSpecValueListItem()
      ..id = json['id'] as num?
      ..value = json['value'] as String?;

Map<String, dynamic> _$SkuSpecValueListItemToJson(
        SkuSpecValueListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };
