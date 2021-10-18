// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashSaleModule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashSaleModule _$FlashSaleModuleFromJson(Map<String, dynamic> json) =>
    FlashSaleModule()
      ..activityPrice = json['activityPrice'] as num?
      ..primaryPicUrl = json['primaryPicUrl'] as String?
      ..nextStartTime = json['nextStartTime'] as num?
      ..remainTime = json['remainTime'] as num?
      ..flashSaleScreenId = json['flashSaleScreenId'] as num?
      ..showFlash = json['showFlash'] as bool?
      ..itemList = (json['itemList'] as List<dynamic>?)
          ?.map((e) => FlashSaleModuleItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FlashSaleModuleToJson(FlashSaleModule instance) =>
    <String, dynamic>{
      'activityPrice': instance.activityPrice,
      'primaryPicUrl': instance.primaryPicUrl,
      'nextStartTime': instance.nextStartTime,
      'remainTime': instance.remainTime,
      'flashSaleScreenId': instance.flashSaleScreenId,
      'showFlash': instance.showFlash,
      'itemList': instance.itemList,
    };
