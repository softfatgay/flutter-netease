// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrUserInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrUserInfoModel _$QrUserInfoModelFromJson(Map<String, dynamic> json) {
  return QrUserInfoModel()
    ..userId = json['userId'] as num
    ..userName = json['userName'] as String
    ..avatar = json['avatar'] as String
    ..nickname = json['nickname'] as String
    ..status = json['status'] as num
    ..upperLimit = json['upperLimit'] as bool
    ..effectiveStartTime = json['effectiveStartTime'] as num
    ..effectiveEndTime = json['effectiveEndTime'] as num
    ..remainDays = json['remainDays'] as num
    ..whiteListUser = json['whiteListUser'] as bool
    ..hasGotPrize = json['hasGotPrize'] as bool
    ..virtualStatus = json['virtualStatus'] as num
    ..memberLevel = json['memberLevel'] as num
    ..qinhuiyuanStatus = json['qinhuiyuanStatus'] as num
    ..wechatQinghuiyuanStatus = json['wechatQinghuiyuanStatus'] as num
    ..hadUseFreeTry = json['hadUseFreeTry'] as bool
    ..currentPeriod = json['currentPeriod'] == null
        ? null
        : CurrentPeriod.fromJson(json['currentPeriod'] as Map<String, dynamic>)
    ..spmcOrderRightEnjoyRecordListTO =
        json['spmcOrderRightEnjoyRecordListTO'] == null
            ? null
            : SpmcOrderRightEnjoyRecordListTO.fromJson(
                json['spmcOrderRightEnjoyRecordListTO']
                    as Map<String, dynamic>);
}

Map<String, dynamic> _$QrUserInfoModelToJson(QrUserInfoModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'status': instance.status,
      'upperLimit': instance.upperLimit,
      'effectiveStartTime': instance.effectiveStartTime,
      'effectiveEndTime': instance.effectiveEndTime,
      'remainDays': instance.remainDays,
      'whiteListUser': instance.whiteListUser,
      'hasGotPrize': instance.hasGotPrize,
      'virtualStatus': instance.virtualStatus,
      'memberLevel': instance.memberLevel,
      'qinhuiyuanStatus': instance.qinhuiyuanStatus,
      'wechatQinghuiyuanStatus': instance.wechatQinghuiyuanStatus,
      'hadUseFreeTry': instance.hadUseFreeTry,
      'currentPeriod': instance.currentPeriod,
      'spmcOrderRightEnjoyRecordListTO':
          instance.spmcOrderRightEnjoyRecordListTO,
    };

CurrentPeriod _$CurrentPeriodFromJson(Map<String, dynamic> json) {
  return CurrentPeriod()
    ..cardBigType = json['cardBigType'] as String
    ..memberStatus = json['memberStatus'] as String
    ..leftDays = json['leftDays'] as num
    ..leftDaysCluster = json['leftDaysCluster'] as String;
}

Map<String, dynamic> _$CurrentPeriodToJson(CurrentPeriod instance) =>
    <String, dynamic>{
      'cardBigType': instance.cardBigType,
      'memberStatus': instance.memberStatus,
      'leftDays': instance.leftDays,
      'leftDaysCluster': instance.leftDaysCluster,
    };

SpmcOrderRightEnjoyRecordListTO _$SpmcOrderRightEnjoyRecordListTOFromJson(
    Map<String, dynamic> json) {
  return SpmcOrderRightEnjoyRecordListTO()
    ..totalSaveMoney = json['totalSaveMoney'] as num
    ..saveMoneyCluster = json['saveMoneyCluster'] as String;
}

Map<String, dynamic> _$SpmcOrderRightEnjoyRecordListTOToJson(
        SpmcOrderRightEnjoyRecordListTO instance) =>
    <String, dynamic>{
      'totalSaveMoney': instance.totalSaveMoney,
      'saveMoneyCluster': instance.saveMoneyCluster,
    };
