import 'package:json_annotation/json_annotation.dart';

part 'policyDescItem.g.dart';

@JsonSerializable()
class PolicyDescItem {
  String icon;
  String schemeUrl;
  String desc;

  PolicyDescItem();

  factory PolicyDescItem.fromJson(Map<String, dynamic> json) =>
      _$PolicyDescItemFromJson(json);
}
