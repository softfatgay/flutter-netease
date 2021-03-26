// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryL1ListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryL1ListItem _$CategoryL1ListItemFromJson(Map<String, dynamic> json) {
  return CategoryL1ListItem()
    ..id = json['id'] as num
    ..superCategoryId = json['superCategoryId'] as num
    ..showIndex = json['showIndex'] as num
    ..name = json['name'] as String
    ..frontName = json['frontName'] as String
    ..frontDesc = json['frontDesc'] as String
    ..wapBannerUrl = json['wapBannerUrl'] as String;
}

Map<String, dynamic> _$CategoryL1ListItemToJson(CategoryL1ListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'superCategoryId': instance.superCategoryId,
      'showIndex': instance.showIndex,
      'name': instance.name,
      'frontName': instance.frontName,
      'frontDesc': instance.frontDesc,
      'wapBannerUrl': instance.wapBannerUrl,
    };
