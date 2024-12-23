// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeRecommendList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRecommendList _$HomeRecommendListFromJson(Map<String, dynamic> json) =>
    HomeRecommendList()
      ..itemList = (json['itemList'] as List<dynamic>?)
          ?.map((e) => ItemListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..rcmdVer = json['rcmdVer'] as String
      ..itemIdsStr = json['itemIdsStr'] as String
      ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$HomeRecommendListToJson(HomeRecommendList instance) =>
    <String, dynamic>{
      'itemList': instance.itemList,
      'rcmdVer': instance.rcmdVer,
      'itemIdsStr': instance.itemIdsStr,
      'hasMore': instance.hasMore,
    };
