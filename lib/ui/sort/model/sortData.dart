import 'package:flutter_app/ui/sort/model/categoryGroupItem.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';
import 'package:flutter_app/ui/sort/model/currentCategory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sortData.g.dart';

@JsonSerializable()
class SortData {
  List<CategoryL1Item>? categoryL1List;
  CurrentCategory? currentCategory;
  List<CategoryGroupItem>? categoryGroupList;
  SortData();

  factory SortData.fromJson(Map<String, dynamic> json) =>
      _$SortDataFromJson(json);
}
