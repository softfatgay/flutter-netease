import 'package:json_annotation/json_annotation.dart';

part 'navItem.g.dart';

@JsonSerializable()
class NavItem {
  num id;
  String picUrl;
  String mainTitle;
  String viceTitle;
  String columnUrl;
  bool onlineType;
  num vaildStartTime;
  num vaildEndTime;
  num rank;

  NavItem();

  factory NavItem.fromJson(Map<String, dynamic> json) =>
      _$NavItemFromJson(json);
}
