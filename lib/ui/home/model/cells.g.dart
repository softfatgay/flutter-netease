// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cells.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cells _$CellsFromJson(Map<String, dynamic> json) => Cells()
  ..subTitleColor = json['subTitleColor'] as String?
  ..rcmdItem = json['rcmdItem'] as bool?
  ..schemeUrl = json['schemeUrl'] as String?
  ..title = json['title'] as String?
  ..picUrl = json['picUrl'] as String?
  ..rcmdSort = json['rcmdSort'] as bool?
  ..itemCnt = (json['itemCnt'] as num?)?.toInt()
  ..itemFrom = (json['itemFrom'] as num?)?.toInt()
  ..subTitle = json['subTitle'] as String?
  ..titleColor = json['titleColor'] as String?
  ..showPrice = json['showPrice'] as bool?
  ..popupUrl = json['popupUrl'] as String?
  ..leftTime = (json['leftTime'] as num?)?.toInt()
  ..id = json['id']
  ..targetUrl = json['targetUrl'] as String?
  ..itemList = (json['itemList'] as List<dynamic>?)
      ?.map((e) => Cells.fromJson(e as Map<String, dynamic>))
      .toList();

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

ItemListItem _$ItemListItemFromJson(Map<String, dynamic> json) => ItemListItem()
  ..primarySkuPreSellStatus = json['primarySkuPreSellStatus'] as num?
  ..picUrl = json['picUrl'] as String?
  ..pieceUnitDesc = json['pieceUnitDesc'] as String?
  ..schemeUrl = json['schemeUrl'] as String?
  ..pieceNum = json['pieceNum'] as num?
  ..primarySkuPreSellPrice = json['primarySkuPreSellPrice'] as num?
  ..id = json['id'] as num?;

Map<String, dynamic> _$ItemListItemToJson(ItemListItem instance) =>
    <String, dynamic>{
      'primarySkuPreSellStatus': instance.primarySkuPreSellStatus,
      'picUrl': instance.picUrl,
      'pieceUnitDesc': instance.pieceUnitDesc,
      'schemeUrl': instance.schemeUrl,
      'pieceNum': instance.pieceNum,
      'primarySkuPreSellPrice': instance.primarySkuPreSellPrice,
      'id': instance.id,
    };
