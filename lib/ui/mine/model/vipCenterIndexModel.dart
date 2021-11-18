import 'package:flutter_app/ui/mine/model/layawayModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vipCenterIndexModel.g.dart';

@JsonSerializable()
class VipCenterIndexModel {
  String? nickname;
  String? avatarUrl;
  num? points;
  MemLayawayVO? memLayawayVO;
  MemRankMetaVO? memRankMetaVO;

  UpgradeInfo? upgradeInfo;

  VipCenterIndexModel();

  factory VipCenterIndexModel.fromJson(Map<String, dynamic> json) =>
      _$VipCenterIndexModelFromJson(json);
}

@JsonSerializable()
class MemLayawayVO {
  List<LayawayModel>? layawayList;

  MemLayawayVO();

  factory MemLayawayVO.fromJson(Map<String, dynamic> json) =>
      _$MemLayawayVOFromJson(json);
}

@JsonSerializable()
class MemRankMetaVO {
  String? levelName;
  num? level;
  num? score;
  num? upgradeThreshold;
  num? diffToNextLevel;

  List<MonthScoreListItem>? monthScoreList;

  MemRankMetaVO();

  factory MemRankMetaVO.fromJson(Map<String, dynamic> json) =>
      _$MemRankMetaVOFromJson(json);
}

@JsonSerializable()
class MonthScoreListItem {
  num? score;
  num? startDate;
  num? endDate;

  MonthScoreListItem();

  factory MonthScoreListItem.fromJson(Map<String, dynamic> json) =>
      _$MonthScoreListItemFromJson(json);
}

@JsonSerializable()
class UpgradeInfo {
  num? level;
  String? title;
  String? desc;

  UpgradeInfo();

  factory UpgradeInfo.fromJson(Map<String, dynamic> json) =>
      _$UpgradeInfoFromJson(json);
}
