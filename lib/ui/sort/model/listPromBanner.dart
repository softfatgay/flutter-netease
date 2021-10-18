import 'package:json_annotation/json_annotation.dart';

part 'listPromBanner.g.dart';

@JsonSerializable()
class ListPromBanner {
  bool? valid;
  String? promoTitle;
  String? promoSubTitle;
  String? content;
  String? bannerTitleUrl;
  String? bannerContentUrl;
  num? styleType;
  num? timeType;

  ListPromBanner();

  factory ListPromBanner.fromJson(Map<String, dynamic> json) =>
      _$ListPromBannerFromJson(json);
}
