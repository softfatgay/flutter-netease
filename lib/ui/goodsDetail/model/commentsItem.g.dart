// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentsItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsItem _$CommentsItemFromJson(Map<String, dynamic> json) {
  return CommentsItem()
    ..id = json['id'] as num
    ..itemId = json['itemId'] as num
    ..skuId = json['skuId'] as num
    ..packageId = json['packageId'] as num
    ..itemName = json['itemName'] as String
    ..itemIconUrl = json['itemIconUrl'] as String
    ..skuInfo = (json['skuInfo'] as List)?.map((e) => e as String)?.toList()
    ..frontUserName = json['frontUserName'] as String
    ..content = json['content'] as String
    ..createTime = json['createTime'] as num
    ..picList = (json['picList'] as List)?.map((e) => e as String)?.toList()
    ..memberLevel = json['memberLevel'] as num
    ..starVO = json['starVO'] == null
        ? null
        : StarVO.fromJson(json['starVO'] as Map<String, dynamic>)
    ..star = json['star'] as num;
}

Map<String, dynamic> _$CommentsItemToJson(CommentsItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'skuId': instance.skuId,
      'packageId': instance.packageId,
      'itemName': instance.itemName,
      'itemIconUrl': instance.itemIconUrl,
      'skuInfo': instance.skuInfo,
      'frontUserName': instance.frontUserName,
      'content': instance.content,
      'createTime': instance.createTime,
      'picList': instance.picList,
      'memberLevel': instance.memberLevel,
      'starVO': instance.starVO,
      'star': instance.star,
    };

StarVO _$StarVOFromJson(Map<String, dynamic> json) {
  return StarVO()..star = json['star'] as num;
}

Map<String, dynamic> _$StarVOToJson(StarVO instance) => <String, dynamic>{
      'star': instance.star,
    };
