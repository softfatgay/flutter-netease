// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) {
  return SearchResultModel()
    ..hasMore = json['hasMore'] as bool
    ..directlyList = (json['directlyList'] as List)
        ?.map((e) =>
            e == null ? null : ItemListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..categoryL1List = (json['categoryL1List'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryL1Item.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
    <String, dynamic>{
      'hasMore': instance.hasMore,
      'directlyList': instance.directlyList,
      'categoryL1List': instance.categoryL1List,
    };

CategoryL1ListItem _$CategoryL1ListItemFromJson(Map<String, dynamic> json) {
  return CategoryL1ListItem()
    ..id = json['id'] as num
    ..name = json['name'] as String;
}

Map<String, dynamic> _$CategoryL1ListItemToJson(CategoryL1ListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
