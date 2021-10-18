import 'package:flutter_app/model/tabModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tabGroupModel.g.dart';

@JsonSerializable()
class TabGroupModel {
  List<TabModel>? categoryList;
  List<TabModel>? tabList;

  TabGroupModel();

  factory TabGroupModel.fromJson(Map<String, dynamic> json) =>
      _$TabGroupModelFromJson(json);
}
