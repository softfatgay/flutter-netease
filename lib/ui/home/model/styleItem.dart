import 'package:json_annotation/json_annotation.dart';

part 'styleItem.g.dart';

@JsonSerializable()
class StyleItem {
  String? targetUrl;
  String? title;
  String? picUrl;
  String? originSchemeUrl;
  String? descColor;
  String? titleColor;
  String? desc;
  List<String?>? picUrlList;

  StyleItem();

  factory StyleItem.fromJson(Map<String, dynamic> json) =>
      _$StyleItemFromJson(json);
}
