import 'package:flutter_app/ui/sort/model/bannerItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subCateListItem.g.dart';

@JsonSerializable()
class SubCateListItem {
  num? id;
  num? superCategoryId;
  num? showIndex;
  String? name;
  String? frontName;
  String? frontDesc;
  String? bannerUrl;

  SubCateListItem();

  factory SubCateListItem.fromJson(Map<String, dynamic> json) =>
      _$SubCateListItemFromJson(json);
}
