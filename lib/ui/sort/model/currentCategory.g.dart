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
    ..bannerList = (json['bannerList'] as List)
        ?.map((e) =>
            e == null ? null : BannerItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CurrentCategoryToJson(CurrentCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'superCategoryId': instance.superCategoryId,
      'showIndex': instance.showIndex,
      'name': instance.name,
      'bannerList': instance.bannerList,
    };
