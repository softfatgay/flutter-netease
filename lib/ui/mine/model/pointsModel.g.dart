// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pointsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsModel _$PointsModelFromJson(Map<String, dynamic> json) {
  return PointsModel()
    ..availablePoint = json['availablePoint'] as String
    ..pointList = (json['pointList'] as List)?.map((e) => e as num)?.toList()
    ..position = json['position'] as num
    ..memLevel = json['memLevel'] as num
    ..signed = json['signed'] as bool
    ..signReminder = json['signReminder'] as bool
    ..signBackgroundUrl = json['signBackgroundUrl'] as String
    ..goShoppingUrl = json['goShoppingUrl'] as String
    ..memLayawayVO = json['memLayawayVO'] == null
        ? null
        : MemLayawayVO.fromJson(json['memLayawayVO'] as Map<String, dynamic>)
    ..lotteryDays =
        (json['lotteryDays'] as List)?.map((e) => e as num)?.toList()
    ..hasDrawLottery = json['hasDrawLottery'] as bool
    ..lotteryCount = json['lotteryCount'] as num
    ..userSimpleInfo = json['userSimpleInfo'] == null
        ? null
        : UserSimpleInfo.fromJson(
            json['userSimpleInfo'] as Map<String, dynamic>)
    ..titleOfSignTop = json['titleOfSignTop'] as String
    ..headImg = json['headImg'] as String
    ..calendarBackColor = json['calendarBackColor'] as String
    ..actRule = json['actRule'] as String
    ..positionLotteryIconMap =
        (json['positionLotteryIconMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    )
    ..positionHasLotteryIconMap =
        (json['positionHasLotteryIconMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    )
    ..pointsSignPushSwitch = json['pointsSignPushSwitch'] as bool
    ..pointExVirtualAct = json['pointExVirtualAct'] == null
        ? null
        : PointExVirtualAct.fromJson(
            json['pointExVirtualAct'] as Map<String, dynamic>)
    ..pointExExternalRights = json['pointExExternalRights'] == null
        ? null
        : PointExVirtualAct.fromJson(
            json['pointExExternalRights'] as Map<String, dynamic>)
    ..ponitBanners = (json['ponitBanners'] as List)
        ?.map((e) => e == null
            ? null
            : PonitBannersItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..exchangeModule = json['exchangeModule'] == null
        ? null
        : ExchangeModule.fromJson(
            json['exchangeModule'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PointsModelToJson(PointsModel instance) =>
    <String, dynamic>{
      'availablePoint': instance.availablePoint,
      'pointList': instance.pointList,
      'position': instance.position,
      'memLevel': instance.memLevel,
      'signed': instance.signed,
      'signReminder': instance.signReminder,
      'signBackgroundUrl': instance.signBackgroundUrl,
      'goShoppingUrl': instance.goShoppingUrl,
      'memLayawayVO': instance.memLayawayVO,
      'lotteryDays': instance.lotteryDays,
      'hasDrawLottery': instance.hasDrawLottery,
      'lotteryCount': instance.lotteryCount,
      'userSimpleInfo': instance.userSimpleInfo,
      'titleOfSignTop': instance.titleOfSignTop,
      'headImg': instance.headImg,
      'calendarBackColor': instance.calendarBackColor,
      'actRule': instance.actRule,
      'positionLotteryIconMap': instance.positionLotteryIconMap,
      'positionHasLotteryIconMap': instance.positionHasLotteryIconMap,
      'pointsSignPushSwitch': instance.pointsSignPushSwitch,
      'pointExVirtualAct': instance.pointExVirtualAct,
      'pointExExternalRights': instance.pointExExternalRights,
      'ponitBanners': instance.ponitBanners,
      'exchangeModule': instance.exchangeModule,
    };

ExchangeModule _$ExchangeModuleFromJson(Map<String, dynamic> json) {
  return ExchangeModule()
    ..title = json['title'] as String
    ..excluTitle = json['excluTitle'] as String
    ..pointCommodities = (json['pointCommodities'] as List)
        ?.map((e) => e == null
            ? null
            : PointCommoditiesItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..exclusiveCommodities = (json['exclusiveCommodities'] as List)
        ?.map((e) => e == null
            ? null
            : PointCommoditiesItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..weekPoint = json['weekPoint'] == null
        ? null
        : WeekPoint.fromJson(json['weekPoint'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ExchangeModuleToJson(ExchangeModule instance) =>
    <String, dynamic>{
      'title': instance.title,
      'excluTitle': instance.excluTitle,
      'pointCommodities': instance.pointCommodities,
      'exclusiveCommodities': instance.exclusiveCommodities,
      'weekPoint': instance.weekPoint,
    };

WeekPoint _$WeekPointFromJson(Map<String, dynamic> json) {
  return WeekPoint()
    ..title = json['title'] as String
    ..currentWeekPointItemVO = json['currentWeekPointItemVO'] == null
        ? null
        : CurrentWeekPointItemVO.fromJson(
            json['currentWeekPointItemVO'] as Map<String, dynamic>)
    ..nextWeekPointItemVO = json['nextWeekPointItemVO'] == null
        ? null
        : CurrentWeekPointItemVO.fromJson(
            json['nextWeekPointItemVO'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WeekPointToJson(WeekPoint instance) => <String, dynamic>{
      'title': instance.title,
      'currentWeekPointItemVO': instance.currentWeekPointItemVO,
      'nextWeekPointItemVO': instance.nextWeekPointItemVO,
    };

CurrentWeekPointItemVO _$CurrentWeekPointItemVOFromJson(
    Map<String, dynamic> json) {
  return CurrentWeekPointItemVO()
    ..leftTime = json['leftTime'] as num
    ..status = json['status'] as num
    ..pointCommodityVOList = (json['pointCommodityVOList'] as List)
        ?.map((e) => e == null
            ? null
            : PointCommoditiesItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..desp = json['desp'] as String;
}

Map<String, dynamic> _$CurrentWeekPointItemVOToJson(
        CurrentWeekPointItemVO instance) =>
    <String, dynamic>{
      'leftTime': instance.leftTime,
      'status': instance.status,
      'pointCommodityVOList': instance.pointCommodityVOList,
      'desp': instance.desp,
    };

PointCommoditiesItem _$PointCommoditiesItemFromJson(Map<String, dynamic> json) {
  return PointCommoditiesItem()
    ..picUrl = json['picUrl'] as String
    ..name = json['name'] as String
    ..label = json['label'] as String
    ..needPoint = json['needPoint'] as String
    ..originPrice = json['originPrice'] as String
    ..itemId = json['itemId'] as String
    ..sellOut = json['sellOut'] as bool
    ..sellVolume = json['sellVolume'] as num
    ..maxAvailable = json['maxAvailable'] as num
    ..source = json['source'] as num
    ..exchangeTimesType = json['exchangeTimesType'] as num;
}

Map<String, dynamic> _$PointCommoditiesItemToJson(
        PointCommoditiesItem instance) =>
    <String, dynamic>{
      'picUrl': instance.picUrl,
      'name': instance.name,
      'label': instance.label,
      'needPoint': instance.needPoint,
      'originPrice': instance.originPrice,
      'itemId': instance.itemId,
      'sellOut': instance.sellOut,
      'sellVolume': instance.sellVolume,
      'maxAvailable': instance.maxAvailable,
      'source': instance.source,
      'exchangeTimesType': instance.exchangeTimesType,
    };

MemLayawayVO _$MemLayawayVOFromJson(Map<String, dynamic> json) {
  return MemLayawayVO()
    ..layawayList = (json['layawayList'] as List)
        ?.map((e) => e == null
            ? null
            : LayawayListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MemLayawayVOToJson(MemLayawayVO instance) =>
    <String, dynamic>{
      'layawayList': instance.layawayList,
    };

LayawayListItem _$LayawayListItemFromJson(Map<String, dynamic> json) {
  return LayawayListItem()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..title = json['title'] as String
    ..phaseNum = json['phaseNum'] as num
    ..retailPrice = json['retailPrice'] as num
    ..favorPrice = json['favorPrice'] as num
    ..primaryPicUrl = json['primaryPicUrl'] as String
    ..listPicUrl = json['listPicUrl'] as String
    ..point = json['point'] as num;
}

Map<String, dynamic> _$LayawayListItemToJson(LayawayListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'phaseNum': instance.phaseNum,
      'retailPrice': instance.retailPrice,
      'favorPrice': instance.favorPrice,
      'primaryPicUrl': instance.primaryPicUrl,
      'listPicUrl': instance.listPicUrl,
      'point': instance.point,
    };

UserSimpleInfo _$UserSimpleInfoFromJson(Map<String, dynamic> json) {
  return UserSimpleInfo()
    ..userName = json['userName'] as String
    ..userAvatar = json['userAvatar'] as String
    ..memberLevel = json['memberLevel'] as num
    ..userId = json['userId'] as num;
}

Map<String, dynamic> _$UserSimpleInfoToJson(UserSimpleInfo instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'userAvatar': instance.userAvatar,
      'memberLevel': instance.memberLevel,
      'userId': instance.userId,
    };

PonitBannersItem _$PonitBannersItemFromJson(Map<String, dynamic> json) {
  return PonitBannersItem()
    ..title = json['title'] as String
    ..subtitle = json['subtitle'] as String
    ..picUrl = json['picUrl'] as String
    ..targetUrl = json['targetUrl'] as String
    ..startTime = json['startTime'] as num
    ..endTime = json['endTime'] as num;
}

Map<String, dynamic> _$PonitBannersItemToJson(PonitBannersItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'picUrl': instance.picUrl,
      'targetUrl': instance.targetUrl,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

PointExVirtualAct _$PointExVirtualActFromJson(Map<String, dynamic> json) {
  return PointExVirtualAct()
    ..actId = json['actId'] as num
    ..actType = json['actType'] as num
    ..actName = json['actName'] as String
    ..actDesc = json['actDesc'] as String
    ..actLimitCount = json['actLimitCount'] as num
    ..actDayLimitCount = json['actDayLimitCount'] as num
    ..beginTime = json['beginTime'] as num
    ..endTime = json['endTime'] as num
    ..actPackets = (json['actPackets'] as List)
        ?.map((e) =>
            e == null ? null : ActPackets.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..userGroup = json['userGroup'] as String
    ..actRuleTip = json['actRuleTip'] as String
    ..createTime = json['createTime'] as num;
}

Map<String, dynamic> _$PointExVirtualActToJson(PointExVirtualAct instance) =>
    <String, dynamic>{
      'actId': instance.actId,
      'actType': instance.actType,
      'actName': instance.actName,
      'actDesc': instance.actDesc,
      'actLimitCount': instance.actLimitCount,
      'actDayLimitCount': instance.actDayLimitCount,
      'beginTime': instance.beginTime,
      'endTime': instance.endTime,
      'actPackets': instance.actPackets,
      'userGroup': instance.userGroup,
      'actRuleTip': instance.actRuleTip,
      'createTime': instance.createTime,
    };

ActPackets _$ActPacketsFromJson(Map<String, dynamic> json) {
  return ActPackets()
    ..actPacketId = json['actPacketId'] as num
    ..actPacketType = json['actPacketType'] as num
    ..title = json['title'] as String
    ..picUrl = json['picUrl'] as String
    ..tag = json['tag'] as String
    ..needPoint = json['needPoint'] as num
    ..actPacketGiftId = json['actPacketGiftId'] as String
    ..soldOut = json['soldOut'] as bool
    ..condContinueSignDays = json['condContinueSignDays'] as num
    ..condTimesOfDayUserIdForAct = json['condTimesOfDayUserIdForAct'] as num
    ..condTimesOfUserIdForAct = json['condTimesOfUserIdForAct'] as num
    ..sortNum = json['sortNum'] as num;
}

Map<String, dynamic> _$ActPacketsToJson(ActPackets instance) =>
    <String, dynamic>{
      'actPacketId': instance.actPacketId,
      'actPacketType': instance.actPacketType,
      'title': instance.title,
      'picUrl': instance.picUrl,
      'tag': instance.tag,
      'needPoint': instance.needPoint,
      'actPacketGiftId': instance.actPacketGiftId,
      'soldOut': instance.soldOut,
      'condContinueSignDays': instance.condContinueSignDays,
      'condTimesOfDayUserIdForAct': instance.condTimesOfDayUserIdForAct,
      'condTimesOfUserIdForAct': instance.condTimesOfUserIdForAct,
      'sortNum': instance.sortNum,
    };
