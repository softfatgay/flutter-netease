// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemTagItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemTagItem _$ItemTagItemFromJson(Map<String, dynamic> json) {
  return ItemTagItem()
    ..type = json['type'] as num
    ..subType = json['subType'] as num
    ..tagId = json['tagId'] as num
    ..itemId = json['itemId'] as num
    ..name = json['name'] as String
    ..forbidJump = json['forbidJump'] as bool
    ..freshmanExclusive = json['freshmanExclusive'] as bool;
}

Map<String, dynamic> _$ItemTagItemToJson(ItemTagItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'subType': instance.subType,
      'tagId': instance.tagId,
      'itemId': instance.itemId,
      'name': instance.name,
      'forbidJump': instance.forbidJump,
      'freshmanExclusive': instance.freshmanExclusive,
    };
