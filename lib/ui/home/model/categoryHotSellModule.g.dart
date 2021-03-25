// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryHotSellModule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryHotSellModule _$CategoryHotSellModuleFromJson(
    Map<String, dynamic> json) {
  return CategoryHotSellModule()
    ..titleTargetUrl = json['titleTargetUrl'] as String
    ..title = json['title'] as String
    ..categoryList = (json['categoryList'] as List)
        ?.map((e) =>
            e == null ? null : CategoryItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CategoryHotSellModuleToJson(
        CategoryHotSellModule instance) =>
    <String, dynamic>{
      'titleTargetUrl': instance.titleTargetUrl,
      'title': instance.title,
      'categoryList': instance.categoryList,
    };
