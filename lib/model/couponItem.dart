import 'package:json_annotation/json_annotation.dart';

part 'couponItem.g.dart';

@JsonSerializable()
class CouponItem {
  num id;
  String name;
  String code;
  String useCondition;
  num validStartTime;
  num validEndTime;
  num cash;
  num type;
  bool usable;
  bool appOnly;
  bool newUserOnly;
  String path;
  num useTime;
  String briefDesc;
  String unit;
  bool buttonFlag;
  bool hasCoupon;
  bool albeToActivated;
  String timeDesc;

  CouponItem();

  factory CouponItem.fromJson(Map<String, dynamic> json) =>
      _$CouponItemFromJson(json);
}
