import 'package:json_annotation/json_annotation.dart';

part 'minePageItems.g.dart';

@JsonSerializable()
class MinePageItems {
  num fundType;
  String fundValue;
  String fundName;
  String targetUrl;
  String toast;

  MinePageItems();

  factory MinePageItems.fromJson(Map<String, dynamic> json) =>
      _$MinePageItemsFromJson(json);
}
