// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoppingReward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingReward _$ShoppingRewardFromJson(Map<String, dynamic> json) {
  return ShoppingReward()
    ..name = json['name'] as String
    ..rewardDesc = json['rewardDesc'] as String
    ..rewardValue = json['rewardValue'] as String;
}

Map<String, dynamic> _$ShoppingRewardToJson(ShoppingReward instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rewardDesc': instance.rewardDesc,
      'rewardValue': instance.rewardValue,
    };
