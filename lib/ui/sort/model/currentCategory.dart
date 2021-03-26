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
  List<BannerItem> bannerList;
  List<SubCateListItem> subCateList;

  CurrentCategory();

  factory CurrentCategory.fromJson(Map<String, dynamic> json) =>
      _$CurrentCategoryFromJson(json);
}
