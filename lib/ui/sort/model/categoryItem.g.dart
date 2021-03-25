// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) {
  return CategoryItem()
    ..id = json['id'] as num
    ..superCategoryId = json['superCategoryId'] as num
    ..showIndex = json['showIndex'] as num
    ..name = json['name'] as String
    ..bannerUrl = json['bannerUrl'] as String
    ..wapBannerUrl = json['wapBannerUrl'] as String;
}

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'superCategoryId': instance.superCategoryId,
      'showIndex': instance.showIndex,
      'name': instance.name,
      'bannerUrl': instance.bannerUrl,
      'wapBannerUrl': instance.wapBannerUrl,
    };
