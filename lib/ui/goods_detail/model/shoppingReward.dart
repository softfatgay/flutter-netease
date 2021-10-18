
import 'package:json_annotation/json_annotation.dart';

part 'shoppingReward.g.dart';

@JsonSerializable()
class ShoppingReward {
  String? name;
  String? rewardDesc;
  String? rewardValue;

  ShoppingReward();

  factory ShoppingReward.fromJson(Map<String, dynamic> json) =>
      _$ShoppingRewardFromJson(json);
}