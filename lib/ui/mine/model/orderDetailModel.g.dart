// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel()
      ..id = json['id'] as num?
      ..no = json['no'] as String?
      ..createTime = json['createTime'] as num?
      ..remainTime = json['remainTime'] as num?
      ..payOption = json['payOption'] as bool?
      ..cancelOption = json['cancelOption'] as bool?
      ..cancelPayedOption = json['cancelPayedOption'] as bool?
      ..cancelDialog = json['cancelDialog']
      ..payMethodOption = json['payMethodOption'] as bool?
      ..orderCancelStepOption = json['orderCancelStepOption'] as bool?
      ..deleteOption = json['deleteOption'] as bool?
      ..packageList = (json['packageList'] as List<dynamic>?)
          ?.map((e) => PackageListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..itemPrice = json['itemPrice'] as num?
      ..couponPrice = json['couponPrice'] as num?
      ..activityCouponPrice = json['activityCouponPrice'] as num?
      ..giftCardPrice = json['giftCardPrice'] as num?
      ..freightPrice = json['freightPrice'] as num?
      ..spmcFreightPrice = json['spmcFreightPrice']
      ..actualPrice = json['actualPrice'] as num?
      ..showActualPrice = json['showActualPrice'] as String?
      ..realPrice = json['realPrice'] as num?
      ..address = json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>)
      ..payMethod = json['payMethod'] as num?
      ..payDesc = json['payDesc'] as String?
      ..source = json['source'] as num?
      ..indicator = json['indicator'] == null
          ? null
          : Indicator.fromJson(json['indicator'] as Map<String, dynamic>)
      ..activityList = (json['activityList'] as List<dynamic>?)
          ?.map((e) => ActivityListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..activityPriceDesc = json['activityPriceDesc'] as String?
      ..payComlpeteDescList = (json['payComlpeteDescList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..redPacketVO = json['redPacketVO'] == null
          ? null
          : RedPacketVO.fromJson(json['redPacketVO'] as Map<String, dynamic>)
      ..points = json['points'] as num?
      ..freshBargainOrderCancelDialogTip =
          json['freshBargainOrderCancelDialogTip'] as String?;

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'createTime': instance.createTime,
      'remainTime': instance.remainTime,
      'payOption': instance.payOption,
      'cancelOption': instance.cancelOption,
      'cancelPayedOption': instance.cancelPayedOption,
      'cancelDialog': instance.cancelDialog,
      'payMethodOption': instance.payMethodOption,
      'orderCancelStepOption': instance.orderCancelStepOption,
      'deleteOption': instance.deleteOption,
      'packageList': instance.packageList,
      'itemPrice': instance.itemPrice,
      'couponPrice': instance.couponPrice,
      'activityCouponPrice': instance.activityCouponPrice,
      'giftCardPrice': instance.giftCardPrice,
      'freightPrice': instance.freightPrice,
      'spmcFreightPrice': instance.spmcFreightPrice,
      'actualPrice': instance.actualPrice,
      'showActualPrice': instance.showActualPrice,
      'realPrice': instance.realPrice,
      'address': instance.address,
      'payMethod': instance.payMethod,
      'payDesc': instance.payDesc,
      'source': instance.source,
      'indicator': instance.indicator,
      'activityList': instance.activityList,
      'activityPriceDesc': instance.activityPriceDesc,
      'payComlpeteDescList': instance.payComlpeteDescList,
      'redPacketVO': instance.redPacketVO,
      'points': instance.points,
      'freshBargainOrderCancelDialogTip':
          instance.freshBargainOrderCancelDialogTip,
    };

PackageListItem _$PackageListItemFromJson(Map<String, dynamic> json) =>
    PackageListItem()
      ..id = json['id'] as num?
      ..sequence = json['sequence'] as num?
      ..status = json['status'] as num?
      ..skuList = (json['skuList'] as List<dynamic>?)
          ?.map((e) => SkuListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..confirmOption = json['confirmOption'] as bool?
      ..commentOption = json['commentOption'] as bool?
      ..deliveryOption = json['deliveryOption'] as bool?
      ..isPreSell = json['isPreSell'] as bool?
      ..returnOption = json['returnOption'] as bool?
      ..commentBtnStatus = json['commentBtnStatus'] as num?
      ..packageDesc = json['packageDesc'] as String?
      ..isSelfPick = json['isSelfPick'] as bool?
      ..serviceProcessOption = json['serviceProcessOption'] as bool?
      ..allGoodAfterSale = json['allGoodAfterSale'] as bool?
      ..rebateOption = json['rebateOption'] as bool?;

Map<String, dynamic> _$PackageListItemToJson(PackageListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sequence': instance.sequence,
      'status': instance.status,
      'skuList': instance.skuList,
      'confirmOption': instance.confirmOption,
      'commentOption': instance.commentOption,
      'deliveryOption': instance.deliveryOption,
      'isPreSell': instance.isPreSell,
      'returnOption': instance.returnOption,
      'commentBtnStatus': instance.commentBtnStatus,
      'packageDesc': instance.packageDesc,
      'isSelfPick': instance.isSelfPick,
      'serviceProcessOption': instance.serviceProcessOption,
      'allGoodAfterSale': instance.allGoodAfterSale,
      'rebateOption': instance.rebateOption,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address()
  ..name = json['name'] as String?
  ..mobile = json['mobile'] as String?
  ..fullAddress = json['fullAddress'] as String?
  ..provinceName = json['provinceName'] as String?
  ..cityName = json['cityName'] as String?
  ..districtName = json['districtName'] as String?
  ..townName = json['townName'] as String?
  ..address = json['address'] as String?
  ..shipAddressId = json['shipAddressId'] as num?
  ..email = json['email'] as String?
  ..zipCode = json['zipCode'] as String?;

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'fullAddress': instance.fullAddress,
      'provinceName': instance.provinceName,
      'cityName': instance.cityName,
      'districtName': instance.districtName,
      'townName': instance.townName,
      'address': instance.address,
      'shipAddressId': instance.shipAddressId,
      'email': instance.email,
      'zipCode': instance.zipCode,
    };

Indicator _$IndicatorFromJson(Map<String, dynamic> json) => Indicator()
  ..itemPrice = json['itemPrice'] as num?
  ..couponPrice = json['couponPrice'] as num?
  ..freightPrice = json['freightPrice'] as num?
  ..delivery = json['delivery'] as num?
  ..comment = json['comment'] as num?;

Map<String, dynamic> _$IndicatorToJson(Indicator instance) => <String, dynamic>{
      'itemPrice': instance.itemPrice,
      'couponPrice': instance.couponPrice,
      'freightPrice': instance.freightPrice,
      'delivery': instance.delivery,
      'comment': instance.comment,
    };

ActivityListItem _$ActivityListItemFromJson(Map<String, dynamic> json) =>
    ActivityListItem()
      ..tips = json['tips'] as String?
      ..price = json['price'] as num?
      ..type = json['type'] as num?
      ..identifyType = json['identifyType'] as num?;

Map<String, dynamic> _$ActivityListItemToJson(ActivityListItem instance) =>
    <String, dynamic>{
      'tips': instance.tips,
      'price': instance.price,
      'type': instance.type,
      'identifyType': instance.identifyType,
    };

RedPacketVO _$RedPacketVOFromJson(Map<String, dynamic> json) => RedPacketVO()
  ..id = json['id'] as num?
  ..name = json['name'] as String?
  ..price = json['price'] as num?
  ..validStartTime = json['validStartTime'] as num?
  ..validEndTime = json['validEndTime'] as num?
  ..condition = json['condition'] as num?
  ..conditionDesc = json['conditionDesc'] as String?
  ..rule = json['rule'] as String?
  ..redpackageId = json['redpackageId'] as num?
  ..schemeUrl = json['schemeUrl'] as String?;

Map<String, dynamic> _$RedPacketVOToJson(RedPacketVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'validStartTime': instance.validStartTime,
      'validEndTime': instance.validEndTime,
      'condition': instance.condition,
      'conditionDesc': instance.conditionDesc,
      'rule': instance.rule,
      'redpackageId': instance.redpackageId,
      'schemeUrl': instance.schemeUrl,
    };

SkuListItem _$SkuListItemFromJson(Map<String, dynamic> json) => SkuListItem()
  ..itemId = json['itemId'] as num?
  ..skuId = json['skuId'] as num?
  ..orderId = json['orderId'] as num?
  ..packageId = json['packageId'] as num?
  ..picUrl = json['picUrl'] as String?
  ..name = json['name'] as String?
  ..specValueList = (json['specValueList'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList()
  ..count = json['count'] as num?
  ..originPrice = json['originPrice'] as num?
  ..retailPrice = json['retailPrice'] as num?
  ..subtotalPrice = json['subtotalPrice'] as num?
  ..totalPrice = json['totalPrice'] as num?
  ..preSellPrice = json['preSellPrice'] as num?
  ..isGift = json['isGift'] as bool?
  ..isAddBuy = json['isAddBuy'] as bool?;

Map<String, dynamic> _$SkuListItemToJson(SkuListItem instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'skuId': instance.skuId,
      'orderId': instance.orderId,
      'packageId': instance.packageId,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'specValueList': instance.specValueList,
      'count': instance.count,
      'originPrice': instance.originPrice,
      'retailPrice': instance.retailPrice,
      'subtotalPrice': instance.subtotalPrice,
      'totalPrice': instance.totalPrice,
      'preSellPrice': instance.preSellPrice,
      'isGift': instance.isGift,
      'isAddBuy': instance.isAddBuy,
    };
