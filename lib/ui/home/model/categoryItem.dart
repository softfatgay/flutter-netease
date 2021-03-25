import 'package:flutter_app/ui/home/model/itemPicBeanList.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoryItem.g.dart';

@JsonSerializable()
class CategoryItem {
  num id;
  num superCategoryId;
  String picUrl;
  String categoryName;
  String targetUrl;
  String showPicUrl;
  String wapBannerUrl;
  String name;
  List<ItemPicBeanList> itemPicBeanList;

  CategoryItem();

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);
}
