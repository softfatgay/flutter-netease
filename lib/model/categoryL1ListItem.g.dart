// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryL1ListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryL1ListItem _$CategoryL1ListItemFromJson(Map<String, dynamic> json) =>
    CategoryL1ListItem()
      ..id = json['id'] as num?
      ..superCategoryId = json['superCategoryId'] as num?
      ..showIndex = json['showIndex'] as num?
      ..name = json['name'] as String?
      ..frontName = json['frontName'] as String?
      ..frontDesc = json['frontDesc'] as String?
      ..bannerUrl = json['bannerUrl'] as String?
      ..wapBannerUrl = json['wapBannerUrl'] as String?
      ..iconUrl = json['iconUrl'] as String?
      ..imgUrl = json['imgUrl'] as String?
      ..level = json['level'] as String?
      ..type = json['type'] as num?
      ..categoryType = json['categoryType'] as num?;

Map<String, dynamic> _$CategoryL1ListItemToJson(CategoryL1ListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'superCategoryId': instance.superCategoryId,
      'showIndex': instance.showIndex,
      'name': instance.name,
      'frontName': instance.frontName,
      'frontDesc': instance.frontDesc,
      'bannerUrl': instance.bannerUrl,
      'wapBannerUrl': instance.wapBannerUrl,
      'iconUrl': instance.iconUrl,
      'imgUrl': instance.imgUrl,
      'level': instance.level,
      'type': instance.type,
      'categoryType': instance.categoryType,
    };
