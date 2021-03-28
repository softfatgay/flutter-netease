// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodDetailPre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodDetailPre _$GoodDetailPreFromJson(Map<String, dynamic> json) {
  return GoodDetailPre()
    ..item = json['item'] == null
        ? null
        : GoodDetail.fromJson(json['item'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GoodDetailPreToJson(GoodDetailPre instance) =>
    <String, dynamic>{
      'item': instance.item,
    };
