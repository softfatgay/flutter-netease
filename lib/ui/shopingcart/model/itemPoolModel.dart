import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/ui/shopingcart/model/carItem.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'itemPoolModel.g.dart';

@JsonSerializable()
class ItemPoolModel {
  List<CategorytListItem> categorytList;
  SearcherItemListResult searcherItemListResult;

  ItemPoolModel();

  factory ItemPoolModel.fromJson(Map<String, dynamic> json) =>
      _$ItemPoolModelFromJson(json);
}

@JsonSerializable()
class CategorytListItem {
  CategoryL1Item categoryVO;
  num count;

  CategorytListItem();

  factory CategorytListItem.fromJson(Map<String, dynamic> json) =>
      _$CategorytListItemFromJson(json);
}

@JsonSerializable()
class SearcherItemListResult {
  Pagination pagination;
  List<ItemListItem> result;

  SearcherItemListResult();

  factory SearcherItemListResult.fromJson(Map<String, dynamic> json) =>
      _$SearcherItemListResultFromJson(json);
}
