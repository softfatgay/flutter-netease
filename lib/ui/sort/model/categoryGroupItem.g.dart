// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryGroupItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryGroupItem _$CategoryGroupItemFromJson(Map<String, dynamic> json) =>
    CategoryGroupItem()
      ..id = json['id'] as num?
      ..name = json['name'] as String?
      ..categoryList = (json['categoryList'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CategoryGroupItemToJson(CategoryGroupItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryList': instance.categoryList,
    };
