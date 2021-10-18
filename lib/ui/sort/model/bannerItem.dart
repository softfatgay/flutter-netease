import 'package:json_annotation/json_annotation.dart';

part 'bannerItem.g.dart';

@JsonSerializable()
class BannerItem {
  num? id;
  String? picUrl;
  String? targetUrl;

  BannerItem();

  factory BannerItem.fromJson(Map<String, dynamic> json) =>
      _$BannerItemFromJson(json);
}
