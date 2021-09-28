import 'package:flutter_app/ui/goods_detail/model/priceModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bannerModel.g.dart';

@JsonSerializable()
class BannerModel {
  num status;
  ProcessBanner processBanner;
  num type;

  BannerModel();
  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}

@JsonSerializable()
class ProcessBanner {
  String title;
  String supplementText;
  PriceModel priceInfo;
  String timePrefix;
  num endTimeGap;
  String bgColor;
  String priceBgColor;

  ProcessBanner();
  factory ProcessBanner.fromJson(Map<String, dynamic> json) =>
      _$ProcessBannerFromJson(json);
}
