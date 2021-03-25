// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyNow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyNow _$BuyNowFromJson(Map<String, dynamic> json) {
  return BuyNow()
    ..itemId = json['itemId'] as num
    ..purchaseAttribute = json['purchaseAttribute'] as num
    ..countPrice = json['countPrice'] as num
    ..retailPrice = json['retailPrice'] as num
    ..primarySkuId = json['primarySkuId'] as num
    ..itemName = json['itemName'] as String
    ..itemUrl = json['itemUrl'] as String
    ..valid = json['valid'] as bool;
}

Map<String, dynamic> _$BuyNowToJson(BuyNow instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'purchaseAttribute': instance.purchaseAttribute,
      'countPrice': instance.countPrice,
      'retailPrice': instance.retailPrice,
      'primarySkuId': instance.primarySkuId,
      'itemName': instance.itemName,
      'itemUrl': instance.itemUrl,
      'valid': instance.valid,
    };
