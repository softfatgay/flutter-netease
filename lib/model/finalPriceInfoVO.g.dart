// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finalPriceInfoVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinalPriceInfoVO _$FinalPriceInfoVOFromJson(Map<String, dynamic> json) {
  return FinalPriceInfoVO()
    ..banner = json['banner'] == null
        ? null
        : BannerVO.fromJson(json['banner'] as Map<String, dynamic>)
    ..priceInfo = json['priceInfo'] == null
        ? null
        : PriceInfo.fromJson(json['priceInfo'] as Map<String, dynamic>)
    ..type = json['type'] as num;
}

Map<String, dynamic> _$FinalPriceInfoVOToJson(FinalPriceInfoVO instance) =>
    <String, dynamic>{
      'banner': instance.banner,
      'priceInfo': instance.priceInfo,
      'type': instance.type,
    };

BannerVO _$BannerVOFromJson(Map<String, dynamic> json) {
  return BannerVO()
    ..logo = json['logo'] as String
    ..title = json['title'] as String
    ..content = json['content'] as String;
}

Map<String, dynamic> _$BannerVOToJson(BannerVO instance) => <String, dynamic>{
      'logo': instance.logo,
      'title': instance.title,
      'content': instance.content,
    };

PriceInfo _$PriceInfoFromJson(Map<String, dynamic> json) {
  return PriceInfo()
    ..finalPrice = json['finalPrice'] == null
        ? null
        : FinalPrice.fromJson(json['finalPrice'] as Map<String, dynamic>)
    ..counterPrice = json['counterPrice'] as String
    ..basicPrice = json['basicPrice'] as String;
}

Map<String, dynamic> _$PriceInfoToJson(PriceInfo instance) => <String, dynamic>{
      'finalPrice': instance.finalPrice,
      'counterPrice': instance.counterPrice,
      'basicPrice': instance.basicPrice,
    };

FinalPrice _$FinalPriceFromJson(Map<String, dynamic> json) {
  return FinalPrice()
    ..prefix = json['prefix'] as String
    ..price = json['price'] as String
    ..suffix = json['suffix'] as String;
}

Map<String, dynamic> _$FinalPriceToJson(FinalPrice instance) =>
    <String, dynamic>{
      'prefix': instance.prefix,
      'price': instance.price,
      'suffix': instance.suffix,
    };
