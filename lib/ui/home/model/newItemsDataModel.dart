import 'package:flutter_app/model/categoryL1ListItem.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'newItemsDataModel.g.dart';

@JsonSerializable()
class NewItemsDataModel {
  NewItems? newItems;
  List<ItemListItem>? editorRecommendItems;
  List<ZcItems>? zcItems;
  NewItemsDataModel();

  factory NewItemsDataModel.fromJson(Map<String, dynamic> json) =>
      _$NewItemsDataModelFromJson(json);
}

@JsonSerializable()
class NewItems {
  bool? hasMore;
  List<CategoryL1ListItem>? categoryL1List;
  List<TagListName>? tagList;
  List<ItemListItem>? itemList;
  NewItems();

  factory NewItems.fromJson(Map<String, dynamic> json) =>
      _$NewItemsFromJson(json);
}

@JsonSerializable()
class TagListName {
  num? id;
  String? tagName;

  TagListName();

  factory TagListName.fromJson(Map<String, dynamic> json) =>
      _$TagListNameFromJson(json);
}

@JsonSerializable()
class ZcItems {
  String? picUrl;
  num? minPrice;
  String? name;
  String? description;
  num? actualAmountPercent;
  num? id;
  num? actualNum;
  ZcItems();
  factory ZcItems.fromJson(Map<String, dynamic> json) =>
      _$ZcItemsFromJson(json);
}
