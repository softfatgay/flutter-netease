// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subCateListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCateListItem _$SubCateListItemFromJson(Map<String, dynamic> json) {
  return SubCateListItem()
    ..id = json['id'] as num
    ..superCategoryId = json['superCategoryId'] as num
    ..showIndex = json['showIndex'] as num
    ..name = json['name'] as String
    ..frontName = json['frontName'] as String
    ..frontDesc = json['frontDesc'] as String
    ..bannerUrl = json['bannerUrl'] as String;
}

Map<String, dynamic> _$SubCateListItemToJson(SubCateListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'superCategoryId': instance.superCategoryId,
      'showIndex': instance.showIndex,
      'name': instance.name,
      'frontName': instance.frontName,
      'frontDesc': instance.frontDesc,
      'bannerUrl': instance.bannerUrl,
    };
