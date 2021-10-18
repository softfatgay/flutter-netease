// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) =>
    SearchResultModel()
      ..hasMore = json['hasMore'] as bool?
      ..directlyList = (json['directlyList'] as List<dynamic>?)
          ?.map((e) => ItemListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..categoryL1List = (json['categoryL1List'] as List<dynamic>?)
          ?.map((e) => CategoryL1Item.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
    <String, dynamic>{
      'hasMore': instance.hasMore,
      'directlyList': instance.directlyList,
      'categoryL1List': instance.categoryL1List,
    };

CategoryL1ListItem _$CategoryL1ListItemFromJson(Map<String, dynamic> json) =>
    CategoryL1ListItem()
      ..id = json['id'] as num?
      ..name = json['name'] as String?;

Map<String, dynamic> _$CategoryL1ListItemToJson(CategoryL1ListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
