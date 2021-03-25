import 'package:json_annotation/json_annotation.dart';

part 'categoryItem.g.dart';

@JsonSerializable()
class CategoryItem {
  num id;
  num superCategoryId;
  num showIndex;
  String name;
  String bannerUrl;
  String wapBannerUrl;

  CategoryItem();

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);
}
