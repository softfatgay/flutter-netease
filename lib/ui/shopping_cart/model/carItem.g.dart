// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarItem _$CarItemFromJson(Map<String, dynamic> json) => CarItem()
  ..id = json['id'] as num?
  ..promId = json['promId'] as num?
  ..promType = json['promType'] as num?
  ..cartItemList = (json['cartItemList'] as List<dynamic>?)
      ?.map((e) => CartItemListItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..promTip = json['promTip'] as String?
  ..promTipList = json['promTipList']
  ..promSatisfy = json['promSatisfy'] as bool?
  ..checked = json['checked'] as bool?
  ..canCheck = json['canCheck'] as bool?
  ..promNotSatisfyType = json['promNotSatisfyType'] as num?
  ..promotionBtn = json['promotionBtn'] as num?
  ..allowCount = json['allowCount'] as int?
  ..type = json['type'] as num?
  ..suitCount = json['suitCount'] as num?
  ..source = json['source'] as num?
  ..addBuyStepList = (json['addBuyStepList'] as List<dynamic>?)
      ?.map((e) => AddBuyStepListItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..giftStepList = (json['giftStepList'] as List<dynamic>?)
      ?.map((e) => AddBuyStepListItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$CarItemToJson(CarItem instance) => <String, dynamic>{
      'id': instance.id,
      'promId': instance.promId,
      'promType': instance.promType,
      'cartItemList': instance.cartItemList,
      'promTip': instance.promTip,
      'promTipList': instance.promTipList,
      'promSatisfy': instance.promSatisfy,
      'checked': instance.checked,
      'canCheck': instance.canCheck,
      'promNotSatisfyType': instance.promNotSatisfyType,
      'promotionBtn': instance.promotionBtn,
      'allowCount': instance.allowCount,
      'type': instance.type,
      'suitCount': instance.suitCount,
      'source': instance.source,
      'addBuyStepList': instance.addBuyStepList,
      'giftStepList': instance.giftStepList,
    };
