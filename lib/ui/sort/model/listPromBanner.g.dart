// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listPromBanner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPromBanner _$ListPromBannerFromJson(Map<String, dynamic> json) {
  return ListPromBanner()
    ..valid = json['valid'] as bool
    ..promoTitle = json['promoTitle'] as String
    ..promoSubTitle = json['promoSubTitle'] as String
    ..content = json['content'] as String
    ..bannerTitleUrl = json['bannerTitleUrl'] as String
    ..bannerContentUrl = json['bannerContentUrl'] as String
    ..styleType = json['styleType'] as num
    ..timeType = json['timeType'] as num;
}

Map<String, dynamic> _$ListPromBannerToJson(ListPromBanner instance) =>
    <String, dynamic>{
      'valid': instance.valid,
      'promoTitle': instance.promoTitle,
      'promoSubTitle': instance.promoSubTitle,
      'content': instance.content,
      'bannerTitleUrl': instance.bannerTitleUrl,
      'bannerContentUrl': instance.bannerContentUrl,
      'styleType': instance.styleType,
      'timeType': instance.timeType,
    };
