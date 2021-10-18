// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemTagListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemTagListItem _$ItemTagListItemFromJson(Map<String, dynamic> json) =>
    ItemTagListItem()
      ..type = json['type'] as num?
      ..subType = json['subType'] as num?
      ..tagId = json['tagId'] as num?
      ..itemId = json['itemId'] as num?
      ..name = json['name'] as String?
      ..forbidJump = json['forbidJump'] as bool?
      ..freshmanExclusive = json['freshmanExclusive'] as bool?;

Map<String, dynamic> _$ItemTagListItemToJson(ItemTagListItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'subType': instance.subType,
      'tagId': instance.tagId,
      'itemId': instance.itemId,
      'name': instance.name,
      'forbidJump': instance.forbidJump,
      'freshmanExclusive': instance.freshmanExclusive,
    };
