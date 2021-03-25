import 'package:json_annotation/json_annotation.dart';

part 'kingKongModule.g.dart';

@JsonSerializable()
class KingKongModule {
  String norColor;
  String background;
  String selectedColor;
  List<KingKongItem> kingKongList;

  KingKongModule();

  factory KingKongModule.fromJson(Map<String, dynamic> json) =>
      _$KingKongModuleFromJson(json);
}

@JsonSerializable()
class KingKongItem {
  String picUrl;
  String schemeUrl;
  String text;
  String textColor;

  KingKongItem();

  factory KingKongItem.fromJson(Map<String, dynamic> json) =>
      _$KingKongItemFromJson(json);
}
