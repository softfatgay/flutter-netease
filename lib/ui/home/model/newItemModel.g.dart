// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewItemModel _$NewItemModelFromJson(Map<String, dynamic> json) => NewItemModel()
  ..scenePicUrl = json['scenePicUrl'] as String?
  ..simpleDesc = json['simpleDesc'] as String?
  ..retailPrice = json['retailPrice'] as num?
  ..itemTagList = (json['itemTagList'] as List<dynamic>?)
      ?.map((e) => NewItemTagModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$NewItemModelToJson(NewItemModel instance) =>
    <String, dynamic>{
      'scenePicUrl': instance.scenePicUrl,
      'simpleDesc': instance.simpleDesc,
      'retailPrice': instance.retailPrice,
      'itemTagList': instance.itemTagList,
      'id': instance.id,
    };
