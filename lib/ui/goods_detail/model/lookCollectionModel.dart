import 'package:flutter_app/ui/goods_detail/model/bannerInfo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lookCollectionModel.g.dart';

@JsonSerializable()
class LookCollectionModel {
  num id;
  String tag;
  String title;
  String subtitle;
  List<LookListItem> lookList;

  LookCollectionModel();

  factory LookCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$LookCollectionModelFromJson(json);
}

@JsonSerializable()
class LookListItem {
  num topicId;
  String schemeUrl;
  String avatar;
  String nickName;
  String content;
  bool supportFlag;
  num supportNum;
  BannerInfo banner;

  LookListItem();
  factory LookListItem.fromJson(Map<String, dynamic> json) =>
      _$LookListItemFromJson(json);
}
