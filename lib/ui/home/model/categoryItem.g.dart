// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) {
  return CategoryItem()
    ..id = json['id'] as num
    ..superCategoryId = json['superCategoryId'] as num
    ..picUrl = json['picUrl'] as String
    ..categoryName = json['categoryName'] as String
    ..targetUrl = json['targetUrl'] as String
    ..showPicUrl = json['showPicUrl'] as String
    ..wapBannerUrl = json['wapBannerUrl'] as String
    ..name = json['name'] as String
    ..itemPicBeanList = (json['itemPicBeanList'] as List)
        ?.map((e) => e == null
            ? null
            : ItemPicBeanList.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'superCategoryId': instance.superCategoryId,
      'picUrl': instance.picUrl,
      'categoryName': instance.categoryName,
      'targetUrl': instance.targetUrl,
      'showPicUrl': instance.showPicUrl,
      'wapBannerUrl': instance.wapBannerUrl,
      'name': instance.name,
      'itemPicBeanList': instance.itemPicBeanList,
    };
