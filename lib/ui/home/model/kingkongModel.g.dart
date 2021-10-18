// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kingkongModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KingkongModel _$KingkongModelFromJson(Map<String, dynamic> json) =>
    KingkongModel()
      ..currentCategory = json['currentCategory'] == null
          ? null
          : Category.fromJson(json['currentCategory'] as Map<String, dynamic>)
      ..categoryItemList = (json['categoryItemList'] as List<dynamic>?)
          ?.map((e) => CategoryItemListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$KingkongModelToJson(KingkongModel instance) =>
    <String, dynamic>{
      'currentCategory': instance.currentCategory,
      'categoryItemList': instance.categoryItemList,
    };
