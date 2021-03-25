import 'package:flutter_app/ui/home/model/categoryItem.dart';
import 'package:flutter_app/ui/sort/model/goodItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sortlistCategoryItem.g.dart';

@JsonSerializable()
class SortlistCategoryItem {
  CategoryItem category;
  List<GoodItem> itemList;

  SortlistCategoryItem();

  factory SortlistCategoryItem.fromJson(Map<String, dynamic> json) =>
      _$SortlistCategoryItemFromJson(json);
}
