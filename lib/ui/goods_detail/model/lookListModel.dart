import 'package:flutter_app/ui/goods_detail/model/bannerInfo.dart';
import 'package:flutter_app/ui/topic/model/topicItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lookListModel.g.dart';

@JsonSerializable()
class LookListModel {
  bool? hasMore;
  Extra? extra;
  List<TopicListItem>? topicList;

  LookListModel();

  factory LookListModel.fromJson(Map<String, dynamic> json) =>
      _$LookListModelFromJson(json);
}

@JsonSerializable()
class Extra {
  String? rcmdVer;
  String? abtest_dis;

  Extra();

  factory Extra.fromJson(Map<String, dynamic> json) => _$ExtraFromJson(json);
}

@JsonSerializable()
class TopicListItem {
  num? topicId;
  num? type;
  num? pubType;
  num? readCount;
  num? style;
  String? schemeUrl;
  String? nickName;
  String? bannerUrl;
  String? avatar;
  String? title;
  String? subTitle;
  String? content;
  String? picUrl;
  bool? hasVideo;
  bool? hasLookCollects;
  num? size;
  num? duration;
  num? supportNum;
  bool? supportFlag;
  BannerInfo? bannerInfo;
  bool? isCollection;
  Collection? collection;

  TopicListItem();

  factory TopicListItem.fromJson(Map<String, dynamic> json) =>
      _$TopicListItemFromJson(json);
}

@JsonSerializable()
class Collection {
  num? id;
  String? tag;
  String? title;
  String? subtitle;
  String? picUrl;

  Collection();

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
}
