// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interstItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterstItemModel _$InterstItemModelFromJson(Map<String, dynamic> json) {
  return InterstItemModel()
    ..categoryCode = json['categoryCode'] as num
    ..categoryName = json['categoryName'] as String
    ..picUrl = json['picUrl'] as String
    ..rank = json['rank'] as num
    ..selectFlag = json['selectFlag'] as bool;
}

Map<String, dynamic> _$InterstItemModelToJson(InterstItemModel instance) =>
    <String, dynamic>{
      'categoryCode': instance.categoryCode,
      'categoryName': instance.categoryName,
      'picUrl': instance.picUrl,
      'rank': instance.rank,
      'selectFlag': instance.selectFlag,
    };
