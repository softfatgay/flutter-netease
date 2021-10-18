import 'package:json_annotation/json_annotation.dart';

part 'tabModel.g.dart';

@JsonSerializable()
class TabModel {
  num? id;
  String? name;
  String? type;

  TabModel();

  factory TabModel.fromJson(Map<String, dynamic> json) =>
      _$TabModelFromJson(json);
}
