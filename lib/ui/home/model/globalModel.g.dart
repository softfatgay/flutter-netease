// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'globalModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalModel _$GlobalModelFromJson(Map<String, dynamic> json) => GlobalModel()
  ..environment = json['environment'] as String?
  ..nickname = json['nickname'] as String?
  ..username = json['username'] as String?
  ..userid = json['userid'] as String?
  ..cateList = (json['cateList'] as List<dynamic>?)
      ?.map((e) => CateListItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$GlobalModelToJson(GlobalModel instance) =>
    <String, dynamic>{
      'environment': instance.environment,
      'nickname': instance.nickname,
      'username': instance.username,
      'userid': instance.userid,
      'cateList': instance.cateList,
    };

CateListItem _$CateListItemFromJson(Map<String, dynamic> json) => CateListItem()
  ..id = json['id'] as num?
  ..superCategoryId = json['superCategoryId'] as num?
  ..showIndex = json['showIndex'] as num?
  ..name = json['name'] as String?
  ..imgUrl = json['imgUrl'] as String?
  ..type = json['type'] as num?
  ..categoryType = json['categoryType'] as num?;

Map<String, dynamic> _$CateListItemToJson(CateListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'superCategoryId': instance.superCategoryId,
      'showIndex': instance.showIndex,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'type': instance.type,
      'categoryType': instance.categoryType,
    };
