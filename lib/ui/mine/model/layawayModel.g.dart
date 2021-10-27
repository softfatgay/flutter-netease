// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layawayModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayawayModel _$LayawayModelFromJson(Map<String, dynamic> json) => LayawayModel()
  ..id = json['id'] as num?
  ..name = json['name'] as String?
  ..title = json['title'] as String?
  ..phaseNum = json['phaseNum'] as num?
  ..retailPrice = json['retailPrice'] as num?
  ..favorPrice = json['favorPrice'] as num?
  ..primaryPicUrl = json['primaryPicUrl'] as String?
  ..listPicUrl = json['listPicUrl'] as String?
  ..point = json['point'] as num?;

Map<String, dynamic> _$LayawayModelToJson(LayawayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'phaseNum': instance.phaseNum,
      'retailPrice': instance.retailPrice,
      'favorPrice': instance.favorPrice,
      'primaryPicUrl': instance.primaryPicUrl,
      'listPicUrl': instance.listPicUrl,
      'point': instance.point,
    };
