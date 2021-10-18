// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemPoolModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemPoolModel _$ItemPoolModelFromJson(Map<String, dynamic> json) =>
    ItemPoolModel()
      ..categorytList = (json['categorytList'] as List<dynamic>?)
          ?.map((e) => CategorytListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..searcherItemListResult = json['searcherItemListResult'] == null
          ? null
          : SearcherItemListResult.fromJson(
              json['searcherItemListResult'] as Map<String, dynamic>);

Map<String, dynamic> _$ItemPoolModelToJson(ItemPoolModel instance) =>
    <String, dynamic>{
      'categorytList': instance.categorytList,
      'searcherItemListResult': instance.searcherItemListResult,
    };

CategorytListItem _$CategorytListItemFromJson(Map<String, dynamic> json) =>
    CategorytListItem()
      ..categoryVO = json['categoryVO'] == null
          ? null
          : CategoryL1Item.fromJson(json['categoryVO'] as Map<String, dynamic>)
      ..count = json['count'] as num?;

Map<String, dynamic> _$CategorytListItemToJson(CategorytListItem instance) =>
    <String, dynamic>{
      'categoryVO': instance.categoryVO,
      'count': instance.count,
    };

SearcherItemListResult _$SearcherItemListResultFromJson(
        Map<String, dynamic> json) =>
    SearcherItemListResult()
      ..pagination = json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
      ..result = (json['result'] as List<dynamic>?)
          ?.map((e) => GoodDetail.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearcherItemListResultToJson(
        SearcherItemListResult instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'result': instance.result,
    };
