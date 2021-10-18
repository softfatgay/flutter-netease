// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryL1Item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryL1Item _$CategoryL1ItemFromJson(Map<String, dynamic> json) =>
    CategoryL1Item()
      ..id = json['id'] as num?
      ..superCategoryId = json['superCategoryId'] as num?
      ..showIndex = json['showIndex'] as num?
      ..name = json['name'] as String?;

Map<String, dynamic> _$CategoryL1ItemToJson(CategoryL1Item instance) =>
    <String, dynamic>{
      'id': instance.id,
      'superCategoryId': instance.superCategoryId,
      'showIndex': instance.showIndex,
      'name': instance.name,
    };
