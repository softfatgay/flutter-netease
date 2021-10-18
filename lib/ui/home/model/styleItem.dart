import 'package:json_annotation/json_annotation.dart';

part 'styleItem.g.dart';

@JsonSerializable()
class StyleItem {
  String? targetUrl;
  String? title;
  String? desc;
  List<String?>? picUrlList;

  StyleItem();

  factory StyleItem.fromJson(Map<String, dynamic> json) =>
      _$StyleItemFromJson(json);
}
