// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemListItem _$ItemListItemFromJson(Map<String, dynamic> json) {
  return ItemListItem()
    ..id = json['id'] as num
    ..listPicUrl = json['listPicUrl'] as String
    ..name = json['name'] as String
    ..seoTitle = json['seoTitle'] as String
    ..simpleDesc = json['simpleDesc'] as String
    ..primaryPicUrl = json['primaryPicUrl'] as String
    ..productPlace = json['productPlace'] as String
    ..counterPrice = json['counterPrice'] as num
    ..primarySkuId = json['primarySkuId'] as num
    ..retailPrice = json['retailPrice'] as num
    ..status = json['status'] as num
    ..soldOut = json['soldOut'] as bool
    ..underShelf = json['underShelf'] as bool
    ..scenePicUrl = json['scenePicUrl'] as String
    ..promTag = json['promTag'] as String
    ..goodCmtRate = json['goodCmtRate'] as String
    ..hotSaleListBottomInfo = json['hotSaleListBottomInfo'] == null
        ? null
        : HotSaleListBottomInfo.fromJson(
            json['hotSaleListBottomInfo'] as Map<String, dynamic>)
    ..itemTagList = (json['itemTagList'] as List)
        ?.map((e) => e == null
            ? null
            : ItemTagListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..listPromBanner = json['listPromBanner'] == null
        ? null
        : ListPromBanner.fromJson(
            json['listPromBanner'] as Map<String, dynamic>)
    ..skuSpecList = (json['skuSpecList'] as List)
        ?.map((e) => e == null
            ? null
            : SkuSpecListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ItemListItemToJson(ItemListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listPicUrl': instance.listPicUrl,
      'name': instance.name,
      'seoTitle': instance.seoTitle,
      'simpleDesc': instance.simpleDesc,
      'primaryPicUrl': instance.primaryPicUrl,
      'productPlace': instance.productPlace,
      'counterPrice': instance.counterPrice,
      'primarySkuId': instance.primarySkuId,
      'retailPrice': instance.retailPrice,
      'status': instance.status,
      'soldOut': instance.soldOut,
      'underShelf': instance.underShelf,
      'scenePicUrl': instance.scenePicUrl,
      'promTag': instance.promTag,
      'goodCmtRate': instance.goodCmtRate,
      'hotSaleListBottomInfo': instance.hotSaleListBottomInfo,
      'itemTagList': instance.itemTagList,
      'listPromBanner': instance.listPromBanner,
      'skuSpecList': instance.skuSpecList,
    };
