// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookCollectionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookCollectionModel _$LookCollectionModelFromJson(Map<String, dynamic> json) =>
    LookCollectionModel()
      ..id = json['id'] as num?
      ..tag = json['tag'] as String?
      ..title = json['title'] as String?
      ..subtitle = json['subtitle'] as String?
      ..lookList = (json['lookList'] as List<dynamic>?)
          ?.map((e) => LookListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$LookCollectionModelToJson(
        LookCollectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'lookList': instance.lookList,
    };

LookListItem _$LookListItemFromJson(Map<String, dynamic> json) => LookListItem()
  ..topicId = json['topicId'] as num?
  ..schemeUrl = json['schemeUrl'] as String?
  ..avatar = json['avatar'] as String?
  ..nickName = json['nickName'] as String?
  ..content = json['content'] as String?
  ..supportFlag = json['supportFlag'] as bool?
  ..supportNum = json['supportNum'] as num?
  ..banner = json['banner'] == null
      ? null
      : BannerInfo.fromJson(json['banner'] as Map<String, dynamic>);

Map<String, dynamic> _$LookListItemToJson(LookListItem instance) =>
    <String, dynamic>{
      'topicId': instance.topicId,
      'schemeUrl': instance.schemeUrl,
      'avatar': instance.avatar,
      'nickName': instance.nickName,
      'content': instance.content,
      'supportFlag': instance.supportFlag,
      'supportNum': instance.supportNum,
      'banner': instance.banner,
    };
