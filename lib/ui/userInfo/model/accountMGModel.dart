import 'package:json_annotation/json_annotation.dart';

part 'accountMGModel.g.dart';

@JsonSerializable()
class AccountMGModel {
  List<num>? aliasEnableOps = [];
  List<AliasItem>? alias = [];

  AccountMGModel();

  factory AccountMGModel.fromJson(Map<String, dynamic> json) =>
      _$AccountMGModelFromJson(json);
}

@JsonSerializable()
class AliasItem {
  num? aliasType;
  num? frontGroupType;
  String? mobile;
  String? alias;

  AliasItem();

  factory AliasItem.fromJson(Map<String, dynamic> json) =>
      _$AliasItemFromJson(json);
}
