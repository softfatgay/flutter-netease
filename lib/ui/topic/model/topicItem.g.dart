// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topicItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicItem _$TopicItemFromJson(Map<String, dynamic> json) => TopicItem()
  ..topicId = json['topicId'] as String?
  ..type = json['type'] as num?
  ..pubType = json['pubType'] as num?
  ..readCount = json['readCount'] as num?
  ..style = json['style'] as num?
  ..schemeUrl = json['schemeUrl'] as String?
  ..nickname = json['nickname'] as String?
  ..bannerUrl = json['bannerUrl'] as String?
  ..avatar = json['avatar'] as String?
  ..title = json['title'] as String?
  ..subTitle = json['subTitle'] as String?
  ..picUrl = json['picUrl'] as String?
  ..newAppBanner = json['newAppBanner'] as String?
  ..hasVideo = json['hasVideo'] as bool?
  ..hasLookCollects = json['hasLookCollects'] as bool?
  ..size = json['size'] as num?
  ..duration = json['duration'] as num?
  ..supportNum = json['supportNum'] as num?
  ..appBanHeight = json['appBanHeight'] as num?
  ..appBanWidth = json['appBanWidth'] as num?
  ..newAppBannerWidth = json['newAppBannerWidth'] as num?
  ..newAppBannerHeight = json['newAppBannerHeight'] as num?
  ..supportFlag = json['supportFlag'] as bool?
  ..bannerInfo = json['bannerInfo'] == null
      ? null
      : BannerInfo.fromJson(json['bannerInfo'] as Map<String, dynamic>)
  ..buyNow = json['buyNow'] == null
      ? null
      : BuyNow.fromJson(json['buyNow'] as Map<String, dynamic>);

Map<String, dynamic> _$TopicItemToJson(TopicItem instance) => <String, dynamic>{
      'topicId': instance.topicId,
      'type': instance.type,
      'pubType': instance.pubType,
      'readCount': instance.readCount,
      'style': instance.style,
      'schemeUrl': instance.schemeUrl,
      'nickname': instance.nickname,
      'bannerUrl': instance.bannerUrl,
      'avatar': instance.avatar,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'picUrl': instance.picUrl,
      'newAppBanner': instance.newAppBanner,
      'hasVideo': instance.hasVideo,
      'hasLookCollects': instance.hasLookCollects,
      'size': instance.size,
      'duration': instance.duration,
      'supportNum': instance.supportNum,
      'appBanHeight': instance.appBanHeight,
      'appBanWidth': instance.appBanWidth,
      'newAppBannerWidth': instance.newAppBannerWidth,
      'newAppBannerHeight': instance.newAppBannerHeight,
      'supportFlag': instance.supportFlag,
      'bannerInfo': instance.bannerInfo,
      'buyNow': instance.buyNow,
    };
