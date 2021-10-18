import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sortlistCategoryItem.g.dart';

@JsonSerializable()
class SortlistCategoryItem {
  Category? category;
  List<ItemListItem>? itemList;

  SortlistCategoryItem();

  factory SortlistCategoryItem.fromJson(Map<String, dynamic> json) =>
      _$SortlistCategoryItemFromJson(json);
}
