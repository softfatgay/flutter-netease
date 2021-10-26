import 'package:json_annotation/json_annotation.dart';

part 'preNewItem.g.dart';

@JsonSerializable()
class PreNewItem {
  String? listPicUrl;
  num? retailPrice;
  String? name;
  num? id;
  PreNewItem();
  factory PreNewItem.fromJson(Map<String, dynamic> json) =>
      _$PreNewItemFromJson(json);
}
