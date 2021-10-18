import 'package:json_annotation/json_annotation.dart';

part 'itemTagListItem.g.dart';

@JsonSerializable()
class ItemTagListItem {
  num? type;
  num? subType;
  num? tagId;
  num? itemId;
  String? name;
  bool? forbidJump;
  bool? freshmanExclusive;

  ItemTagListItem();

  factory ItemTagListItem.fromJson(Map<String, dynamic> json) =>
      _$ItemTagListItemFromJson(json);
}
