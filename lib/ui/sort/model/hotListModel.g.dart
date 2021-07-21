// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotListModel _$HotListModelFromJson(Map<String, dynamic> json) {
  return HotListModel()
    ..currentCategory = json['currentCategory'] == null
        ? null
        : CurrentCategory.fromJson(
            json['currentCategory'] as Map<String, dynamic>)
    ..moreCategories = (json['moreCategories'] as List)
        ?.map((e) => e == null
            ? null
            : CurrentCategory.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HotListModelToJson(HotListModel instance) =>
    <String, dynamic>{
      'currentCategory': instance.currentCategory,
      'moreCategories': instance.moreCategories,
    };
