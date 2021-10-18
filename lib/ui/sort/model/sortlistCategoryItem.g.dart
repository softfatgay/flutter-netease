// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sortlistCategoryItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortlistCategoryItem _$SortlistCategoryItemFromJson(
        Map<String, dynamic> json) =>
    SortlistCategoryItem()
      ..category = json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>)
      ..itemList = (json['itemList'] as List<dynamic>?)
          ?.map((e) => ItemListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SortlistCategoryItemToJson(
        SortlistCategoryItem instance) =>
    <String, dynamic>{
      'category': instance.category,
      'itemList': instance.itemList,
    };
