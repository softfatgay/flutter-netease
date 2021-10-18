import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class UserModel {
  UserSimpleVO? userSimpleVO;
  SpmcEntrance? spmcEntrance;
  WelfareCardEntrance? monthCardEntrance;
  WelfareFissionInfo? welfareFissionInfo;
  WelfareCardEntrance? welfareCardEntrance;

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@JsonSerializable()
class UserSimpleVO {
  String? avatar;
  String? nickname;
  num? memberLevel;
  num? isNewUser;
  bool? hasInterestCategory;
  bool? hasMemGift;
  num? pointsCnt;
  String? mosaicUid;
  num? uniqueId;
  num? frontendAccountType;
  bool? hideQrCode;
  String? mobile;

  UserSimpleVO();

  factory UserSimpleVO.fromJson(Map<String, dynamic> json) =>
      _$UserSimpleVOFromJson(json);
}

@JsonSerializable()
class SpmcEntrance {
  bool? open;
  num? status;
  String? statusDesc;
  bool? showGiftIcon;

  SpmcEntrance();

  factory SpmcEntrance.fromJson(Map<String, dynamic> json) =>
      _$SpmcEntranceFromJson(json);
}

@JsonSerializable()
class MonthCardEntrance {
  String? title;
  String? content;

  MonthCardEntrance();

  factory MonthCardEntrance.fromJson(Map<String, dynamic> json) =>
      _$MonthCardEntranceFromJson(json);
}

@JsonSerializable()
class WelfareFissionInfo {
  String? picUrl;

  WelfareFissionInfo();

  factory WelfareFissionInfo.fromJson(Map<String, dynamic> json) =>
      _$WelfareFissionInfoFromJson(json);
}

@JsonSerializable()
class WelfareCardEntrance {
  String? title;
  String? content;
  String? url;
  num? userType;
  bool? hasBuy;
  num? type;
  String? buttonName;
  String? iconPicUrl;
  String? titleUrl;

  WelfareCardEntrance();

  factory WelfareCardEntrance.fromJson(Map<String, dynamic> json) =>
      _$WelfareCardEntranceFromJson(json);
}
