import 'package:flutter_app/ui/mine/model/layawayModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vipCenterModel.g.dart';

@JsonSerializable()
class VipCenterModel {
  List<MonthGiftCouponListItem>? monthGiftCouponList;
  List<PrivilegeListItem>? privilegeList;
  List<MemGrowthTasksItem>? memGrowthTasks;

  VipCenterModel();

  factory VipCenterModel.fromJson(Map<String, dynamic> json) =>
      _$VipCenterModelFromJson(json);
}

@JsonSerializable()
class MonthGiftCouponListItem {
  String? id;
  String? name;
  String? rangeName;

  num? status;
  num? validStartTime;
  num? validEndTime;
  num? validTime;
  num? validDelayTime;
  num? sortFlag;

  MonthGiftCouponListItem();

  factory MonthGiftCouponListItem.fromJson(Map<String, dynamic> json) =>
      _$MonthGiftCouponListItemFromJson(json);
}

@JsonSerializable()
class PrivilegeListItem {
  String? frontName;
  String? desc;
  num? type;
  num? rebateRate;
  num? status;
  num? userGiftId;
  num? promotionTag;
  bool? firstRecharge;
  bool? own;

  PrivilegeListItem();

  factory PrivilegeListItem.fromJson(Map<String, dynamic> json) =>
      _$PrivilegeListItemFromJson(json);
}

@JsonSerializable()
class MemGrowthTasksItem {
  num? type;
  num? status;

  MemGrowthTasksItem();

  factory MemGrowthTasksItem.fromJson(Map<String, dynamic> json) =>
      _$MemGrowthTasksItemFromJson(json);
}
