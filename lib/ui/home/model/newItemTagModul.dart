import 'package:json_annotation/json_annotation.dart';

part 'newItemTagModul.g.dart';

@JsonSerializable()
class NewItemTagModel {
  num? itemId;
  num? tagId;
  bool? freshmanExclusive;
  bool? forbidJump;

  String? name;
  num? subType;
  num? type;

  NewItemTagModel();

  factory NewItemTagModel.fromJson(Map<String, dynamic> json) =>
      _$NewItemTagModelFromJson(json);
}
