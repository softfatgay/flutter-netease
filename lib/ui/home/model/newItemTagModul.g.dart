// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newItemTagModul.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewItemTagModel _$NewItemTagModelFromJson(Map<String, dynamic> json) =>
    NewItemTagModel()
      ..itemId = json['itemId'] as num?
      ..tagId = json['tagId'] as num?
      ..freshmanExclusive = json['freshmanExclusive'] as bool?
      ..forbidJump = json['forbidJump'] as bool?
      ..name = json['name'] as String?
      ..subType = json['subType'] as num?
      ..type = json['type'] as num?;

Map<String, dynamic> _$NewItemTagModelToJson(NewItemTagModel instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'tagId': instance.tagId,
      'freshmanExclusive': instance.freshmanExclusive,
      'forbidJump': instance.forbidJump,
      'name': instance.name,
      'subType': instance.subType,
      'type': instance.type,
    };
