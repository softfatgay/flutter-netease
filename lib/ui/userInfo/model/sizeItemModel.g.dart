// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sizeItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeItemModel _$SizeItemModelFromJson(Map<String, dynamic> json) {
  return SizeItemModel()
    ..hipCircumference = json['hipCircumference'] as num
    ..footLength = json['footLength'] as num
    ..gender = json['gender'] as num
    ..footCircumference = json['footCircumference'] as num
    ..waistCircumference = json['waistCircumference'] as num
    ..shoulderBreadth = json['shoulderBreadth'] as num
    ..dft = json['dft'] as bool
    ..roleName = json['roleName'] as String
    ..bust = json['bust'] as num
    ..underBust = json['underBust'] as num
    ..id = json['id'] as num
    ..bodyWeight = json['bodyWeight'] as num
    ..height = json['height'] as num;
}

Map<String, dynamic> _$SizeItemModelToJson(SizeItemModel instance) =>
    <String, dynamic>{
      'hipCircumference': instance.hipCircumference,
      'footLength': instance.footLength,
      'gender': instance.gender,
      'footCircumference': instance.footCircumference,
      'waistCircumference': instance.waistCircumference,
      'shoulderBreadth': instance.shoulderBreadth,
      'dft': instance.dft,
      'roleName': instance.roleName,
      'bust': instance.bust,
      'underBust': instance.underBust,
      'id': instance.id,
      'bodyWeight': instance.bodyWeight,
      'height': instance.height,
    };
