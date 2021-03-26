import 'package:json_annotation/json_annotation.dart';

part 'categoryL1ListItem.g.dart';

@JsonSerializable()
class CategoryL1ListItem {
  num id;
  num superCategoryId;
  num showIndex;
  String name;
  String frontName;
  String frontDesc;
  String wapBannerUrl;

  CategoryL1ListItem();

  factory CategoryL1ListItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryL1ListItemFromJson(json);
}
