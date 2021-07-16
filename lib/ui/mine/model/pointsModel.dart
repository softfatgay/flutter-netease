import 'package:json_annotation/json_annotation.dart';

part 'pointsModel.g.dart';

@JsonSerializable()
class PointsModel {
  String availablePoint;
  List<num> pointList;
  num position;
  num memLevel;
  bool signed;
  bool signReminder;
  String signBackgroundUrl;
  String goShoppingUrl;
  MemLayawayVO memLayawayVO;
  List<num> lotteryDays;
  bool hasDrawLottery;
  num lotteryCount;
  UserSimpleInfo userSimpleInfo;
  String titleOfSignTop;
  String headImg;
  String calendarBackColor;
  String actRule;
  Map<String, String> positionLotteryIconMap;
  Map<String, String> positionHasLotteryIconMap;
  bool pointsSignPushSwitch;
  PointExVirtualAct pointExVirtualAct;
  PointExVirtualAct pointExExternalRights;
  List<PonitBannersItem> ponitBanners;
  ExchangeModule exchangeModule;

  PointsModel();
  factory PointsModel.fromJson(Map<String, dynamic> json) =>
      _$PointsModelFromJson(json);
}

@JsonSerializable()
class ExchangeModule {
  String title;
  String excluTitle;
  List<PointCommoditiesItem> pointCommodities;
  List<PointCommoditiesItem> exclusiveCommodities;
  WeekPoint weekPoint;

  ExchangeModule();
  factory ExchangeModule.fromJson(Map<String, dynamic> json) =>
      _$ExchangeModuleFromJson(json);
}

@JsonSerializable()
class WeekPoint {
  String title;
  CurrentWeekPointItemVO currentWeekPointItemVO;
  CurrentWeekPointItemVO nextWeekPointItemVO;

  WeekPoint();

  factory WeekPoint.fromJson(Map<String, dynamic> json) =>
      _$WeekPointFromJson(json);
}

@JsonSerializable()
class CurrentWeekPointItemVO {
  num leftTime;
  num status;
  List<PointCommoditiesItem> pointCommodityVOList;
  String desp;

  CurrentWeekPointItemVO();

  factory CurrentWeekPointItemVO.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeekPointItemVOFromJson(json);
}

@JsonSerializable()
class PointCommoditiesItem {
  String picUrl;
  String name;
  String label;
  String needPoint;
  String originPrice;
  String itemId;
  bool sellOut;
  num sellVolume;
  num maxAvailable;
  num source;
  num exchangeTimesType;

  PointCommoditiesItem();
  factory PointCommoditiesItem.fromJson(Map<String, dynamic> json) =>
      _$PointCommoditiesItemFromJson(json);
}

@JsonSerializable()
class MemLayawayVO {
  List<LayawayListItem> layawayList;

  MemLayawayVO();
  factory MemLayawayVO.fromJson(Map<String, dynamic> json) =>
      _$MemLayawayVOFromJson(json);
}

@JsonSerializable()
class LayawayListItem {
  num id;
  String name;
  String title;
  num phaseNum;
  num retailPrice;
  num favorPrice;
  String primaryPicUrl;
  String listPicUrl;
  num point;

  LayawayListItem();
  factory LayawayListItem.fromJson(Map<String, dynamic> json) =>
      _$LayawayListItemFromJson(json);
}

@JsonSerializable()
class UserSimpleInfo {
  String userName;
  String userAvatar;
  num memberLevel;
  num userId;

  UserSimpleInfo();
  factory UserSimpleInfo.fromJson(Map<String, dynamic> json) =>
      _$UserSimpleInfoFromJson(json);
}

@JsonSerializable()
class PonitBannersItem {
  String title;
  String subtitle;
  String picUrl;
  String targetUrl;
  num startTime;
  num endTime;

  PonitBannersItem();
  factory PonitBannersItem.fromJson(Map<String, dynamic> json) =>
      _$PonitBannersItemFromJson(json);
}

@JsonSerializable()
class PointExVirtualAct {
  num actId;
  num actType;
  String actName;
  String actDesc;
  num actLimitCount;
  num actDayLimitCount;
  num beginTime;
  num endTime;
  List<ActPackets> actPackets;
  String userGroup;
  String actRuleTip;
  num createTime;

  PointExVirtualAct();

  factory PointExVirtualAct.fromJson(Map<String, dynamic> json) =>
      _$PointExVirtualActFromJson(json);
}

@JsonSerializable()
class ActPackets {
  num actPacketId;
  num actPacketType;
  String title;
  String picUrl;
  String tag;
  num needPoint;
  String actPacketGiftId;
  bool soldOut;
  num condContinueSignDays;
  num condTimesOfDayUserIdForAct;
  num condTimesOfUserIdForAct;
  num sortNum;

  ActPackets();
  factory ActPackets.fromJson(Map<String, dynamic> json) =>
      _$ActPacketsFromJson(json);
}
