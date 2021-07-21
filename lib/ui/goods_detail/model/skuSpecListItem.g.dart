// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skuSpecListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkuSpecListItem _$SkuSpecListItemFromJson(Map<String, dynamic> json) {
  return SkuSpecListItem()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..type = json['type'] as num
    ..skuSpecValueList = (json['skuSpecValueList'] as List)
        ?.map((e) =>
            e == null ? null : SkuSpecValue.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SkuSpecListItemToJson(SkuSpecListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'skuSpecValueList': instance.skuSpecValueList,
    };
