// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentsItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsItem _$CommentsItemFromJson(Map<String, dynamic> json) => CommentsItem()
  ..id = json['id'] as num?
  ..itemId = json['itemId'] as num?
  ..skuId = json['skuId'] as num?
  ..packageId = json['packageId'] as num?
  ..itemName = json['itemName'] as String?
  ..itemIconUrl = json['itemIconUrl'] as String?
  ..skuInfo =
      (json['skuInfo'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..frontUserName = json['frontUserName'] as String?
  ..frontUserAvatar = json['frontUserAvatar'] as String?
  ..content = json['content'] as String?
  ..createTime = json['createTime'] as num?
  ..picList =
      (json['picList'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..memberLevel = json['memberLevel'] as num?
  ..starVO = json['starVO'] == null
      ? null
      : StarVO.fromJson(json['starVO'] as Map<String, dynamic>)
  ..star = json['star'] as num?
  ..commentItemTagVO = json['commentItemTagVO'] == null
      ? null
      : CommentItemTagVO.fromJson(
          json['commentItemTagVO'] as Map<String, dynamic>);

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
      'frontUserAvatar': instance.frontUserAvatar,
      'content': instance.content,
      'createTime': instance.createTime,
      'picList': instance.picList,
      'memberLevel': instance.memberLevel,
      'starVO': instance.starVO,
      'star': instance.star,
      'commentItemTagVO': instance.commentItemTagVO,
    };

StarVO _$StarVOFromJson(Map<String, dynamic> json) =>
    StarVO()..star = json['star'] as num?;

Map<String, dynamic> _$StarVOToJson(StarVO instance) => <String, dynamic>{
      'star': instance.star,
    };

CommentItemTagVO _$CommentItemTagVOFromJson(Map<String, dynamic> json) =>
    CommentItemTagVO()
      ..type = json['type'] as num?
      ..schemeUrl = json['schemeUrl'] as String?;

Map<String, dynamic> _$CommentItemTagVOToJson(CommentItemTagVO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'schemeUrl': instance.schemeUrl,
    };
