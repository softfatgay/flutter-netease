// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListModel _$OrderListModelFromJson(Map<String, dynamic> json) {
  return OrderListModel()
    ..nextHasMore = json['nextHasMore'] as bool
    ..lastOrderId = json['lastOrderId'] as num
    ..list = (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : OrderListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderListModelToJson(OrderListModel instance) =>
    <String, dynamic>{
      'nextHasMore': instance.nextHasMore,
      'lastOrderId': instance.lastOrderId,
      'list': instance.list,
    };

OrderListItem _$OrderListItemFromJson(Map<String, dynamic> json) {
  return OrderListItem()
    ..no = json['no'] as String
    ..typeDesc = json['typeDesc'] as String
    ..actualPrice = json['actualPrice'] as num
    ..freightPrice = json['freightPrice'] as num
    ..freshBargainOrderCancelDialogTip =
        json['freshBargainOrderCancelDialogTip'] as String
    ..orderType = json['orderType'] as num
    ..cancelStatus = json['cancelStatus'] as num
    ..invoiceFinishStep = json['invoiceFinishStep'] as num
    ..source = json['source'] as num
    ..subOrderId = json['subOrderId'] as num
    ..id = json['id'] as num
    ..orderStepId = json['orderStepId'] as num
    ..remainTime = json['remainTime'] as num
    ..createTime = json['createTime'] as num
    ..depositType = json['depositType'] as num
    ..invoiceCreateTime = json['invoiceCreateTime'] as num
    ..hasFreshBargain = json['hasFreshBargain'] as bool
    ..moneySavingCardOrder = json['moneySavingCardOrder'] as bool
    ..cancelOption = json['cancelOption'] as bool
    ..bargainFlag = json['bargainFlag'] as bool
    ..pointsOrderFlag = json['pointsOrderFlag'] as bool
    ..exchangeFlag = json['exchangeFlag'] as bool
    ..deleteOption = json['deleteOption'] as bool
    ..hasSpmc = json['hasSpmc'] as bool
    ..crowdfundingFlag = json['crowdfundingFlag'] as bool
    ..returnRecordOption = json['returnRecordOption'] as bool
    ..orderCancelStepOption = json['orderCancelStepOption'] as bool
    ..payOption = json['payOption'] as bool
    ..addrUpdateFlag = json['addrUpdateFlag'] as bool
    ..cancelPayedOption = json['cancelPayedOption'] as bool
    ..packageList = (json['packageList'] as List)
        ?.map((e) => e == null
            ? null
            : PackageListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderListItemToJson(OrderListItem instance) =>
    <String, dynamic>{
      'no': instance.no,
      'typeDesc': instance.typeDesc,
      'actualPrice': instance.actualPrice,
      'freightPrice': instance.freightPrice,
      'freshBargainOrderCancelDialogTip':
          instance.freshBargainOrderCancelDialogTip,
      'orderType': instance.orderType,
      'cancelStatus': instance.cancelStatus,
      'invoiceFinishStep': instance.invoiceFinishStep,
      'source': instance.source,
      'subOrderId': instance.subOrderId,
      'id': instance.id,
      'orderStepId': instance.orderStepId,
      'remainTime': instance.remainTime,
      'createTime': instance.createTime,
      'depositType': instance.depositType,
      'invoiceCreateTime': instance.invoiceCreateTime,
      'hasFreshBargain': instance.hasFreshBargain,
      'moneySavingCardOrder': instance.moneySavingCardOrder,
      'cancelOption': instance.cancelOption,
      'bargainFlag': instance.bargainFlag,
      'pointsOrderFlag': instance.pointsOrderFlag,
      'exchangeFlag': instance.exchangeFlag,
      'deleteOption': instance.deleteOption,
      'hasSpmc': instance.hasSpmc,
      'crowdfundingFlag': instance.crowdfundingFlag,
      'returnRecordOption': instance.returnRecordOption,
      'orderCancelStepOption': instance.orderCancelStepOption,
      'payOption': instance.payOption,
      'addrUpdateFlag': instance.addrUpdateFlag,
      'cancelPayedOption': instance.cancelPayedOption,
      'packageList': instance.packageList,
    };

PackageListItem _$PackageListItemFromJson(Map<String, dynamic> json) {
  return PackageListItem()
    ..isPreSell = json['isPreSell'] as bool
    ..returnOption = json['returnOption'] as bool
    ..specDesc = json['specDesc'] as String
    ..count = json['count'] as num
    ..saleGiftCardFlag = json['saleGiftCardFlag'] as bool
    ..virtualFlag = json['virtualFlag'] as bool
    ..preSellPrice = json['preSellPrice'] as num
    ..commentOption = json['commentOption'] as bool
    ..itemId = json['itemId'] as num
    ..sequence = json['sequence'] as num
    ..serviceProcessOption = json['serviceProcessOption'] as bool
    ..rebateOption = json['rebateOption'] as bool
    ..name = json['name'] as String
    ..addrUpdateFlag = json['addrUpdateFlag'] as bool
    ..orderCartItemId = json['orderCartItemId'] as num
    ..id = json['id'] as num
    ..commentBtnStatus = json['commentBtnStatus'] as num
    ..confirmOption = json['confirmOption'] as bool
    ..deliveryOption = json['deliveryOption'] as bool
    ..skuId = json['skuId'] as num
    ..status = json['status'] as num
    ..picUrlList =
        (json['picUrlList'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$PackageListItemToJson(PackageListItem instance) =>
    <String, dynamic>{
      'isPreSell': instance.isPreSell,
      'returnOption': instance.returnOption,
      'specDesc': instance.specDesc,
      'count': instance.count,
      'saleGiftCardFlag': instance.saleGiftCardFlag,
      'virtualFlag': instance.virtualFlag,
      'preSellPrice': instance.preSellPrice,
      'commentOption': instance.commentOption,
      'itemId': instance.itemId,
      'sequence': instance.sequence,
      'serviceProcessOption': instance.serviceProcessOption,
      'rebateOption': instance.rebateOption,
      'name': instance.name,
      'addrUpdateFlag': instance.addrUpdateFlag,
      'orderCartItemId': instance.orderCartItemId,
      'id': instance.id,
      'commentBtnStatus': instance.commentBtnStatus,
      'confirmOption': instance.confirmOption,
      'deliveryOption': instance.deliveryOption,
      'skuId': instance.skuId,
      'status': instance.status,
      'picUrlList': instance.picUrlList,
    };
