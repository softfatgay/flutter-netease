// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cells.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cells _$CellsFromJson(Map<String, dynamic> json) {
  return Cells()
    ..subTitleColor = json['subTitleColor'] as String
    ..rcmdItem = json['rcmdItem'] as bool
    ..schemeUrl = json['schemeUrl'] as String
    ..title = json['title'] as String
    ..picUrl = json['picUrl'] as String
    ..rcmdSort = json['rcmdSort'] as bool
    ..itemCnt = json['itemCnt'] as int
    ..itemFrom = json['itemFrom'] as int
    ..subTitle = json['subTitle'] as String
    ..titleColor = json['titleColor'] as String
    ..showPrice = json['showPrice'] as bool
    ..popupUrl = json['popupUrl'] as String
    ..leftTime = json['leftTime'] as int
    ..id = json['id'] as String
    ..targetUrl = json['targetUrl'] as String
    ..itemList = (json['itemList'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CellsToJson(Cells instance) => <String, dynamic>{
      'subTitleColor': instance.subTitleColor,
      'rcmdItem': instance.rcmdItem,
      'schemeUrl': instance.schemeUrl,
      'title': instance.title,
      'picUrl': instance.picUrl,
      'rcmdSort': instance.rcmdSort,
      'itemCnt': instance.itemCnt,
      'itemFrom': instance.itemFrom,
      'subTitle': instance.subTitle,
      'titleColor': instance.titleColor,
      'showPrice': instance.showPrice,
      'popupUrl': instance.popupUrl,
      'leftTime': instance.leftTime,
      'id': instance.id,
      'targetUrl': instance.targetUrl,
      'itemList': instance.itemList,
    };
