import 'package:flutter_app/model/itemListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'searchResultModel.g.dart';

@JsonSerializable()
class SearchResultModel {
  bool hasMore;
  List<ItemListItem> directlyList;

  SearchResultModel();

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);
}
