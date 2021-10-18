// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couponModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) => CouponModel()
  ..code = json['code'] as String?
  ..validStartTime = json['validStartTime'] as num?
  ..couponItemPath = json['couponItemPath'] as String?
  ..appOnly = json['appOnly'] as bool?
  ..buttonFlag = json['buttonFlag'] as bool?
  ..type = json['type'] as num?
  ..baseActiveNewUserOnly = json['baseActiveNewUserOnly'] as num?
  ..path = json['path'] as String?
  ..usable = json['usable'] as bool?
  ..unit = json['unit'] as String?
  ..hasCoupon = json['hasCoupon'] as bool?
  ..newUserOnly = json['newUserOnly'] as num?
  ..validEndTime = json['validEndTime'] as num?
  ..briefDesc = json['briefDesc'] as String?
  ..useCondition = json['useCondition'] as String?
  ..name = json['name'] as String?
  ..timeDesc = json['timeDesc'] as String?
  ..useTime = json['useTime'] as num?
  ..activationCode = json['activationCode'] as String?
  ..id = json['id'] as num?
  ..albeToActivated = json['albeToActivated'] as bool?
  ..isSelected = json['isSelected'] as bool?;

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'validStartTime': instance.validStartTime,
      'couponItemPath': instance.couponItemPath,
      'appOnly': instance.appOnly,
      'buttonFlag': instance.buttonFlag,
      'type': instance.type,
      'baseActiveNewUserOnly': instance.baseActiveNewUserOnly,
      'path': instance.path,
      'usable': instance.usable,
      'unit': instance.unit,
      'hasCoupon': instance.hasCoupon,
      'newUserOnly': instance.newUserOnly,
      'validEndTime': instance.validEndTime,
      'briefDesc': instance.briefDesc,
      'useCondition': instance.useCondition,
      'name': instance.name,
      'timeDesc': instance.timeDesc,
      'useTime': instance.useTime,
      'activationCode': instance.activationCode,
      'id': instance.id,
      'albeToActivated': instance.albeToActivated,
      'isSelected': instance.isSelected,
    };
