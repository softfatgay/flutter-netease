// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinItemDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinItemDetailModel _$PinItemDetailModelFromJson(Map<String, dynamic> json) =>
    PinItemDetailModel()
      ..attrList = (json['attrList'] as List<dynamic>?)
          ?.map((e) => AttrListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..itemDetail = json['itemDetail'] as Map<String, dynamic>?
      ..itemInfo = json['itemInfo'] == null
          ? null
          : ItemInfo.fromJson(json['itemInfo'] as Map<String, dynamic>)
      ..skuList = (json['skuList'] as List<dynamic>?)
          ?.map((e) => SkuListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..skuMap = (json['skuMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, SkuMapValue.fromJson(e as Map<String, dynamic>)),
      )
      ..skuSpecList = (json['skuSpecList'] as List<dynamic>?)
          ?.map((e) => SkuSpecListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..shipAddressList = (json['shipAddressList'] as List<dynamic>?)
          ?.map((e) => LocationItemModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..pinOrderCartItemList = (json['pinOrderCartItemList'] as List<dynamic>?)
          ?.map((e) => PinOrderCartItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..skuInfo = json['skuInfo'] == null
          ? null
          : SkuInfo.fromJson(json['skuInfo'] as Map<String, dynamic>)
      ..huoDongId = json['huoDongId'] as num?;

Map<String, dynamic> _$PinItemDetailModelToJson(PinItemDetailModel instance) =>
    <String, dynamic>{
      'attrList': instance.attrList,
      'itemDetail': instance.itemDetail,
      'itemInfo': instance.itemInfo,
      'skuList': instance.skuList,
      'skuMap': instance.skuMap,
      'skuSpecList': instance.skuSpecList,
      'shipAddressList': instance.shipAddressList,
      'pinOrderCartItemList': instance.pinOrderCartItemList,
      'skuInfo': instance.skuInfo,
      'huoDongId': instance.huoDongId,
    };

ItemInfo _$ItemInfoFromJson(Map<String, dynamic> json) => ItemInfo()
  ..commentGoodRates = json['commentGoodRates'] as String?
  ..customType = json['customType'] as num?
  ..deliverTime = json['deliverTime'] as String?
  ..desc = json['desc'] as String?
  ..endTime = json['endTime'] as num?
  ..feeExpLimit = json['feeExpLimit'] as num?
  ..flag = json['flag'] as num?
  ..huoDongTimeOut = json['huoDongTimeOut'] as bool?
  ..id = json['id'] as num?
  ..isRefundPay = json['isRefundPay'] as bool?
  ..itemId = json['itemId'] as num?
  ..joinUserType = json['joinUserType'] as num?
  ..joinUsers = json['joinUsers'] as num?
  ..limitApp = json['limitApp'] as bool?
  ..limitNew = json['limitNew'] as bool?
  ..limitPlatform = json['limitPlatform'] as num?
  ..limitTime = json['limitTime'] as num?
  ..modeType = json['modeType'] as num?
  ..name = json['name'] as String?
  ..numC = json['num'] as num?
  ..originPrice = json['originPrice'] as num?
  ..originTotalPrice = json['originTotalPrice'] as num?
  ..picUrl = json['picUrl'] as String?
  ..postageFree = json['postageFree'] as bool?
  ..prePrice = json['prePrice'] as num?
  ..price = json['price'] as num?
  ..primaryPicUrl = json['primaryPicUrl'] as String?
  ..privateVolume = json['privateVolume'] as bool?
  ..productNo = json['productNo'] as num?
  ..productType = json['productType'] as String?
  ..secondPicUrl = json['secondPicUrl'] as String?
  ..skuList = (json['skuList'] as List<dynamic>?)
      ?.map((e) => SkuListItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..skuPicUrl = json['skuPicUrl'] as String?
  ..soldOut = json['soldOut'] as bool?
  ..startTime = json['startTime'] as num?
  ..startUserType = json['startUserType'] as num?
  ..status = json['status'] as String?
  ..tabId = json['tabId'] as num?
  ..tagList = (json['tagList'] as List<dynamic>?)
      ?.map((e) => TagListItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..tags = json['tags'] as List<dynamic>?
  ..title = json['title'] as String?
  ..totalPrice = json['totalPrice'] as num?
  ..tuanActivityUrl = json['tuanActivityUrl'] as String?
  ..tuanSoldOut = json['tuanSoldOut'] as bool?
  ..useSkuPinPrice = json['useSkuPinPrice'] as bool?
  ..userNum = json['userNum'] as num?;

Map<String, dynamic> _$ItemInfoToJson(ItemInfo instance) => <String, dynamic>{
      'commentGoodRates': instance.commentGoodRates,
      'customType': instance.customType,
      'deliverTime': instance.deliverTime,
      'desc': instance.desc,
      'endTime': instance.endTime,
      'feeExpLimit': instance.feeExpLimit,
      'flag': instance.flag,
      'huoDongTimeOut': instance.huoDongTimeOut,
      'id': instance.id,
      'isRefundPay': instance.isRefundPay,
      'itemId': instance.itemId,
      'joinUserType': instance.joinUserType,
      'joinUsers': instance.joinUsers,
      'limitApp': instance.limitApp,
      'limitNew': instance.limitNew,
      'limitPlatform': instance.limitPlatform,
      'limitTime': instance.limitTime,
      'modeType': instance.modeType,
      'name': instance.name,
      'num': instance.numC,
      'originPrice': instance.originPrice,
      'originTotalPrice': instance.originTotalPrice,
      'picUrl': instance.picUrl,
      'postageFree': instance.postageFree,
      'prePrice': instance.prePrice,
      'price': instance.price,
      'primaryPicUrl': instance.primaryPicUrl,
      'privateVolume': instance.privateVolume,
      'productNo': instance.productNo,
      'productType': instance.productType,
      'secondPicUrl': instance.secondPicUrl,
      'skuList': instance.skuList,
      'skuPicUrl': instance.skuPicUrl,
      'soldOut': instance.soldOut,
      'startTime': instance.startTime,
      'startUserType': instance.startUserType,
      'status': instance.status,
      'tabId': instance.tabId,
      'tagList': instance.tagList,
      'tags': instance.tags,
      'title': instance.title,
      'totalPrice': instance.totalPrice,
      'tuanActivityUrl': instance.tuanActivityUrl,
      'tuanSoldOut': instance.tuanSoldOut,
      'useSkuPinPrice': instance.useSkuPinPrice,
      'userNum': instance.userNum,
    };

TagListItem _$TagListItemFromJson(Map<String, dynamic> json) => TagListItem()
  ..name = json['name'] as String?
  ..type = json['type'] as num?;

Map<String, dynamic> _$TagListItemToJson(TagListItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };

PinOrderCartItem _$PinOrderCartItemFromJson(Map<String, dynamic> json) =>
    PinOrderCartItem()
      ..count = json['count'] as num?
      ..itemId = json['itemId'] as num?
      ..name = json['name'] as String?
      ..originPrice = json['originPrice'] as num?
      ..picUrl = json['picUrl'] as String?
      ..retailPrice = json['retailPrice'] as num?
      ..skuId = json['skuId'] as num?
      ..specValueList = (json['specValueList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..subtotalPrice = json['subtotalPrice'] as num?;

Map<String, dynamic> _$PinOrderCartItemToJson(PinOrderCartItem instance) =>
    <String, dynamic>{
      'count': instance.count,
      'itemId': instance.itemId,
      'name': instance.name,
      'originPrice': instance.originPrice,
      'picUrl': instance.picUrl,
      'retailPrice': instance.retailPrice,
      'skuId': instance.skuId,
      'specValueList': instance.specValueList,
      'subtotalPrice': instance.subtotalPrice,
    };

SkuInfo _$SkuInfoFromJson(Map<String, dynamic> json) => SkuInfo()
  ..counterPrice = json['counterPrice'] as num?
  ..id = json['id'] as num?
  ..maxBuyCount = json['maxBuyCount'] as num?
  ..pinPrice = json['pinPrice'] as num?
  ..primarySku = json['primarySku'] as bool?
  ..retailPrice = json['retailPrice'] as num?
  ..sellVolume = json['sellVolume'] as num?
  ..valid = json['valid'] as bool?;

Map<String, dynamic> _$SkuInfoToJson(SkuInfo instance) => <String, dynamic>{
      'counterPrice': instance.counterPrice,
      'id': instance.id,
      'maxBuyCount': instance.maxBuyCount,
      'pinPrice': instance.pinPrice,
      'primarySku': instance.primarySku,
      'retailPrice': instance.retailPrice,
      'sellVolume': instance.sellVolume,
      'valid': instance.valid,
    };
