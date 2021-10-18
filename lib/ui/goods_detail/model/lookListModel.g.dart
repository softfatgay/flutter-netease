// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookListModel _$LookListModelFromJson(Map<String, dynamic> json) =>
    LookListModel()
      ..hasMore = json['hasMore'] as bool?
      ..extra = json['extra'] == null
          ? null
          : Extra.fromJson(json['extra'] as Map<String, dynamic>)
      ..topicList = (json['topicList'] as List<dynamic>?)
          ?.map((e) => TopicListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$LookListModelToJson(LookListModel instance) =>
    <String, dynamic>{
      'hasMore': instance.hasMore,
      'extra': instance.extra,
      'topicList': instance.topicList,
    };

Extra _$ExtraFromJson(Map<String, dynamic> json) => Extra()
  ..rcmdVer = json['rcmdVer'] as String?
  ..abtest_dis = json['abtest_dis'] as String?;

Map<String, dynamic> _$ExtraToJson(Extra instance) => <String, dynamic>{
      'rcmdVer': instance.rcmdVer,
      'abtest_dis': instance.abtest_dis,
    };

TopicListItem _$TopicListItemFromJson(Map<String, dynamic> json) =>
    TopicListItem()
      ..topicId = json['topicId'] as num?
      ..type = json['type'] as num?
      ..pubType = json['pubType'] as num?
      ..readCount = json['readCount'] as num?
      ..style = json['style'] as num?
      ..schemeUrl = json['schemeUrl'] as String?
      ..nickName = json['nickName'] as String?
      ..bannerUrl = json['bannerUrl'] as String?
      ..avatar = json['avatar'] as String?
      ..title = json['title'] as String?
      ..subTitle = json['subTitle'] as String?
      ..content = json['content'] as String?
      ..picUrl = json['picUrl'] as String?
      ..hasVideo = json['hasVideo'] as bool?
      ..hasLookCollects = json['hasLookCollects'] as bool?
      ..size = json['size'] as num?
      ..duration = json['duration'] as num?
      ..supportNum = json['supportNum'] as num?
      ..supportFlag = json['supportFlag'] as bool?
      ..bannerInfo = json['bannerInfo'] == null
          ? null
          : BannerInfo.fromJson(json['bannerInfo'] as Map<String, dynamic>)
      ..isCollection = json['isCollection'] as bool?
      ..collection = json['collection'] == null
          ? null
          : Collection.fromJson(json['collection'] as Map<String, dynamic>);

Map<String, dynamic> _$TopicListItemToJson(TopicListItem instance) =>
    <String, dynamic>{
      'topicId': instance.topicId,
      'type': instance.type,
      'pubType': instance.pubType,
      'readCount': instance.readCount,
      'style': instance.style,
      'schemeUrl': instance.schemeUrl,
      'nickName': instance.nickName,
      'bannerUrl': instance.bannerUrl,
      'avatar': instance.avatar,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'content': instance.content,
      'picUrl': instance.picUrl,
      'hasVideo': instance.hasVideo,
      'hasLookCollects': instance.hasLookCollects,
      'size': instance.size,
      'duration': instance.duration,
      'supportNum': instance.supportNum,
      'supportFlag': instance.supportFlag,
      'bannerInfo': instance.bannerInfo,
      'isCollection': instance.isCollection,
      'collection': instance.collection,
    };

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection()
  ..id = json['id'] as num?
  ..tag = json['tag'] as String?
  ..title = json['title'] as String?
  ..subtitle = json['subtitle'] as String?
  ..picUrl = json['picUrl'] as String?;

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'picUrl': instance.picUrl,
    };
