import 'package:flutter_app/model/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoryGroupItem.g.dart';

@JsonSerializable()
class CategoryGroupItem {
  num? id;
  String? name;
  List<Category>? categoryList;

  CategoryGroupItem();

  factory CategoryGroupItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryGroupItemFromJson(json);
}
