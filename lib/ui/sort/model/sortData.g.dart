// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sortData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortData _$SortDataFromJson(Map<String, dynamic> json) {
  return SortData()
    ..categoryL1List = (json['categoryL1List'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryL1Item.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..currentCategory = json['currentCategory'] == null
        ? null
        : CurrentCategory.fromJson(
            json['currentCategory'] as Map<String, dynamic>)
    ..categoryGroupList = (json['categoryGroupList'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryGroupItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SortDataToJson(SortData instance) => <String, dynamic>{
      'categoryL1List': instance.categoryL1List,
      'currentCategory': instance.currentCategory,
      'categoryGroupList': instance.categoryGroupList,
    };
