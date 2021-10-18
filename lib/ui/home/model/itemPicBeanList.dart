import 'package:json_annotation/json_annotation.dart';

part 'itemPicBeanList.g.dart';

@JsonSerializable()
class ItemPicBeanList {
  int? itemId;
  String? picUrl;

  ItemPicBeanList();

  factory ItemPicBeanList.fromJson(Map<String, dynamic> json) =>
      _$ItemPicBeanListFromJson(json);
}
