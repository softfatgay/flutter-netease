import 'package:json_annotation/json_annotation.dart';

part 'getCouponModel.g.dart';

@JsonSerializable()
class GetCouponModel {
  List<CouponItem>? avalibleCouponList;
  List<CouponItem>? receiveCouponList;

  GetCouponModel();

  factory GetCouponModel.fromJson(Map<String, dynamic> json) =>
      _$GetCouponModelFromJson(json);
}

@JsonSerializable()
class CouponItem {
  num? id;
  String? name;
  String? activationCode;
  String? useCondition;
  num? validStartTime;
  num? validEndTime;
  num? type;
  bool? usable;
  bool? appOnly;
  num? newUserOnly;
  String? path;
  String? briefDesc;
  String? unit;
  num? useTime;
  bool? buttonFlag;
  bool? receiveFlag;
  num? activeMemberLevel;
  List<Item>? skuList;
  bool? isSelected;

  CouponItem();
  factory CouponItem.fromJson(Map<String, dynamic> json) =>
      _$CouponItemFromJson(json);
}

@JsonSerializable()
class Item {
  num? id;
  String? picUrl;

  Item();

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
