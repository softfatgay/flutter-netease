import 'package:flutter_app/ui/goods_detail/model/bannerInfo.dart';
import 'package:flutter_app/ui/topic/model/buyNow.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topicItem.g.dart';

@JsonSerializable()
class TopicItem {
  String? topicId;
  num? type;
  num? pubType;
  num? readCount;
  num? style;
  String? schemeUrl;
  String? nickname;
  String? bannerUrl;
  String? avatar;
  String? title;
  String? subTitle;
  String? picUrl;
  String? newAppBanner;
  bool? hasVideo;
  bool? hasLookCollects;
  num? size;
  num? duration;
  num? supportNum;
  num? appBanHeight;
  num? appBanWidth;
  num? newAppBannerWidth;
  num? newAppBannerHeight;
  bool? supportFlag;
  BannerInfo? bannerInfo;
  List<dynamic>? lookPics;

  BuyNow? buyNow;

  TopicItem();

  factory TopicItem.fromJson(Map<String, dynamic> json) =>
      _$TopicItemFromJson(json);
}
