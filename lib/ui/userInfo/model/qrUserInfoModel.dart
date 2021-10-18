import 'package:json_annotation/json_annotation.dart';

part 'qrUserInfoModel.g.dart';

@JsonSerializable()
class QrUserInfoModel {
  num? userId;
  String? userName;
  String? avatar;
  String? nickname;
  num? status;
  bool? upperLimit;
  num? effectiveStartTime;
  num? effectiveEndTime;
  num? remainDays;
  bool? whiteListUser;
  bool? hasGotPrize;
  num? virtualStatus;
  num? memberLevel;
  num? qinhuiyuanStatus;
  num? wechatQinghuiyuanStatus;
  bool? hadUseFreeTry;
  CurrentPeriod? currentPeriod;
  SpmcOrderRightEnjoyRecordListTO? spmcOrderRightEnjoyRecordListTO;

  QrUserInfoModel();

  factory QrUserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$QrUserInfoModelFromJson(json);
}

@JsonSerializable()
class CurrentPeriod {
  String? cardBigType;
  String? memberStatus;
  num? leftDays;
  String? leftDaysCluster;

  CurrentPeriod();

  factory CurrentPeriod.fromJson(Map<String, dynamic> json) =>
      _$CurrentPeriodFromJson(json);
}

@JsonSerializable()
class SpmcOrderRightEnjoyRecordListTO {
  num? totalSaveMoney;
  String? saveMoneyCluster;

  SpmcOrderRightEnjoyRecordListTO();

  factory SpmcOrderRightEnjoyRecordListTO.fromJson(Map<String, dynamic> json) =>
      _$SpmcOrderRightEnjoyRecordListTOFromJson(json);
}
