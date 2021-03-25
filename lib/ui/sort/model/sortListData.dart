import 'package:flutter_app/ui/sort/model/categoryGroupItem.dart';
import 'package:flutter_app/ui/sort/model/categoryItem.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';
import 'package:flutter_app/ui/sort/model/currentCategory.dart';
import 'package:flutter_app/ui/sort/model/sortlistCategoryItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sortListData.g.dart';

///
@JsonSerializable()
class SortListData {
  SortlistCategoryItem categoryItems;
  List<CategoryItem> categoryL2List;

  SortListData();

  factory SortListData.fromJson(Map<String, dynamic> json) =>
      _$SortListDataFromJson(json);
}
