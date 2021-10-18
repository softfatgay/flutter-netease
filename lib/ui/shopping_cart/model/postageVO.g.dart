// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postageVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostageVO _$PostageVOFromJson(Map<String, dynamic> json) => PostageVO()
  ..showTip = json['showTip'] as bool?
  ..postFree = json['postFree'] as bool?
  ..priceRangeId = json['priceRangeId'] as num?
  ..leftPostFreePrice = json['leftPostFreePrice'] as num?
  ..postageTip = json['postageTip'] as String?;

Map<String, dynamic> _$PostageVOToJson(PostageVO instance) => <String, dynamic>{
      'showTip': instance.showTip,
      'postFree': instance.postFree,
      'priceRangeId': instance.priceRangeId,
      'leftPostFreePrice': instance.leftPostFreePrice,
      'postageTip': instance.postageTip,
    };
