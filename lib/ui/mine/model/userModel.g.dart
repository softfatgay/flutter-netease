// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..userSimpleVO = json['userSimpleVO'] == null
      ? null
      : UserSimpleVO.fromJson(json['userSimpleVO'] as Map<String, dynamic>)
  ..spmcEntrance = json['spmcEntrance'] == null
      ? null
      : SpmcEntrance.fromJson(json['spmcEntrance'] as Map<String, dynamic>)
  ..monthCardEntrance = json['monthCardEntrance'] == null
      ? null
      : WelfareCardEntrance.fromJson(
          json['monthCardEntrance'] as Map<String, dynamic>)
  ..welfareFissionInfo = json['welfareFissionInfo'] == null
      ? null
      : WelfareFissionInfo.fromJson(
          json['welfareFissionInfo'] as Map<String, dynamic>)
  ..welfareCardEntrance = json['welfareCardEntrance'] == null
      ? null
      : WelfareCardEntrance.fromJson(
          json['welfareCardEntrance'] as Map<String, dynamic>);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userSimpleVO': instance.userSimpleVO,
      'spmcEntrance': instance.spmcEntrance,
      'monthCardEntrance': instance.monthCardEntrance,
      'welfareFissionInfo': instance.welfareFissionInfo,
      'welfareCardEntrance': instance.welfareCardEntrance,
    };

UserSimpleVO _$UserSimpleVOFromJson(Map<String, dynamic> json) => UserSimpleVO()
  ..avatar = json['avatar'] as String?
  ..nickname = json['nickname'] as String?
  ..memberLevel = json['memberLevel'] as num?
  ..isNewUser = json['isNewUser'] as num?
  ..hasInterestCategory = json['hasInterestCategory'] as bool?
  ..hasMemGift = json['hasMemGift'] as bool?
  ..pointsCnt = json['pointsCnt'] as num?
  ..mosaicUid = json['mosaicUid'] as String?
  ..uniqueId = json['uniqueId'] as num?
  ..frontendAccountType = json['frontendAccountType'] as num?
  ..hideQrCode = json['hideQrCode'] as bool?
  ..mobile = json['mobile'] as String?;

Map<String, dynamic> _$UserSimpleVOToJson(UserSimpleVO instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'memberLevel': instance.memberLevel,
      'isNewUser': instance.isNewUser,
      'hasInterestCategory': instance.hasInterestCategory,
      'hasMemGift': instance.hasMemGift,
      'pointsCnt': instance.pointsCnt,
      'mosaicUid': instance.mosaicUid,
      'uniqueId': instance.uniqueId,
      'frontendAccountType': instance.frontendAccountType,
      'hideQrCode': instance.hideQrCode,
      'mobile': instance.mobile,
    };

SpmcEntrance _$SpmcEntranceFromJson(Map<String, dynamic> json) => SpmcEntrance()
  ..open = json['open'] as bool?
  ..status = json['status'] as num?
  ..statusDesc = json['statusDesc'] as String?
  ..showGiftIcon = json['showGiftIcon'] as bool?;

Map<String, dynamic> _$SpmcEntranceToJson(SpmcEntrance instance) =>
    <String, dynamic>{
      'open': instance.open,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'showGiftIcon': instance.showGiftIcon,
    };

MonthCardEntrance _$MonthCardEntranceFromJson(Map<String, dynamic> json) =>
    MonthCardEntrance()
      ..title = json['title'] as String?
      ..content = json['content'] as String?;

Map<String, dynamic> _$MonthCardEntranceToJson(MonthCardEntrance instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };

WelfareFissionInfo _$WelfareFissionInfoFromJson(Map<String, dynamic> json) =>
    WelfareFissionInfo()
      ..picUrl = json['picUrl'] as String?
      ..schemeUrl = json['schemeUrl'] as String?;

Map<String, dynamic> _$WelfareFissionInfoToJson(WelfareFissionInfo instance) =>
    <String, dynamic>{
      'picUrl': instance.picUrl,
      'schemeUrl': instance.schemeUrl,
    };

WelfareCardEntrance _$WelfareCardEntranceFromJson(Map<String, dynamic> json) =>
    WelfareCardEntrance()
      ..title = json['title'] as String?
      ..content = json['content'] as String?
      ..url = json['url'] as String?
      ..userType = json['userType'] as num?
      ..hasBuy = json['hasBuy'] as bool?
      ..type = json['type'] as num?
      ..buttonName = json['buttonName'] as String?
      ..iconPicUrl = json['iconPicUrl'] as String?
      ..titleUrl = json['titleUrl'] as String?;

Map<String, dynamic> _$WelfareCardEntranceToJson(
        WelfareCardEntrance instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'url': instance.url,
      'userType': instance.userType,
      'hasBuy': instance.hasBuy,
      'type': instance.type,
      'buttonName': instance.buttonName,
      'iconPicUrl': instance.iconPicUrl,
      'titleUrl': instance.titleUrl,
    };
