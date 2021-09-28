// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skuMapValue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkuMapValue _$SkuMapValueFromJson(Map<String, dynamic> json) {
  return SkuMapValue()
    ..id = json['id'] as num
    ..counterPrice = json['counterPrice'] as num
    ..retailPrice = json['retailPrice'] as num
    ..primarySku = json['primarySku'] as bool
    ..sellVolume = json['sellVolume'] as num
    ..noActivitySellVolume = json['noActivitySellVolume'] as num
    ..valid = json['valid'] as bool
    ..itemSkuSpecValueList = (json['itemSkuSpecValueList'] as List)
        ?.map((e) => e == null
            ? null
            : ItemSkuSpecValueListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..preSellStatus = json['preSellStatus'] as num
    ..preSellPrice = json['preSellPrice'] as num
    ..preSellVolume = json['preSellVolume'] as num
    ..preSellDesc = json['preSellDesc']
    ..purchaseAttribute = json['purchaseAttribute'] as num
    ..giftCardFlag = json['giftCardFlag'] as bool
    ..virtualFlag = json['virtualFlag'] as bool
    ..limitedFlag = json['limitedFlag'] as num
    ..promId = json['promId'] as num
    ..preLimitFlag = json['preLimitFlag'] as num
    ..limitPurchaseFlag = json['limitPurchaseFlag'] as bool
    ..limitPurchaseCount = json['limitPurchaseCount'] as num
    ..limitPointCount = json['limitPointCount'] as num
    ..buttonType = json['buttonType'] as num
    ..limitPrice = json['limitPrice'] as num
    ..selected = json['selected'] as bool
    ..promValid = json['promValid'] as bool
    ..hdrkDetailVOList = (json['hdrkDetailVOList'] as List)
        ?.map((e) => e == null
            ? null
            : HdrkDetailVOListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..promotionDesc = json['promotionDesc'] as String
    ..price = json['price'] == null
        ? null
        : PriceModel.fromJson(json['price'] as Map<String, dynamic>)
    ..banner = json['banner'] == null
        ? null
        : BannerModel.fromJson(json['banner'] as Map<String, dynamic>)
    ..itemTagList = (json['itemTagList'] as List)
        ?.map((e) => e == null
            ? null
            : ItemTagListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..points = json['points'] as num
    ..pointsPrice = json['pointsPrice'] as num
    ..pic = json['pic'] as String
    ..preemptionStatus = json['preemptionStatus'] as num
    ..shoppingReward = json['shoppingReward'] == null
        ? null
        : ShoppingReward.fromJson(
            json['shoppingReward'] as Map<String, dynamic>)
    ..skuTitle = json['skuTitle'] as String
    ..calcPrice = json['calcPrice'] as num
    ..desc = json['desc'] as String
    ..skuLimit = json['skuLimit'] as String
    ..operationAttribute = json['operationAttribute'] as num
    ..skuFreight = json['skuFreight'] == null
        ? null
        : SkuFreight.fromJson(json['skuFreight'] as Map<String, dynamic>)
    ..buyTitle = json['buyTitle'] == null
        ? null
        : BuyTitle.fromJson(json['buyTitle'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SkuMapValueToJson(SkuMapValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'counterPrice': instance.counterPrice,
      'retailPrice': instance.retailPrice,
      'primarySku': instance.primarySku,
      'sellVolume': instance.sellVolume,
      'noActivitySellVolume': instance.noActivitySellVolume,
      'valid': instance.valid,
      'itemSkuSpecValueList': instance.itemSkuSpecValueList,
      'preSellStatus': instance.preSellStatus,
      'preSellPrice': instance.preSellPrice,
      'preSellVolume': instance.preSellVolume,
      'preSellDesc': instance.preSellDesc,
      'purchaseAttribute': instance.purchaseAttribute,
      'giftCardFlag': instance.giftCardFlag,
      'virtualFlag': instance.virtualFlag,
      'limitedFlag': instance.limitedFlag,
      'promId': instance.promId,
      'preLimitFlag': instance.preLimitFlag,
      'limitPurchaseFlag': instance.limitPurchaseFlag,
      'limitPurchaseCount': instance.limitPurchaseCount,
      'limitPointCount': instance.limitPointCount,
      'buttonType': instance.buttonType,
      'limitPrice': instance.limitPrice,
      'selected': instance.selected,
      'promValid': instance.promValid,
      'hdrkDetailVOList': instance.hdrkDetailVOList,
      'promotionDesc': instance.promotionDesc,
      'price': instance.price,
      'banner': instance.banner,
      'itemTagList': instance.itemTagList,
      'points': instance.points,
      'pointsPrice': instance.pointsPrice,
      'pic': instance.pic,
      'preemptionStatus': instance.preemptionStatus,
      'shoppingReward': instance.shoppingReward,
      'skuTitle': instance.skuTitle,
      'calcPrice': instance.calcPrice,
      'desc': instance.desc,
      'skuLimit': instance.skuLimit,
      'operationAttribute': instance.operationAttribute,
      'skuFreight': instance.skuFreight,
      'buyTitle': instance.buyTitle,
    };

ItemSkuSpecValueListItem _$ItemSkuSpecValueListItemFromJson(
    Map<String, dynamic> json) {
  return ItemSkuSpecValueListItem()
    ..id = json['id'] as num
    ..skuId = json['skuId'] as num
    ..skuSpecId = json['skuSpecId'] as num
    ..skuSpecValueId = json['skuSpecValueId'] as num
    ..skuSpec = json['skuSpec'] == null
        ? null
        : SkuSpec.fromJson(json['skuSpec'] as Map<String, dynamic>)
    ..skuSpecValue = json['skuSpecValue'] == null
        ? null
        : SkuSpecValue.fromJson(json['skuSpecValue'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ItemSkuSpecValueListItemToJson(
        ItemSkuSpecValueListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'skuId': instance.skuId,
      'skuSpecId': instance.skuSpecId,
      'skuSpecValueId': instance.skuSpecValueId,
      'skuSpec': instance.skuSpec,
      'skuSpecValue': instance.skuSpecValue,
    };

SkuFreight _$SkuFreightFromJson(Map<String, dynamic> json) {
  return SkuFreight()
    ..title = json['title'] as String
    ..freightInfo = json['freightInfo'] as String
    ..vipFreightInfo = json['vipFreightInfo'] as String
    ..policyList = (json['policyList'] as List)
        ?.map((e) => e == null
            ? null
            : PolicyListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = json['type'] as num;
}

Map<String, dynamic> _$SkuFreightToJson(SkuFreight instance) =>
    <String, dynamic>{
      'title': instance.title,
      'freightInfo': instance.freightInfo,
      'vipFreightInfo': instance.vipFreightInfo,
      'policyList': instance.policyList,
      'type': instance.type,
    };

PolicyListItem _$PolicyListItemFromJson(Map<String, dynamic> json) {
  return PolicyListItem()
    ..id = json['id'] as num
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..distributionArea = json['distributionArea'] as String;
}

Map<String, dynamic> _$PolicyListItemToJson(PolicyListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'distributionArea': instance.distributionArea,
    };

BuyTitle _$BuyTitleFromJson(Map<String, dynamic> json) {
  return BuyTitle()
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String;
}

Map<String, dynamic> _$BuyTitleToJson(BuyTitle instance) => <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
    };
