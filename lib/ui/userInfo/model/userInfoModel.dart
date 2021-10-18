import 'package:json_annotation/json_annotation.dart';

part 'userInfoModel.g.dart';

@JsonSerializable()
class UserInfoModel {
  bool? isUrs = true;
  User? user = User();

  UserInfoModel();

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}

@JsonSerializable()
class User {
  String? avatar;
  String? nickname = '';
  String? id = '';
  num? gender;
  String? mobile;
  num? birthYear;
  num? birthMonth;
  num? birthDay;
  num? memberLevel;
  String? uid;
  num? userType;
  bool? hasInterestCategory;
  List<Aliases>? aliases = [];

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Aliases {
  String? alias;
  num? aliasType;
  String? mobile;
  num? frontGroupType;

  Aliases();

  factory Aliases.fromJson(Map<String, dynamic> json) =>
      _$AliasesFromJson(json);
}
