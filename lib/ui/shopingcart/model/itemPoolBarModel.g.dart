// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemPoolBarModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemPoolBarModel _$ItemPoolBarModelFromJson(Map<String, dynamic> json) {
  return ItemPoolBarModel(
    json['subtotalPrice'] as num,
    json['promTip'] as String,
  );
}

Map<String, dynamic> _$ItemPoolBarModelToJson(ItemPoolBarModel instance) =>
    <String, dynamic>{
      'subtotalPrice': instance.subtotalPrice,
      'promTip': instance.promTip,
    };
