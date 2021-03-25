import 'package:flutter_app/ui/topic/model/navItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topNavData.g.dart';

@JsonSerializable()
class TopData {
  bool checkNavType;
  List<NavItem> navList;

  TopData();

  factory TopData.fromJson(Map<String, dynamic> json) =>
      _$TopDataFromJson(json);
}
