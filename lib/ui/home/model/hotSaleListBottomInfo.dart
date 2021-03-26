import 'package:json_annotation/json_annotation.dart';

part 'hotSaleListBottomInfo.g.dart';

@JsonSerializable()
class HotSaleListBottomInfo {
  String iconUrl;
  String content;

  HotSaleListBottomInfo();

  factory HotSaleListBottomInfo.fromJson(Map<String, dynamic> json) =>
      _$HotSaleListBottomInfoFromJson(json);
}
