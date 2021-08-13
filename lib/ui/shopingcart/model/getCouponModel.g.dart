// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getCouponModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCouponModel _$GetCouponModelFromJson(Map<String, dynamic> json) {
  return GetCouponModel()
    ..avalibleCouponList = (json['avalibleCouponList'] as List)
        ?.map((e) =>
            e == null ? null : CouponItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..receiveCouponList = (json['receiveCouponList'] as List)
        ?.map((e) =>
            e == null ? null : CouponItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GetCouponModelToJson(GetCouponModel instance) =>
    <String, dynamic>{
      'avalibleCouponList': instance.avalibleCouponList,
      'receiveCouponList': instance.receiveCouponList,
    };

CouponItem _$CouponItemFromJson(Map<String, dynamic> json) {
  return CouponItem()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..activationCode = json['activationCode'] as String
    ..useCondition = json['useCondition'] as String
    ..validStartTime = json['validStartTime'] as num
    ..validEndTime = json['validEndTime'] as num
    ..type = json['type'] as num
    ..usable = json['usable'] as bool
    ..appOnly = json['appOnly'] as bool
    ..newUserOnly = json['newUserOnly'] as num
    ..path = json['path'] as String
    ..briefDesc = json['briefDesc'] as String
    ..unit = json['unit'] as String
    ..useTime = json['useTime'] as num
    ..buttonFlag = json['buttonFlag'] as bool
    ..receiveFlag = json['receiveFlag'] as bool
    ..activeMemberLevel = json['activeMemberLevel'] as num
    ..skuList = (json['skuList'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..isSelected = json['isSelected'] as bool;
}

Map<String, dynamic> _$CouponItemToJson(CouponItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'activationCode': instance.activationCode,
      'useCondition': instance.useCondition,
      'validStartTime': instance.validStartTime,
      'validEndTime': instance.validEndTime,
      'type': instance.type,
      'usable': instance.usable,
      'appOnly': instance.appOnly,
      'newUserOnly': instance.newUserOnly,
      'path': instance.path,
      'briefDesc': instance.briefDesc,
      'unit': instance.unit,
      'useTime': instance.useTime,
      'buttonFlag': instance.buttonFlag,
      'receiveFlag': instance.receiveFlag,
      'activeMemberLevel': instance.activeMemberLevel,
      'skuList': instance.skuList,
      'isSelected': instance.isSelected,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item()
    ..id = json['id'] as num
    ..picUrl = json['picUrl'] as String;
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
    };
