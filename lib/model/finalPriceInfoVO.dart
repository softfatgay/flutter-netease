import 'package:flutter_app/ui/home/model/itemPicBeanList.dart';
import 'package:flutter_app/ui/sort/model/bannerItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'finalPriceInfoVO.g.dart';

@JsonSerializable()
class FinalPriceInfoVO {
  BannerVO banner;
  PriceInfo priceInfo;
  num type;

  FinalPriceInfoVO();
  factory FinalPriceInfoVO.fromJson(Map<String, dynamic> json) =>
      _$FinalPriceInfoVOFromJson(json);
}

@JsonSerializable()
class BannerVO {
  String logo;
  String title;
  String content;

  BannerVO();

  factory BannerVO.fromJson(Map<String, dynamic> json) =>
      _$BannerVOFromJson(json);
}

@JsonSerializable()
class PriceInfo {
  FinalPrice finalPrice;
  String counterPrice;
  String basicPrice;

  PriceInfo();

  factory PriceInfo.fromJson(Map<String, dynamic> json) =>
      _$PriceInfoFromJson(json);
}

@JsonSerializable()
class FinalPrice {
  String prefix;
  String price;
  String suffix;

  FinalPrice();

  factory FinalPrice.fromJson(Map<String, dynamic> json) =>
      _$FinalPriceFromJson(json);
}
