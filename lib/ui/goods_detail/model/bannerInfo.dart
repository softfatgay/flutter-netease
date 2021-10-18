import 'package:json_annotation/json_annotation.dart';

part 'bannerInfo.g.dart';

@JsonSerializable()
class BannerInfo {
  num? duration;
  bool? hasVideo;
  String? picUrl;
  String? videoUrl;
  num? size;
  num? width;
  bool? isVideo;
  num? height;

  BannerInfo();

  factory BannerInfo.fromJson(Map<String, dynamic> json) =>
      _$BannerInfoFromJson(json);
}
