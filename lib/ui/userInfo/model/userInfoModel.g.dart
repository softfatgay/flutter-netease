// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel()
    ..isUrs = json['isUrs'] as bool
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'isUrs': instance.isUrs,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..avatar = json['avatar'] as String
    ..nickname = json['nickname'] as String
    ..id = json['id'] as String
    ..gender = json['gender'] as num
    ..mobile = json['mobile'] as String
    ..birthYear = json['birthYear'] as num
    ..birthMonth = json['birthMonth'] as num
    ..birthDay = json['birthDay'] as num
    ..memberLevel = json['memberLevel'] as num
    ..uid = json['uid'] as String
    ..userType = json['userType'] as num
    ..hasInterestCategory = json['hasInterestCategory'] as bool
    ..aliases = (json['aliases'] as List)
        ?.map((e) =>
            e == null ? null : Aliases.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'id': instance.id,
      'gender': instance.gender,
      'mobile': instance.mobile,
      'birthYear': instance.birthYear,
      'birthMonth': instance.birthMonth,
      'birthDay': instance.birthDay,
      'memberLevel': instance.memberLevel,
      'uid': instance.uid,
      'userType': instance.userType,
      'hasInterestCategory': instance.hasInterestCategory,
      'aliases': instance.aliases,
    };

Aliases _$AliasesFromJson(Map<String, dynamic> json) {
  return Aliases()
    ..alias = json['alias'] as String
    ..aliasType = json['aliasType'] as num
    ..mobile = json['mobile'] as String
    ..frontGroupType = json['frontGroupType'] as num;
}

Map<String, dynamic> _$AliasesToJson(Aliases instance) => <String, dynamic>{
      'alias': instance.alias,
      'aliasType': instance.aliasType,
      'mobile': instance.mobile,
      'frontGroupType': instance.frontGroupType,
    };
