// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarItem _$CarItemFromJson(Map<String, dynamic> json) {
  return CarItem()
    ..promId = json['promId'] as num
    ..promType = json['promType'] as num
    ..cartItemList = (json['cartItemList'] as List)
        ?.map((e) => e == null
            ? null
            : CartItemListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..promTip = json['promTip'] as String
    ..promTipList =
        (json['promTipList'] as List)?.map((e) => e as String)?.toList()
    ..promSatisfy = json['promSatisfy'] as bool
    ..checked = json['checked'] as bool
    ..canCheck = json['canCheck'] as bool
    ..promNotSatisfyType = json['promNotSatisfyType'] as num
    ..promotionBtn = json['promotionBtn'] as num;
}

Map<String, dynamic> _$CarItemToJson(CarItem instance) => <String, dynamic>{
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
    };
