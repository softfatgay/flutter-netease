// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'giftStepListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftStepListItem _$GiftStepListItemFromJson(Map<String, dynamic> json) =>
    GiftStepListItem()
      ..stepNo = json['stepNo'] as num?
      ..title = json['title'] as String?
      ..isSatisfy = json['isSatisfy'] as bool?
      ..ordered = json['ordered'] as bool?
      ..giftItemList = (json['giftItemList'] as List<dynamic>?)
          ?.map((e) => CartItemListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GiftStepListItemToJson(GiftStepListItem instance) =>
    <String, dynamic>{
      'stepNo': instance.stepNo,
      'title': instance.title,
      'isSatisfy': instance.isSatisfy,
      'ordered': instance.ordered,
      'giftItemList': instance.giftItemList,
    };
