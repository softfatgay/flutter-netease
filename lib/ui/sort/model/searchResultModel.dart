import 'package:flutter_app/model/itemListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'searchResultModel.g.dart';

@JsonSerializable()
class SearchResultModel {
  bool hasMore;
  List<ItemListItem> directlyList;
  List<CategoryL1ListItem> categoryL1List;

  SearchResultModel();

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);
}

@JsonSerializable()
class CategoryL1ListItem {
  num id;
  String name;

  CategoryL1ListItem();

  factory CategoryL1ListItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryL1ListItemFromJson(json);
}
