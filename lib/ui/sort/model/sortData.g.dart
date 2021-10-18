// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sortData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortData _$SortDataFromJson(Map<String, dynamic> json) => SortData()
  ..categoryL1List = (json['categoryL1List'] as List<dynamic>?)
      ?.map((e) => CategoryL1Item.fromJson(e as Map<String, dynamic>))
      .toList()
  ..currentCategory = json['currentCategory'] == null
      ? null
      : CurrentCategory.fromJson(
          json['currentCategory'] as Map<String, dynamic>)
  ..categoryGroupList = (json['categoryGroupList'] as List<dynamic>?)
      ?.map((e) => CategoryGroupItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$SortDataToJson(SortData instance) => <String, dynamic>{
      'categoryL1List': instance.categoryL1List,
      'currentCategory': instance.currentCategory,
      'categoryGroupList': instance.categoryGroupList,
    };
