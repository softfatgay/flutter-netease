import 'package:flutter_app/ui/home/model/categoryItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoryHotSellModule.g.dart';

@JsonSerializable()
class CategoryHotSellModule {
  String titleTargetUrl;
  String title;

  List<CategoryItem> categoryList;

  CategoryHotSellModule();

  factory CategoryHotSellModule.fromJson(Map<String, dynamic> json) =>
      _$CategoryHotSellModuleFromJson(json);
}
