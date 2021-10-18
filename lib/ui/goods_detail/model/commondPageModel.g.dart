// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commondPageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommondPageModel _$CommondPageModelFromJson(Map<String, dynamic> json) =>
    CommondPageModel()
      ..pagination = json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
      ..result = (json['result'] as List<dynamic>?)
          ?.map((e) => ResultItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CommondPageModelToJson(CommondPageModel instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'result': instance.result,
    };

ResultItem _$ResultItemFromJson(Map<String, dynamic> json) => ResultItem()
  ..skuInfo =
      (json['skuInfo'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..frontUserName = json['frontUserName'] as String?
  ..content = json['content'] as String?
  ..createTime = json['createTime'] as num?
  ..picList =
      (json['picList'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..frontUserAvatar = json['frontUserAvatar'] as String?
  ..commentReplyVO = json['commentReplyVO'] == null
      ? null
      : CommentReplyVO.fromJson(json['commentReplyVO'] as Map<String, dynamic>)
  ..memberLevel = json['memberLevel'] as num?
  ..appendCommentVO = json['appendCommentVO'] == null
      ? null
      : AppendCommentVO.fromJson(
          json['appendCommentVO'] as Map<String, dynamic>)
  ..star = json['star'] as num?
  ..itemId = json['itemId'] as num?
  ..commentItemTagVO = json['commentItemTagVO'] == null
      ? null
      : CommentItemTagVO.fromJson(
          json['commentItemTagVO'] as Map<String, dynamic>);

Map<String, dynamic> _$ResultItemToJson(ResultItem instance) =>
    <String, dynamic>{
      'skuInfo': instance.skuInfo,
      'frontUserName': instance.frontUserName,
      'content': instance.content,
      'createTime': instance.createTime,
      'picList': instance.picList,
      'frontUserAvatar': instance.frontUserAvatar,
      'commentReplyVO': instance.commentReplyVO,
      'memberLevel': instance.memberLevel,
      'appendCommentVO': instance.appendCommentVO,
      'star': instance.star,
      'itemId': instance.itemId,
      'commentItemTagVO': instance.commentItemTagVO,
    };

CommentReplyVO _$CommentReplyVOFromJson(Map<String, dynamic> json) =>
    CommentReplyVO()..replyContent = json['replyContent'] as String?;

Map<String, dynamic> _$CommentReplyVOToJson(CommentReplyVO instance) =>
    <String, dynamic>{
      'replyContent': instance.replyContent,
    };

AppendCommentVO _$AppendCommentVOFromJson(Map<String, dynamic> json) =>
    AppendCommentVO()
      ..content = json['content'] as String?
      ..createTime = json['createTime'] as num?
      ..picList =
          (json['picList'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$AppendCommentVOToJson(AppendCommentVO instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createTime': instance.createTime,
      'picList': instance.picList,
    };

CommentItemTagVO _$CommentItemTagVOFromJson(Map<String, dynamic> json) =>
    CommentItemTagVO()
      ..schemeUrl = json['schemeUrl'] as String?
      ..type = json['type'] as num?;

Map<String, dynamic> _$CommentItemTagVOToJson(CommentItemTagVO instance) =>
    <String, dynamic>{
      'schemeUrl': instance.schemeUrl,
      'type': instance.type,
    };

Praise _$PraiseFromJson(Map<String, dynamic> json) => Praise()
  ..goodCmtRate = json['goodCmtRate'] as String?
  ..star = json['star'] as num?
  ..defGoodCmtCnt = json['defGoodCmtCnt'] as num?;

Map<String, dynamic> _$PraiseToJson(Praise instance) => <String, dynamic>{
      'goodCmtRate': instance.goodCmtRate,
      'star': instance.star,
      'defGoodCmtCnt': instance.defGoodCmtCnt,
    };
