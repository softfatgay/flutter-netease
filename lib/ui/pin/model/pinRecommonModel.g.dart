// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinRecommonModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinRecommonModel _$PinRecommonModelFromJson(Map<String, dynamic> json) =>
    PinRecommonModel()
      ..name = json['name'] as String?
      ..price = json['price'] as num?
      ..id = json['id'] as num?
      ..itemId = json['itemId'] as num?
      ..picUrl = json['picUrl'] as String?;

Map<String, dynamic> _$PinRecommonModelToJson(PinRecommonModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'id': instance.id,
      'itemId': instance.itemId,
      'picUrl': instance.picUrl,
    };
