import 'package:json_annotation/json_annotation.dart';

part 'commentsItem.g.dart';

@JsonSerializable()
class CommentsItem {
  num? id;
  num? itemId;
  num? skuId;
  num? packageId;
  String? itemName;
  String? itemIconUrl;
  List<String>? skuInfo;
  String? frontUserName;
  String? frontUserAvatar;

  String? content;

  num? createTime;

  List<String>? picList;
  num? memberLevel;
  StarVO? starVO;
  num? star;

  CommentItemTagVO? commentItemTagVO;

  CommentsItem();

  factory CommentsItem.fromJson(Map<String, dynamic> json) =>
      _$CommentsItemFromJson(json);
}

@JsonSerializable()
class StarVO {
  num? star;

  StarVO();
  factory StarVO.fromJson(Map<String, dynamic> json) => _$StarVOFromJson(json);
}

@JsonSerializable()
class CommentItemTagVO {
  num? type;
  String? schemeUrl;

  CommentItemTagVO();

  factory CommentItemTagVO.fromJson(Map<String, dynamic> json) =>
      _$CommentItemTagVOFromJson(json);
}
