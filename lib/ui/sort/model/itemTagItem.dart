import 'package:flutter_app/ui/home/model/categoryItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'itemTagItem.g.dart';

@JsonSerializable()
class ItemTagItem {
  num type;
  num subType;
  num tagId;
  num itemId;
  String name;
  bool forbidJump;
  bool freshmanExclusive;
  ItemTagItem();

  factory ItemTagItem.fromJson(Map<String, dynamic> json) =>
      _$ItemTagItemFromJson(json);
}
