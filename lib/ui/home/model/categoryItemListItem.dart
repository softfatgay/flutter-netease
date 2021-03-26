import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoryItemListItem.g.dart';

@JsonSerializable()
class CategoryItemListItem {
  Category category;
  List<ItemListItem> itemList;

  CategoryItemListItem();

  factory CategoryItemListItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemListItemFromJson(json);
}
