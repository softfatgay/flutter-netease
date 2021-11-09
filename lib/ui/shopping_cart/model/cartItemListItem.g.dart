// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartItemListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemListItem _$CartItemListItemFromJson(Map<String, dynamic> json) =>
    CartItemListItem()
      ..uniqueKey = json['uniqueKey'] as String?
      ..id = json['id'] as num?
      ..itemId = json['itemId'] as num?
      ..status = json['status'] as num?
      ..skuId = json['skuId'] as num?
      ..sellVolume = json['sellVolume'] as num?
      ..cnt = json['cnt'] as num?
      ..totalPrice = json['totalPrice'] as num?
      ..retailPrice = json['retailPrice'] as num?
      ..actualPrice = json['actualPrice'] as num?
      ..subtotalPrice = json['subtotalPrice'] as num?
      ..preSellStatus = json['preSellStatus'] as num?
      ..preSellPrice = json['preSellPrice'] as num?
      ..preSellVolume = json['preSellVolume'] as num?
      ..type = json['type'] as num?
      ..source = json['source'] as num?
      ..sources =
          (json['sources'] as List<dynamic>?)?.map((e) => e as num).toList()
      ..itemName = json['itemName'] as String?
      ..pic = json['pic'] as String?
      ..extId = json['extId'] as String?
      ..promTag = json['promTag'] as String?
      ..priceReductDesc = json['priceReductDesc'] as String?
      ..valid = json['valid'] as bool?
      ..checked = json['checked'] as bool?
      ..limitPurchaseFlag = json['limitPurchaseFlag'] as bool?
      ..limitPurchaseCount = json['limitPurchaseCount'] as num?
      ..preemptionStatus = json['preemptionStatus'] as num?
      ..canSwitchSpec = json['canSwitchSpec'] as bool?
      ..stepNo = json['stepNo'] as int?
      ..checkExt = json['checkExt']
      ..specList = (json['specList'] as List<dynamic>?)
          ?.map((e) => SpecListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..cartItemTips = (json['cartItemTips'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..timingPromotion = json['timingPromotion'] as String?
      ..finishTip = json['finishTip'] as String?
      ..remainTime = json['remainTime'] as num?
      ..warehouseInfo = json['warehouseInfo'] == null
          ? null
          : WarehouseInfo.fromJson(
              json['warehouseInfo'] as Map<String, dynamic>)
      ..appFreshmanBannerVO = json['appFreshmanBannerVO'] == null
          ? null
          : AppFreshmanBannerVO.fromJson(
              json['appFreshmanBannerVO'] as Map<String, dynamic>);

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
      'limitPurchaseFlag': instance.limitPurchaseFlag,
      'limitPurchaseCount': instance.limitPurchaseCount,
      'preemptionStatus': instance.preemptionStatus,
      'canSwitchSpec': instance.canSwitchSpec,
      'stepNo': instance.stepNo,
      'checkExt': instance.checkExt,
      'specList': instance.specList,
      'cartItemTips': instance.cartItemTips,
      'timingPromotion': instance.timingPromotion,
      'finishTip': instance.finishTip,
      'remainTime': instance.remainTime,
      'warehouseInfo': instance.warehouseInfo,
      'appFreshmanBannerVO': instance.appFreshmanBannerVO,
    };

SpecListItem _$SpecListItemFromJson(Map<String, dynamic> json) => SpecListItem()
  ..specName = json['specName'] as String?
  ..specValue = json['specValue'] as String?;

Map<String, dynamic> _$SpecListItemToJson(SpecListItem instance) =>
    <String, dynamic>{
      'specName': instance.specName,
      'specValue': instance.specValue,
    };

WarehouseInfo _$WarehouseInfoFromJson(Map<String, dynamic> json) =>
    WarehouseInfo()
      ..desc = json['desc'] as String?
      ..type = json['type'] as num?;

Map<String, dynamic> _$WarehouseInfoToJson(WarehouseInfo instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'type': instance.type,
    };

AppFreshmanBannerVO _$AppFreshmanBannerVOFromJson(Map<String, dynamic> json) =>
    AppFreshmanBannerVO()
      ..freshmanDesc = json['freshmanDesc'] as String?
      ..appFreshmanPrice = json['appFreshmanPrice'] as String?;

Map<String, dynamic> _$AppFreshmanBannerVOToJson(
        AppFreshmanBannerVO instance) =>
    <String, dynamic>{
      'freshmanDesc': instance.freshmanDesc,
      'appFreshmanPrice': instance.appFreshmanPrice,
    };
