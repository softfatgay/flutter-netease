import 'package:json_annotation/json_annotation.dart';

part 'focusItem.g.dart';

@JsonSerializable()
class FocusItem {
  String picUrl;
  num expireTime;
  String name;
  num onlineTime;
  num id;
  String originSchemeUrl;
  String targetUrl;

  FocusItem();

  factory FocusItem.fromJson(Map<String, dynamic> json) =>
      _$FocusItemFromJson(json);
}
