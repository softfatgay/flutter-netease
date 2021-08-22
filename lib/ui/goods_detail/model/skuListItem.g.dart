// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skuListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkuListItem _$SkuListItemFromJson(Map<String, dynamic> json) {
  return SkuListItem()
    ..id = json['id'] as num
    ..counterPrice = json['counterPrice'] as num
    ..retailPrice = json['retailPrice'] as num
    ..primarySku = json['primarySku'] as bool
    ..sellVolume = json['sellVolume'] as num
    ..noActivitySellVolume = json['noActivitySellVolume'] as num
    ..valid = json['valid'] as bool
    ..baseId = json['baseId'] as num
    ..startTime = json['startTime'] as num
    ..endTime = json['endTime'] as num
    ..name = json['name'] as String
    ..pinPrice = json['pinPrice'] as num
    ..skuNum = json['skuNum'] as num
    ..userNum = json['userNum'] as num
    ..skuId = json['skuId'] as num
    ..itemSkuSpecValueList = (json['itemSkuSpecValueList'] as List)
        ?.map((e) => e == null
            ? null
            : ItemSkuSpecValueListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SkuListItemToJson(SkuListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'counterPrice': instance.counterPrice,
      'retailPrice': instance.retailPrice,
      'primarySku': instance.primarySku,
      'sellVolume': instance.sellVolume,
      'noActivitySellVolume': instance.noActivitySellVolume,
      'valid': instance.valid,
      'baseId': instance.baseId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'name': instance.name,
      'pinPrice': instance.pinPrice,
      'skuNum': instance.skuNum,
      'userNum': instance.userNum,
      'skuId': instance.skuId,
      'itemSkuSpecValueList': instance.itemSkuSpecValueList,
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
