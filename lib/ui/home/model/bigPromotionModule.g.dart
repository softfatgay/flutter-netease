// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bigPromotionModule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BigPromotionModule _$BigPromotionModuleFromJson(Map<String, dynamic> json) =>
    BigPromotionModule()
      ..floorList = (json['floorList'] as List<dynamic>?)
          ?.map((e) => FloorItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$BigPromotionModuleToJson(BigPromotionModule instance) =>
    <String, dynamic>{
      'floorList': instance.floorList,
    };
