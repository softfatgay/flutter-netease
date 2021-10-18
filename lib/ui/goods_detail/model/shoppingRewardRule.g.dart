// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoppingRewardRule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingRewardRule _$ShoppingRewardRuleFromJson(Map<String, dynamic> json) =>
    ShoppingRewardRule()
      ..title = json['title'] as String?
      ..ruleList = (json['ruleList'] as List<dynamic>?)
          ?.map((e) => PolicyListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ShoppingRewardRuleToJson(ShoppingRewardRule instance) =>
    <String, dynamic>{
      'title': instance.title,
      'ruleList': instance.ruleList,
    };

RuleListItem _$RuleListItemFromJson(Map<String, dynamic> json) => RuleListItem()
  ..title = json['title'] as String?
  ..content = json['content'] as String?;

Map<String, dynamic> _$RuleListItemToJson(RuleListItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };
