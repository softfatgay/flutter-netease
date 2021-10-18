// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'makeUpCartInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeUpCartInfoModel _$MakeUpCartInfoModelFromJson(Map<String, dynamic> json) =>
    MakeUpCartInfoModel(
      validTimeDesc: json['validTimeDesc'] as String? ?? '',
    )
      ..itemPoolBarVO = json['itemPoolBarVO'] == null
          ? null
          : ItemPoolBarVO.fromJson(
              json['itemPoolBarVO'] as Map<String, dynamic>)
      ..validStartTime = json['validStartTime'] as num?
      ..validEndTime = json['validEndTime'] as num?
      ..addBuyStepList = (json['addBuyStepList'] as List<dynamic>?)
          ?.map((e) => AddBuyStepListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MakeUpCartInfoModelToJson(
        MakeUpCartInfoModel instance) =>
    <String, dynamic>{
      'itemPoolBarVO': instance.itemPoolBarVO,
      'validStartTime': instance.validStartTime,
      'validEndTime': instance.validEndTime,
      'validTimeDesc': instance.validTimeDesc,
      'addBuyStepList': instance.addBuyStepList,
    };

ItemPoolBarVO _$ItemPoolBarVOFromJson(Map<String, dynamic> json) =>
    ItemPoolBarVO()
      ..subtotalPrice = json['subtotalPrice'] as num?
      ..promTip = json['promTip'] as String?;

Map<String, dynamic> _$ItemPoolBarVOToJson(ItemPoolBarVO instance) =>
    <String, dynamic>{
      'subtotalPrice': instance.subtotalPrice,
      'promTip': instance.promTip,
    };
