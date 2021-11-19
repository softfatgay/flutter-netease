import 'package:flutter_app/ui/home/model/styleItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sceneLightShoppingGuideModule.g.dart';

@JsonSerializable()
class SceneLightShoppingGuideModule {
  StyleItem? styleItem;
  StyleItem? styleBanner;

  SceneLightShoppingGuideModule();

  factory SceneLightShoppingGuideModule.fromJson(Map<String, dynamic> json) =>
      _$SceneLightShoppingGuideModuleFromJson(json);
}
