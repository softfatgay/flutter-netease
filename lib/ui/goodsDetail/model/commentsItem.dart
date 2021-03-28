import 'package:json_annotation/json_annotation.dart';

part 'commentsItem.g.dart';

@JsonSerializable()
class CommentsItem {
  num id;
  num itemId;
  num skuId;
  num packageId;
  String itemName;
  String itemIconUrl;
  List<String> skuInfo;
  String frontUserName;

  String content;

  num createTime;

  List<String> picList;
  num memberLevel;
  StarVO starVO;
  num star;

  CommentsItem();

  factory CommentsItem.fromJson(Map<String, dynamic> json) =>
      _$CommentsItemFromJson(json);
}

@JsonSerializable()
class StarVO {
  num star;

  StarVO();

  factory StarVO.fromJson(Map<String, dynamic> json) => _$StarVOFromJson(json);
}
