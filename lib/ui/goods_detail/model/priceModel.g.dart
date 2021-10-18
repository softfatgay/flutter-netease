// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel()
  ..finalPrice = json['finalPrice'] == null
      ? null
      : FinalPrice.fromJson(json['finalPrice'] as Map<String, dynamic>)
  ..counterPrice = json['counterPrice'] as String?
  ..basicPrice = json['basicPrice'] as String?;

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'finalPrice': instance.finalPrice,
      'counterPrice': instance.counterPrice,
      'basicPrice': instance.basicPrice,
    };
