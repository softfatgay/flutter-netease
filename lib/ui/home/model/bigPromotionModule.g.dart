// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bigPromotionModule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BigPromotionModule _$BigPromotionModuleFromJson(Map<String, dynamic> json) {
  return BigPromotionModule()
    ..floorList = (json['floorList'] as List)
        ?.map((e) =>
            e == null ? null : FloorItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BigPromotionModuleToJson(BigPromotionModule instance) =>
    <String, dynamic>{
      'floorList': instance.floorList,
    };
