import 'package:json_annotation/json_annotation.dart';

part 'couponModel.g.dart';

@JsonSerializable()
class CouponModel {
  String? code;
  num? validStartTime;
  String? couponItemPath;
  bool? appOnly;
  bool? buttonFlag;
  num? type;
  num? baseActiveNewUserOnly;
  String? path;
  bool? usable;
  String? unit;
  bool? hasCoupon;
  num? newUserOnly;
  num? validEndTime;
  String? briefDesc;
  String? useCondition;
  String? name;
  String? timeDesc;
  num? useTime;
  String? activationCode;
  num? id;
  bool? albeToActivated;
  bool? isSelected;

  CouponModel();

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
}
