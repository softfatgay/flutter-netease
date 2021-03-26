// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryItemListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItemListItem _$CategoryItemListItemFromJson(Map<String, dynamic> json) {
  return CategoryItemListItem()
    ..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>)
    ..itemList = (json['itemList'] as List)
        ?.map((e) =>
            e == null ? null : ItemListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CategoryItemListItemToJson(
        CategoryItemListItem instance) =>
    <String, dynamic>{
      'category': instance.category,
      'itemList': instance.itemList,
    };
