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
  bool? hasVideo;
  bool? hasLookCollects;
  num? size;
  num? duration;
  num? supportNum;
  bool? supportFlag;
  BannerInfo? bannerInfo;

  BuyNow? buyNow;

  TopicItem();

  factory TopicItem.fromJson(Map<String, dynamic> json) =>
      _$TopicItemFromJson(json);
}
