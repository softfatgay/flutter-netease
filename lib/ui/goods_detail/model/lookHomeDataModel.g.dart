// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookHomeDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookHomeDataModel _$LookHomeDataModelFromJson(Map<String, dynamic> json) =>
    LookHomeDataModel()
      ..recModule = json['recModule'] == null
          ? null
          : RecModule.fromJson(json['recModule'] as Map<String, dynamic>)
      ..noticeInfo = json['noticeInfo'] == null
          ? null
          : NoticeInfo.fromJson(json['noticeInfo'] as Map<String, dynamic>)
      ..hotTabName = json['hotTabName'] as String?;

Map<String, dynamic> _$LookHomeDataModelToJson(LookHomeDataModel instance) =>
    <String, dynamic>{
      'recModule': instance.recModule,
      'noticeInfo': instance.noticeInfo,
      'hotTabName': instance.hotTabName,
    };

RecModule _$RecModuleFromJson(Map<String, dynamic> json) => RecModule()
  ..recommendName = json['recommendName'] as String?
  ..globalName = json['globalName'] as String?
  ..supDoc = json['supDoc'] as String?
  ..shareImg = json['shareImg'] as String?
  ..showTopicTab = json['showTopicTab'] as bool?
  ..topicTagName = json['topicTagName'] as String?
  ..collectionList = (json['collectionList'] as List<dynamic>?)
      ?.map((e) => CollectionListItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$RecModuleToJson(RecModule instance) => <String, dynamic>{
      'recommendName': instance.recommendName,
      'globalName': instance.globalName,
      'supDoc': instance.supDoc,
      'shareImg': instance.shareImg,
      'showTopicTab': instance.showTopicTab,
      'topicTagName': instance.topicTagName,
      'collectionList': instance.collectionList,
    };

CollectionListItem _$CollectionListItemFromJson(Map<String, dynamic> json) =>
    CollectionListItem()
      ..id = json['id'] as num?
      ..tag = json['tag'] as String?
      ..title = json['title'] as String?
      ..subtitle = json['subtitle'] as String?
      ..picUrl = json['picUrl'] as String?;

Map<String, dynamic> _$CollectionListItemToJson(CollectionListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'picUrl': instance.picUrl,
    };

NoticeInfo _$NoticeInfoFromJson(Map<String, dynamic> json) => NoticeInfo()
  ..noticeTitle = json['noticeTitle'] as String?
  ..noticeWords = json['noticeWords'] as String?
  ..evaluateEntry = json['evaluateEntry'] as bool?
  ..buttonWords = json['buttonWords'] as String?
  ..buttonWordsForAPP = json['buttonWordsForAPP'] as String?
  ..description = json['description'] as String?;

Map<String, dynamic> _$NoticeInfoToJson(NoticeInfo instance) =>
    <String, dynamic>{
      'noticeTitle': instance.noticeTitle,
      'noticeWords': instance.noticeWords,
      'evaluateEntry': instance.evaluateEntry,
      'buttonWords': instance.buttonWords,
      'buttonWordsForAPP': instance.buttonWordsForAPP,
      'description': instance.description,
    };
