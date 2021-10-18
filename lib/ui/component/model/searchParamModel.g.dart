// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchParamModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchParamModel _$SearchParamModelFromJson(Map<String, dynamic> json) =>
    SearchParamModel(
      keyWord: json['keyWord'] as String? ?? '',
      sortType: json['sortType'] as num? ?? 0,
      statSearch: json['statSearch'] as String? ?? '',
      descSorted: json['descSorted'] as bool?,
      categoryId: json['categoryId'] as num? ?? 0,
      matchType: json['matchType'] as num? ?? 0,
      floorPrice: json['floorPrice'] as num? ?? -1,
      upperPrice: json['upperPrice'] as num? ?? -1,
      size: json['size'] as num? ?? 40,
      itemId: json['itemId'] as num? ?? 0,
      stillSearch: json['stillSearch'] as bool? ?? false,
      searchWordSource: json['searchWordSource'] as num? ?? 5,
      needPopWindow: json['needPopWindow'] as bool? ?? true,
    )
      ..promotionId = json['promotionId'] as num?
      ..source = json['source'] as num?;

Map<String, dynamic> _$SearchParamModelToJson(SearchParamModel instance) =>
    <String, dynamic>{
      'keyWord': instance.keyWord,
      'statSearch': instance.statSearch,
      'sortType': instance.sortType,
      'descSorted': instance.descSorted,
      'categoryId': instance.categoryId,
      'matchType': instance.matchType,
      'floorPrice': instance.floorPrice,
      'upperPrice': instance.upperPrice,
      'size': instance.size,
      'itemId': instance.itemId,
      'promotionId': instance.promotionId,
      'stillSearch': instance.stillSearch,
      'searchWordSource': instance.searchWordSource,
      'needPopWindow': instance.needPopWindow,
      'source': instance.source,
    };
