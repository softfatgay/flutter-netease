import 'package:json_annotation/json_annotation.dart';

part 'hdrkDetailVOListItem.g.dart';

@JsonSerializable()
class HdrkDetailVOListItem {
  num id;
  String name;
  String activityType;
  String huodongUrlWap;
  num startTime;
  num endTime;
  num promotionType;
  bool canUseCoupon;

  HdrkDetailVOListItem();

  factory HdrkDetailVOListItem.fromJson(Map<String, dynamic> json) =>
      _$HdrkDetailVOListItemFromJson(json);
}
