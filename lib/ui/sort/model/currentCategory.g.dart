// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currentCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentCategory _$CurrentCategoryFromJson(Map<String, dynamic> json) {
  return CurrentCategory()
    ..id = json['id'] as num
    ..superCategoryId = json['superCategoryId'] as num
    ..showIndex = json['showIndex'] as num
    ..name = json['name'] as String
    ..frontName = json['frontName'] as String
    ..frontDesc = json['frontDesc'] as String
    ..bannerUrl = json['bannerUrl'] as String
    ..showItem = json['showItem'] == null
        ? null
        : ShowItem.fromJson(json['showItem'] as Map<String, dynamic>)
    ..bannerList = (json['bannerList'] as List)
        ?.map((e) =>
            e == null ? null : BannerItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..subCateList = (json['subCateList'] as List)
        ?.map((e) => e == null
            ? null
            : CurrentCategory.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CurrentCategoryToJson(CurrentCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'superCategoryId': instance.superCategoryId,
      'showIndex': instance.showIndex,
      'name': instance.name,
      'frontName': instance.frontName,
      'frontDesc': instance.frontDesc,
      'bannerUrl': instance.bannerUrl,
      'showItem': instance.showItem,
      'bannerList': instance.bannerList,
      'subCateList': instance.subCateList,
    };

ShowItem _$ShowItemFromJson(Map<String, dynamic> json) {
  return ShowItem()
    ..id = json['id'] as num
    ..picUrl = json['picUrl'] as String;
}

Map<String, dynamic> _$ShowItemToJson(ShowItem instance) => <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
    };
