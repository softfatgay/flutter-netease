import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/ui/sort/model/sortlistCategoryItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sortListData.g.dart';

///
@JsonSerializable()
class SortListData {
  SortlistCategoryItem? categoryItems;
  List<Category>? categoryL2List;

  SortListData();

  factory SortListData.fromJson(Map<String, dynamic> json) =>
      _$SortListDataFromJson(json);
}
