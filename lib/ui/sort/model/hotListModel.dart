import 'package:flutter_app/ui/sort/model/currentCategory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotListModel.g.dart';

@JsonSerializable()
class HotListModel {
  CurrentCategory currentCategory;
  List<CurrentCategory> moreCategories;

  HotListModel();

  factory HotListModel.fromJson(Map<String, dynamic> json) =>
      _$HotListModelFromJson(json);
}
