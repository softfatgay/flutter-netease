import 'package:flutter_app/model/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commondPageModel.g.dart';

@JsonSerializable()
class CommondPageModel {
  Pagination pagination;
  List<ResultItem> result;

  CommondPageModel();

  factory CommondPageModel.fromJson(Map<String, dynamic> json) =>
      _$CommondPageModelFromJson(json);
}

@JsonSerializable()
class ResultItem {
  List<String> skuInfo;
  String frontUserName;
  String content;
  num createTime;
  List<String> picList;
  String frontUserAvatar;
  CommentReplyVO commentReplyVO;
  num memberLevel;
  AppendCommentVO appendCommentVO;
  num star;
  num itemId;
  CommentItemTagVO commentItemTagVO;

  ResultItem();

  factory ResultItem.fromJson(Map<String, dynamic> json) =>
      _$ResultItemFromJson(json);
}

@JsonSerializable()
class CommentReplyVO {
  String replyContent;

  CommentReplyVO();

  factory CommentReplyVO.fromJson(Map<String, dynamic> json) =>
      _$CommentReplyVOFromJson(json);
}

@JsonSerializable()
class AppendCommentVO {
  String content;
  num createTime;
  List<String> picList;

  AppendCommentVO();

  factory AppendCommentVO.fromJson(Map<String, dynamic> json) =>
      _$AppendCommentVOFromJson(json);
}

@JsonSerializable()
class CommentItemTagVO {
  String schemeUrl;
  num type;

  CommentItemTagVO();

  factory CommentItemTagVO.fromJson(Map<String, dynamic> json) =>
      _$CommentItemTagVOFromJson(json);
}

@JsonSerializable()
class Praise {
  String goodCmtRate;
  num star;
  num defGoodCmtCnt;

  Praise();

  factory Praise.fromJson(Map<String, dynamic> json) => _$PraiseFromJson(json);
}
