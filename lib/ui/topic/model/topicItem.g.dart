// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topicItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicItem _$TopicItemFromJson(Map<String, dynamic> json) {
  return TopicItem()
    ..topicId = json['topicId'] as String
    ..type = json['type'] as num
    ..pubType = json['pubType'] as num
    ..readCount = json['readCount'] as num
    ..style = json['style'] as num
    ..schemeUrl = json['schemeUrl'] as String
    ..nickname = json['nickname'] as String
    ..avatar = json['avatar'] as String
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..picUrl = json['picUrl'] as String
    ..hasVideo = json['hasVideo'] as bool
    ..hasLookCollects = json['hasLookCollects'] as bool
    ..size = json['size'] as num
    ..duration = json['duration'] as num
    ..buyNow = json['buyNow'] == null
        ? null
        : BuyNow.fromJson(json['buyNow'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TopicItemToJson(TopicItem instance) => <String, dynamic>{
      'topicId': instance.topicId,
      'type': instance.type,
      'pubType': instance.pubType,
      'readCount': instance.readCount,
      'style': instance.style,
      'schemeUrl': instance.schemeUrl,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'picUrl': instance.picUrl,
      'hasVideo': instance.hasVideo,
      'hasLookCollects': instance.hasLookCollects,
      'size': instance.size,
      'duration': instance.duration,
      'buyNow': instance.buyNow,
    };
