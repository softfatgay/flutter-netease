import 'package:flutter_app/ui/home/model/itemPicBeanList.dart';
import 'package:flutter_app/ui/sort/model/bannerItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  num? id;
  num? superCategoryId;
  num? showIndex;
  String? picUrl;
  String? categoryName;
  String? targetUrl;
  String? showPicUrl;
  String? wapBannerUrl;
  String? name;
  String? frontName;
  List<ItemPicBeanList>? itemPicBeanList;
  List<BannerItem>? bannerList;
  String? test;
  Category();

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
