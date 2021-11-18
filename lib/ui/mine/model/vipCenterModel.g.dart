// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vipCenterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VipCenterModel _$VipCenterModelFromJson(Map<String, dynamic> json) =>
    VipCenterModel()
      ..monthGiftCouponList = (json['monthGiftCouponList'] as List<dynamic>?)
          ?.map((e) =>
              MonthGiftCouponListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..privilegeList = (json['privilegeList'] as List<dynamic>?)
          ?.map((e) => PrivilegeListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..memGrowthTasks = (json['memGrowthTasks'] as List<dynamic>?)
          ?.map((e) => MemGrowthTasksItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$VipCenterModelToJson(VipCenterModel instance) =>
    <String, dynamic>{
      'monthGiftCouponList': instance.monthGiftCouponList,
      'privilegeList': instance.privilegeList,
      'memGrowthTasks': instance.memGrowthTasks,
    };

MonthGiftCouponListItem _$MonthGiftCouponListItemFromJson(
        Map<String, dynamic> json) =>
    MonthGiftCouponListItem()
      ..id = json['id'] as String?
      ..name = json['name'] as String?
      ..rangeName = json['rangeName'] as String?
      ..status = json['status'] as num?
      ..validStartTime = json['validStartTime'] as num?
      ..validEndTime = json['validEndTime'] as num?
      ..validTime = json['validTime'] as num?
      ..validDelayTime = json['validDelayTime'] as num?
      ..sortFlag = json['sortFlag'] as num?;

Map<String, dynamic> _$MonthGiftCouponListItemToJson(
        MonthGiftCouponListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rangeName': instance.rangeName,
      'status': instance.status,
      'validStartTime': instance.validStartTime,
      'validEndTime': instance.validEndTime,
      'validTime': instance.validTime,
      'validDelayTime': instance.validDelayTime,
      'sortFlag': instance.sortFlag,
    };

PrivilegeListItem _$PrivilegeListItemFromJson(Map<String, dynamic> json) =>
    PrivilegeListItem()
      ..frontName = json['frontName'] as String?
      ..desc = json['desc'] as String?
      ..type = json['type'] as num?
      ..rebateRate = json['rebateRate'] as num?
      ..status = json['status'] as num?
      ..userGiftId = json['userGiftId'] as num?
      ..promotionTag = json['promotionTag'] as num?
      ..firstRecharge = json['firstRecharge'] as bool?
      ..own = json['own'] as bool?;

Map<String, dynamic> _$PrivilegeListItemToJson(PrivilegeListItem instance) =>
    <String, dynamic>{
      'frontName': instance.frontName,
      'desc': instance.desc,
      'type': instance.type,
      'rebateRate': instance.rebateRate,
      'status': instance.status,
      'userGiftId': instance.userGiftId,
      'promotionTag': instance.promotionTag,
      'firstRecharge': instance.firstRecharge,
      'own': instance.own,
    };

MemGrowthTasksItem _$MemGrowthTasksItemFromJson(Map<String, dynamic> json) =>
    MemGrowthTasksItem()
      ..type = json['type'] as num?
      ..status = json['status'] as num?;

Map<String, dynamic> _$MemGrowthTasksItemToJson(MemGrowthTasksItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'status': instance.status,
    };
