// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newItemsDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewItemsDataModel _$NewItemsDataModelFromJson(Map<String, dynamic> json) =>
    NewItemsDataModel()
      ..newItems = json['newItems'] == null
          ? null
          : NewItems.fromJson(json['newItems'] as Map<String, dynamic>)
      ..editorRecommendItems = (json['editorRecommendItems'] as List<dynamic>?)
          ?.map((e) => ItemListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..zcItems = (json['zcItems'] as List<dynamic>?)
          ?.map((e) => ZcItems.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$NewItemsDataModelToJson(NewItemsDataModel instance) =>
    <String, dynamic>{
      'newItems': instance.newItems,
      'editorRecommendItems': instance.editorRecommendItems,
      'zcItems': instance.zcItems,
    };

NewItems _$NewItemsFromJson(Map<String, dynamic> json) => NewItems()
  ..hasMore = json['hasMore'] as bool?
  ..categoryL1List = (json['categoryL1List'] as List<dynamic>?)
      ?.map((e) => CategoryL1ListItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..tagList = (json['tagList'] as List<dynamic>?)
      ?.map((e) => TagListName.fromJson(e as Map<String, dynamic>))
      .toList()
  ..itemList = (json['itemList'] as List<dynamic>?)
      ?.map((e) => ItemListItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$NewItemsToJson(NewItems instance) => <String, dynamic>{
      'hasMore': instance.hasMore,
      'categoryL1List': instance.categoryL1List,
      'tagList': instance.tagList,
      'itemList': instance.itemList,
    };

TagListName _$TagListNameFromJson(Map<String, dynamic> json) => TagListName()
  ..id = json['id'] as num?
  ..tagName = json['tagName'] as String?;

Map<String, dynamic> _$TagListNameToJson(TagListName instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
    };

ZcItems _$ZcItemsFromJson(Map<String, dynamic> json) => ZcItems()
  ..picUrl = json['picUrl'] as String?
  ..minPrice = json['minPrice'] as num?
  ..name = json['name'] as String?
  ..description = json['description'] as String?
  ..actualAmountPercent = json['actualAmountPercent'] as num?
  ..id = json['id'] as num?
  ..actualNum = json['actualNum'] as num?;

Map<String, dynamic> _$ZcItemsToJson(ZcItems instance) => <String, dynamic>{
      'picUrl': instance.picUrl,
      'minPrice': instance.minPrice,
      'name': instance.name,
      'description': instance.description,
      'actualAmountPercent': instance.actualAmountPercent,
      'id': instance.id,
      'actualNum': instance.actualNum,
    };
