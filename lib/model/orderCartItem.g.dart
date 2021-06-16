// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderCartItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCartItem _$OrderCartItemFromJson(Map<String, dynamic> json) {
  return OrderCartItem()
    ..itemId = json['itemId'] as num
    ..skuId = json['skuId'] as num
    ..count = json['count'] as num
    ..originalPrice = json['originalPrice'] as num
    ..retailPrice = json['retailPrice'] as num
    ..actualPrice = json['actualPrice'] as num
    ..totalPrice = json['totalPrice'] as num
    ..subtotalPrice = json['subtotalPrice'] as num
    ..retailPoint = json['retailPoint'] as num
    ..actualPoint = json['actualPoint'] as num
    ..source = json['source'] as num
    ..preSellStatus = json['preSellStatus'] as num
    ..preSellPrice = json['preSellPrice'] as num
    ..preSellVolume = json['preSellVolume'] as num
    ..promType = json['promType'] as num
    ..preemptionStatus = json['preemptionStatus'] as num
    ..type = json['type'] as num
    ..extId = json['extId'] as num
    ..pointsPrice = json['pointsPrice'] as num
    ..picUrl = json['picUrl'] as String
    ..name = json['name'] as String
    ..preSellDesc = json['preSellDesc'] as String
    ..promTag = json['promTag'] as String
    ..id = json['id'] as String
    ..specValueList =
        (json['specValueList'] as List)?.map((e) => e as String)?.toList()
    ..isGift = json['isGift'] as bool
    ..isAddBuy = json['isAddBuy'] as bool
    ..newItemFlag = json['newItemFlag'] as bool
    ..isAreaSupported = json['isAreaSupported'] as bool;
}

Map<String, dynamic> _$OrderCartItemToJson(OrderCartItem instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'skuId': instance.skuId,
      'count': instance.count,
      'originalPrice': instance.originalPrice,
      'retailPrice': instance.retailPrice,
      'actualPrice': instance.actualPrice,
      'totalPrice': instance.totalPrice,
      'subtotalPrice': instance.subtotalPrice,
      'retailPoint': instance.retailPoint,
      'actualPoint': instance.actualPoint,
      'source': instance.source,
      'preSellStatus': instance.preSellStatus,
      'preSellPrice': instance.preSellPrice,
      'preSellVolume': instance.preSellVolume,
      'promType': instance.promType,
      'preemptionStatus': instance.preemptionStatus,
      'type': instance.type,
      'extId': instance.extId,
      'pointsPrice': instance.pointsPrice,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'preSellDesc': instance.preSellDesc,
      'promTag': instance.promTag,
      'id': instance.id,
      'specValueList': instance.specValueList,
      'isGift': instance.isGift,
      'isAddBuy': instance.isAddBuy,
      'newItemFlag': instance.newItemFlag,
      'isAreaSupported': instance.isAreaSupported,
    };
