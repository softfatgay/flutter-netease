import 'package:flutter_app/model/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoryHotSellModule.g.dart';

@JsonSerializable()
class CategoryHotSellModule {
  String titleTargetUrl;
  String title;

  List<Category> categoryList;

  CategoryHotSellModule();

  factory CategoryHotSellModule.fromJson(Map<String, dynamic> json) =>
      _$CategoryHotSellModuleFromJson(json);
}
