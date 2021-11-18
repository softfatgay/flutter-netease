// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vipCenterIndexModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VipCenterIndexModel _$VipCenterIndexModelFromJson(Map<String, dynamic> json) =>
    VipCenterIndexModel()
      ..nickname = json['nickname'] as String?
      ..avatarUrl = json['avatarUrl'] as String?
      ..points = json['points'] as num?
      ..memLayawayVO = json['memLayawayVO'] == null
          ? null
          : MemLayawayVO.fromJson(json['memLayawayVO'] as Map<String, dynamic>)
      ..memRankMetaVO = json['memRankMetaVO'] == null
          ? null
          : MemRankMetaVO.fromJson(
              json['memRankMetaVO'] as Map<String, dynamic>)
      ..upgradeInfo = json['upgradeInfo'] == null
          ? null
          : UpgradeInfo.fromJson(json['upgradeInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$VipCenterIndexModelToJson(
        VipCenterIndexModel instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'points': instance.points,
      'memLayawayVO': instance.memLayawayVO,
      'memRankMetaVO': instance.memRankMetaVO,
      'upgradeInfo': instance.upgradeInfo,
    };

MemLayawayVO _$MemLayawayVOFromJson(Map<String, dynamic> json) => MemLayawayVO()
  ..layawayList = (json['layawayList'] as List<dynamic>?)
      ?.map((e) => LayawayModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MemLayawayVOToJson(MemLayawayVO instance) =>
    <String, dynamic>{
      'layawayList': instance.layawayList,
    };

MemRankMetaVO _$MemRankMetaVOFromJson(Map<String, dynamic> json) =>
    MemRankMetaVO()
      ..levelName = json['levelName'] as String?
      ..level = json['level'] as num?
      ..score = json['score'] as num?
      ..upgradeThreshold = json['upgradeThreshold'] as num?
      ..diffToNextLevel = json['diffToNextLevel'] as num?
      ..monthScoreList = (json['monthScoreList'] as List<dynamic>?)
          ?.map((e) => MonthScoreListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MemRankMetaVOToJson(MemRankMetaVO instance) =>
    <String, dynamic>{
      'levelName': instance.levelName,
      'level': instance.level,
      'score': instance.score,
      'upgradeThreshold': instance.upgradeThreshold,
      'diffToNextLevel': instance.diffToNextLevel,
      'monthScoreList': instance.monthScoreList,
    };

MonthScoreListItem _$MonthScoreListItemFromJson(Map<String, dynamic> json) =>
    MonthScoreListItem()
      ..score = json['score'] as num?
      ..startDate = json['startDate'] as num?
      ..endDate = json['endDate'] as num?;

Map<String, dynamic> _$MonthScoreListItemToJson(MonthScoreListItem instance) =>
    <String, dynamic>{
      'score': instance.score,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

UpgradeInfo _$UpgradeInfoFromJson(Map<String, dynamic> json) => UpgradeInfo()
  ..level = json['level'] as num?
  ..title = json['title'] as String?
  ..desc = json['desc'] as String?;

Map<String, dynamic> _$UpgradeInfoToJson(UpgradeInfo instance) =>
    <String, dynamic>{
      'level': instance.level,
      'title': instance.title,
      'desc': instance.desc,
    };
