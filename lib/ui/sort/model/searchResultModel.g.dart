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
        ?.toList();
}

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
    <String, dynamic>{
      'hasMore': instance.hasMore,
      'directlyList': instance.directlyList,
    };
