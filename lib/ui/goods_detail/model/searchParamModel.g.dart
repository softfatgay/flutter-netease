// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchParamModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchParamModel _$SearchParamModelFromJson(Map<String, dynamic> json) {
  return SearchParamModel(
    keyWord: json['keyWord'] as String,
    sortType: json['sortType'] as num,
    descSorted: json['descSorted'] as bool,
    categoryId: json['categoryId'] as num,
    matchType: json['matchType'] as num,
    floorPrice: json['floorPrice'] as num,
    upperPrice: json['upperPrice'] as num,
    size: json['size'] as num,
    itemId: json['itemId'] as num,
    stillSearch: json['stillSearch'] as bool,
    searchWordSource: json['searchWordSource'] as num,
    needPopWindow: json['needPopWindow'] as bool,
  );
}

Map<String, dynamic> _$SearchParamModelToJson(SearchParamModel instance) =>
    <String, dynamic>{
      'keyWord': instance.keyWord,
      'sortType': instance.sortType,
      'descSorted': instance.descSorted,
      'categoryId': instance.categoryId,
      'matchType': instance.matchType,
      'floorPrice': instance.floorPrice,
      'upperPrice': instance.upperPrice,
      'size': instance.size,
      'itemId': instance.itemId,
      'stillSearch': instance.stillSearch,
      'searchWordSource': instance.searchWordSource,
      'needPopWindow': instance.needPopWindow,
    };
