// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couponItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponItem _$CouponItemFromJson(Map<String, dynamic> json) {
  return CouponItem()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..code = json['code'] as String
    ..useCondition = json['useCondition'] as String
    ..validStartTime = json['validStartTime'] as num
    ..validEndTime = json['validEndTime'] as num
    ..cash = json['cash'] as num
    ..type = json['type'] as num
    ..usable = json['usable'] as bool
    ..appOnly = json['appOnly'] as bool
    ..newUserOnly = json['newUserOnly'] as bool
    ..path = json['path'] as String
    ..useTime = json['useTime'] as num
    ..briefDesc = json['briefDesc'] as String
    ..unit = json['unit'] as String
    ..buttonFlag = json['buttonFlag'] as bool
    ..hasCoupon = json['hasCoupon'] as bool
    ..albeToActivated = json['albeToActivated'] as bool
    ..timeDesc = json['timeDesc'] as String;
}

Map<String, dynamic> _$CouponItemToJson(CouponItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'useCondition': instance.useCondition,
      'validStartTime': instance.validStartTime,
      'validEndTime': instance.validEndTime,
      'cash': instance.cash,
      'type': instance.type,
      'usable': instance.usable,
      'appOnly': instance.appOnly,
      'newUserOnly': instance.newUserOnly,
      'path': instance.path,
      'useTime': instance.useTime,
      'briefDesc': instance.briefDesc,
      'unit': instance.unit,
      'buttonFlag': instance.buttonFlag,
      'hasCoupon': instance.hasCoupon,
      'albeToActivated': instance.albeToActivated,
      'timeDesc': instance.timeDesc,
    };
