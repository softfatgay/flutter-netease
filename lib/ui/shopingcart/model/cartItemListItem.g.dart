// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartItemListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemListItem _$CartItemListItemFromJson(Map<String, dynamic> json) {
  return CartItemListItem()
    ..uniqueKey = json['uniqueKey'] as String
    ..id = json['id'] as num
    ..itemId = json['itemId'] as num
    ..status = json['status'] as num
    ..skuId = json['skuId'] as num
    ..sellVolume = json['sellVolume'] as num
    ..cnt = json['cnt'] as num
    ..totalPrice = json['totalPrice'] as num
    ..retailPrice = json['retailPrice'] as num
    ..actualPrice = json['actualPrice'] as num
    ..subtotalPrice = json['subtotalPrice'] as num
    ..preSellStatus = json['preSellStatus'] as num
    ..preSellPrice = json['preSellPrice'] as num
    ..preSellVolume = json['preSellVolume'] as num
    ..type = json['type'] as num
    ..source = json['source'] as num
    ..sources = (json['sources'] as List)?.map((e) => e as num)?.toList()
    ..itemName = json['itemName'] as String
    ..pic = json['pic'] as String
    ..extId = json['extId'] as String
    ..promTag = json['promTag'] as String
    ..priceReductDesc = json['priceReductDesc'] as String
    ..valid = json['valid'] as bool
    ..checked = json['checked'] as bool
    ..stepNo = json['stepNo'] as int
    ..checkExt = json['checkExt']
    ..specList = (json['specList'] as List)
        ?.map((e) =>
            e == null ? null : SpecListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..cartItemTips =
        (json['cartItemTips'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CartItemListItemToJson(CartItemListItem instance) =>
    <String, dynamic>{
      'uniqueKey': instance.uniqueKey,
      'id': instance.id,
      'itemId': instance.itemId,
      'status': instance.status,
      'skuId': instance.skuId,
      'sellVolume': instance.sellVolume,
      'cnt': instance.cnt,
      'totalPrice': instance.totalPrice,
      'retailPrice': instance.retailPrice,
      'actualPrice': instance.actualPrice,
      'subtotalPrice': instance.subtotalPrice,
      'preSellStatus': instance.preSellStatus,
      'preSellPrice': instance.preSellPrice,
      'preSellVolume': instance.preSellVolume,
      'type': instance.type,
      'source': instance.source,
      'sources': instance.sources,
      'itemName': instance.itemName,
      'pic': instance.pic,
      'extId': instance.extId,
      'promTag': instance.promTag,
      'priceReductDesc': instance.priceReductDesc,
      'valid': instance.valid,
      'checked': instance.checked,
      'stepNo': instance.stepNo,
      'checkExt': instance.checkExt,
      'specList': instance.specList,
      'cartItemTips': instance.cartItemTips,
    };

SpecListItem _$SpecListItemFromJson(Map<String, dynamic> json) {
  return SpecListItem()
    ..specName = json['specName'] as String
    ..specValue = json['specValue'] as String;
}

Map<String, dynamic> _$SpecListItemToJson(SpecListItem instance) =>
    <String, dynamic>{
      'specName': instance.specName,
      'specValue': instance.specValue,
    };
