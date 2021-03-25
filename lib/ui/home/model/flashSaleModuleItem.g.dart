// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashSaleModuleItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashSaleModuleItem _$FlashSaleModuleItemFromJson(Map<String, dynamic> json) {
  return FlashSaleModuleItem()
    ..itemId = json['itemId'] as num
    ..originPrice = json['originPrice'] as num
    ..activityPrice = json['activityPrice'] as num
    ..picUrl = json['picUrl'] as String
    ..showPicUrl = json['showPicUrl'] as String;
}

Map<String, dynamic> _$FlashSaleModuleItemToJson(
        FlashSaleModuleItem instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'originPrice': instance.originPrice,
      'activityPrice': instance.activityPrice,
      'picUrl': instance.picUrl,
      'showPicUrl': instance.showPicUrl,
    };
