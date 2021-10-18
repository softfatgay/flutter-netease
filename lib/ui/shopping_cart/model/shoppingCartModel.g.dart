// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoppingCartModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingCartModel _$ShoppingCartModelFromJson(Map<String, dynamic> json) {
  return ShoppingCartModel()
    ..totalPrice = json['totalPrice'] as num
    ..promotionPrice = json['promotionPrice'] as num
    ..actualPrice = json['actualPrice'] as num
    ..totalPoint = json['totalPoint'] as num
    ..actualPoint = json['actualPoint'] as num
    ..postageVO = json['postageVO'] == null
        ? null
        : PostageVO.fromJson(json['postageVO'] as Map<String, dynamic>)
    ..cartGroupList = (json['cartGroupList'] as List)
        ?.map((e) =>
            e == null ? null : CarItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..invalidCartGroupList = (json['invalidCartGroupList'] as List)
        ?.map((e) =>
            e == null ? null : CarItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ShoppingCartModelToJson(ShoppingCartModel instance) =>
    <String, dynamic>{
      'totalPrice': instance.totalPrice,
      'promotionPrice': instance.promotionPrice,
      'actualPrice': instance.actualPrice,
      'totalPoint': instance.totalPoint,
      'actualPoint': instance.actualPoint,
      'postageVO': instance.postageVO,
      'cartGroupList': instance.cartGroupList,
      'invalidCartGroupList': instance.invalidCartGroupList,
    };
