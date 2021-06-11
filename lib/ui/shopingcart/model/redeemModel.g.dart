// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redeemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedeemModel _$RedeemModelFromJson(Map<String, dynamic> json) {
  return RedeemModel()
    ..cartGroupList = (json['cartGroupList'] as List)
        ?.map((e) => e == null
            ? null
            : CartGroupListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalPrice = json['totalPrice'] as num
    ..promotionPrice = json['promotionPrice'] as num
    ..actualPrice = json['actualPrice'] as num;
}

Map<String, dynamic> _$RedeemModelToJson(RedeemModel instance) =>
    <String, dynamic>{
      'cartGroupList': instance.cartGroupList,
      'totalPrice': instance.totalPrice,
      'promotionPrice': instance.promotionPrice,
      'actualPrice': instance.actualPrice,
    };

CartGroupListItem _$CartGroupListItemFromJson(Map<String, dynamic> json) {
  return CartGroupListItem()
    ..promId = json['promId'] as num
    ..promType = json['promType'] as num
    ..promTip = json['promTip'] as String
    ..allowCount = json['allowCount'] as num
    ..addBuyStepList = (json['addBuyStepList'] as List)
        ?.map((e) => e == null
            ? null
            : AddBuyStepListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CartGroupListItemToJson(CartGroupListItem instance) =>
    <String, dynamic>{
      'promId': instance.promId,
      'promType': instance.promType,
      'promTip': instance.promTip,
      'allowCount': instance.allowCount,
      'addBuyStepList': instance.addBuyStepList,
    };

AddBuyStepListItem _$AddBuyStepListItemFromJson(Map<String, dynamic> json) {
  return AddBuyStepListItem()
    ..stepNo = json['stepNo'] as num
    ..title = json['title'] as String
    ..isSatisfy = json['isSatisfy'] as bool
    ..addBuyItemList = (json['addBuyItemList'] as List)
        ?.map((e) => e == null
            ? null
            : AddBuyItemListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AddBuyStepListItemToJson(AddBuyStepListItem instance) =>
    <String, dynamic>{
      'stepNo': instance.stepNo,
      'title': instance.title,
      'isSatisfy': instance.isSatisfy,
      'addBuyItemList': instance.addBuyItemList,
    };

AddBuyItemListItem _$AddBuyItemListItemFromJson(Map<String, dynamic> json) {
  return AddBuyItemListItem()
    ..uniqueKey = json['uniqueKey'] as String
    ..id = json['id'] as num
    ..itemId = json['itemId'] as num
    ..itemName = json['itemName'] as String
    ..status = json['status'] as num
    ..pic = json['pic'] as String
    ..skuId = json['skuId'] as num
    ..valid = json['valid'] as bool
    ..sellVolume = json['sellVolume'] as num
    ..specList = (json['specList'] as List)
        ?.map((e) =>
            e == null ? null : SpecListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..cnt = json['cnt'] as num
    ..totalPrice = json['totalPrice'] as num
    ..retailPrice = json['retailPrice'] as num
    ..actualPrice = json['actualPrice'] as num
    ..subtotalPrice = json['subtotalPrice'] as num
    ..extId = json['extId'] as String
    ..checked = json['checked'] as bool;
}

Map<String, dynamic> _$AddBuyItemListItemToJson(AddBuyItemListItem instance) =>
    <String, dynamic>{
      'uniqueKey': instance.uniqueKey,
      'id': instance.id,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'status': instance.status,
      'pic': instance.pic,
      'skuId': instance.skuId,
      'valid': instance.valid,
      'sellVolume': instance.sellVolume,
      'specList': instance.specList,
      'cnt': instance.cnt,
      'totalPrice': instance.totalPrice,
      'retailPrice': instance.retailPrice,
      'actualPrice': instance.actualPrice,
      'subtotalPrice': instance.subtotalPrice,
      'extId': instance.extId,
      'checked': instance.checked,
    };
