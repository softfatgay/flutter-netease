import 'package:flutter_app/ui/sort/model/bannerItem.dart';
import 'package:flutter_app/ui/sort/model/subCateListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currentCategory.g.dart';

@JsonSerializable()
class CurrentCategory {
  num id;
  num superCategoryId;
  num showIndex;
  String name;
  String frontName;
  String frontDesc;
  String bannerUrl;
  ShowItem showItem;

  List<BannerItem> bannerList;
  List<CurrentCategory> subCateList;

  CurrentCategory();

  factory CurrentCategory.fromJson(Map<String, dynamic> json) =>
      _$CurrentCategoryFromJson(json);
}

@JsonSerializable()
class ShowItem {
  num id;
  String picUrl;
  ShowItem();

  factory ShowItem.fromJson(Map<String, dynamic> json) =>
      _$ShowItemFromJson(json);
}
