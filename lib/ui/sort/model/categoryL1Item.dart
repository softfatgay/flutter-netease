import 'package:json_annotation/json_annotation.dart';

part 'categoryL1Item.g.dart';

@JsonSerializable()
class CategoryL1Item {
  num? id;
  num? superCategoryId;
  num? showIndex;
  String? name;

  CategoryL1Item();

  factory CategoryL1Item.fromJson(Map<String, dynamic> json) =>
      _$CategoryL1ItemFromJson(json);
}
