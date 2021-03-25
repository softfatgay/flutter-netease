import 'package:json_annotation/json_annotation.dart';

part 'tagItem.g.dart';

@JsonSerializable()
class TagItem {
  double floorPrice;
  String picUrl;
  bool newOnShelf;
  String webIndexVerticalPicUrl;
  String simpleDesc;
  String name;
  String appListPicUrl;
  int id;

  TagItem();

  factory TagItem.fromJson(Map<String, dynamic> json) =>
      _$TagItemFromJson(json);
}
