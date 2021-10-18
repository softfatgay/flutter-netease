// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodDetailPre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodDetailPre _$GoodDetailPreFromJson(Map<String, dynamic> json) =>
    GoodDetailPre()
      ..item = json['item'] == null
          ? null
          : GoodDetail.fromJson(json['item'] as Map<String, dynamic>)
      ..policyList = (json['policyList'] as List<dynamic>?)
          ?.map((e) => PolicyListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..commentCount = json['commentCount'] as num?
      ..commentWithPicCount = json['commentWithPicCount'] as num?
      ..source = json['source'] as num?;

Map<String, dynamic> _$GoodDetailPreToJson(GoodDetailPre instance) =>
    <String, dynamic>{
      'item': instance.item,
      'policyList': instance.policyList,
      'commentCount': instance.commentCount,
      'commentWithPicCount': instance.commentWithPicCount,
      'source': instance.source,
    };
