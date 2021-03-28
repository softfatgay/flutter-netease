import 'package:flutter_app/ui/goodsDetail/model/skuMapValue.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shoppingRewardRule.g.dart';

@JsonSerializable()
class ShoppingRewardRule {
  String title;
  List<PolicyListItem> ruleList;

  ShoppingRewardRule();

  factory ShoppingRewardRule.fromJson(Map<String, dynamic> json) =>
      _$ShoppingRewardRuleFromJson(json);
}

@JsonSerializable()
class RuleListItem {
  String title;
  String content;

  RuleListItem();

  factory RuleListItem.fromJson(Map<String, dynamic> json) =>
      _$RuleListItemFromJson(json);
}
