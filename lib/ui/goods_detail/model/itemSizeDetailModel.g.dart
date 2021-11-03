// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemSizeDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemSizeDetailModel _$ItemSizeDetailModelFromJson(Map<String, dynamic> json) =>
    ItemSizeDetailModel()
      ..name = json['name'] as String?
      ..remarks = json['remarks'] as String?
      ..roleName = json['roleName'] as String?
      ..itemSizeValueList = (json['itemSizeValueList'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList()
      ..roleSizeValueList = (json['roleSizeValueList'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList()
      ..roleList = (json['roleList'] as List<dynamic>?)
          ?.map((e) => SizeItemModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..roleSizeComplete = json['roleSizeComplete'] as bool?
      ..recommendIndex = json['recommendIndex'] as num?;

Map<String, dynamic> _$ItemSizeDetailModelToJson(
        ItemSizeDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'remarks': instance.remarks,
      'roleName': instance.roleName,
      'itemSizeValueList': instance.itemSizeValueList,
      'roleSizeValueList': instance.roleSizeValueList,
      'roleList': instance.roleList,
      'roleSizeComplete': instance.roleSizeComplete,
      'recommendIndex': instance.recommendIndex,
    };
