// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bannerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) {
  return BannerModel()
    ..status = json['status'] as num
    ..processBanner = json['processBanner'] == null
        ? null
        : ProcessBanner.fromJson(json['processBanner'] as Map<String, dynamic>)
    ..type = json['type'] as num;
}

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'processBanner': instance.processBanner,
      'type': instance.type,
    };

ProcessBanner _$ProcessBannerFromJson(Map<String, dynamic> json) {
  return ProcessBanner()
    ..title = json['title'] as String
    ..supplementText = json['supplementText'] as String
    ..priceInfo = json['priceInfo'] == null
        ? null
        : PriceModel.fromJson(json['priceInfo'] as Map<String, dynamic>)
    ..timePrefix = json['timePrefix'] as String
    ..endTimeGap = json['endTimeGap'] as num
    ..bgColor = json['bgColor'] as String
    ..priceBgColor = json['priceBgColor'] as String;
}

Map<String, dynamic> _$ProcessBannerToJson(ProcessBanner instance) =>
    <String, dynamic>{
      'title': instance.title,
      'supplementText': instance.supplementText,
      'priceInfo': instance.priceInfo,
      'timePrefix': instance.timePrefix,
      'endTimeGap': instance.endTimeGap,
      'bgColor': instance.bgColor,
      'priceBgColor': instance.priceBgColor,
    };
