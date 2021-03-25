// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodItem _$GoodItemFromJson(Map<String, dynamic> json) {
  return GoodItem()
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
    ..itemTagList = (json['itemTagList'] as List)
        ?.map((e) =>
            e == null ? null : ItemTagItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..listPromBanner = json['listPromBanner'] == null
        ? null
        : ListPromBanner.fromJson(
            json['listPromBanner'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GoodItemToJson(GoodItem instance) => <String, dynamic>{
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
      'itemTagList': instance.itemTagList,
      'listPromBanner': instance.listPromBanner,
    };
