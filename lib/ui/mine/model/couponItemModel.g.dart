// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couponItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponItemModel _$CouponItemModelFromJson(Map<String, dynamic> json) =>
    CouponItemModel(
      isSelected: json['isSelected'] as bool? ?? false,
    )
      ..title = json['title'] as String?
      ..code = json['code'] as String?
      ..validStartTime = json['validStartTime'] as num?
      ..appOnly = json['appOnly'] as bool?
      ..buttonFlag = json['buttonFlag'] as bool?
      ..type = json['type'] as int?
      ..path = json['path'] as String?
      ..usable = json['usable'] as bool?
      ..unit = json['unit'] as String?
      ..hasCoupon = json['hasCoupon'] as bool?
      ..newUserOnly = json['newUserOnly'] as int?
      ..validEndTime = json['validEndTime'] as num?
      ..briefDesc = json['briefDesc'] as String?
      ..useCondition = json['useCondition'] as String?
      ..name = json['name'] as String?
      ..timeDesc = json['timeDesc'] as String?
      ..useTime = json['useTime'] as int?
      ..id = json['id'] as num?
      ..cash = (json['cash'] as num?)?.toDouble()
      ..albeToActivated = json['albeToActivated'] as bool?;

Map<String, dynamic> _$CouponItemModelToJson(CouponItemModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'code': instance.code,
      'validStartTime': instance.validStartTime,
      'appOnly': instance.appOnly,
      'buttonFlag': instance.buttonFlag,
      'type': instance.type,
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
      'id': instance.id,
      'cash': instance.cash,
      'albeToActivated': instance.albeToActivated,
      'isSelected': instance.isSelected,
    };
