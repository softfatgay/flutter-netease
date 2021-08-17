import 'package:json_annotation/json_annotation.dart';

part 'lookHomeDataModel.g.dart';

@JsonSerializable()
class LookHomeDataModel {
  RecModule recModule;
  NoticeInfo noticeInfo;
  String hotTabName;

  LookHomeDataModel();

  factory LookHomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$LookHomeDataModelFromJson(json);
}

@JsonSerializable()
class RecModule {
  String recommendName;
  String globalName;
  String supDoc;
  String shareImg;

  bool showTopicTab;
  String topicTagName;

  List<CollectionListItem> collectionList;

  RecModule();

  factory RecModule.fromJson(Map<String, dynamic> json) =>
      _$RecModuleFromJson(json);
}

@JsonSerializable()
class CollectionListItem {
  num id;
  String tag;
  String title;
  String subtitle;
  String picUrl;

  CollectionListItem();

  factory CollectionListItem.fromJson(Map<String, dynamic> json) =>
      _$CollectionListItemFromJson(json);
}

@JsonSerializable()
class NoticeInfo {
  String noticeTitle;
  String noticeWords;
  bool evaluateEntry;
  String buttonWords;
  String buttonWordsForAPP;
  String description;

  NoticeInfo();

  factory NoticeInfo.fromJson(Map<String, dynamic> json) =>
      _$NoticeInfoFromJson(json);
}
