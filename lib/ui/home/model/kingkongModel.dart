import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/ui/home/model/categoryItemListItem.dart';
import 'package:flutter_app/ui/sort/model/currentCategory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kingkongModel.g.dart';

@JsonSerializable()
class KingkongModel {
  Category currentCategory;
  List<CategoryItemListItem> categoryItemList;

  KingkongModel();

  factory KingkongModel.fromJson(Map<String, dynamic> json) =>
      _$KingkongModelFromJson(json);
}
