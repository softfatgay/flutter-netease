import 'package:json_annotation/json_annotation.dart';

part 'couponItemModel.g.dart';

@JsonSerializable()
class CouponItemModel {
  String title;
  String code;
  num validStartTime;
  bool appOnly;
  bool buttonFlag;
  int type;
  String path;
  bool usable;
  String unit;
  bool hasCoupon;
  int newUserOnly;
  num validEndTime;
  String briefDesc;
  String useCondition;
  String name;
  String timeDesc;
  int useTime;
  num id;
  double cash;
  bool albeToActivated;
  bool isSelected;

  CouponItemModel({this.isSelected = false});

  factory CouponItemModel.fromJson(Map<String, dynamic> json) =>
      _$CouponItemModelFromJson(json);
}
