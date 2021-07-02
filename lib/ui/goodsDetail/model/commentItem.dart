import 'package:json_annotation/json_annotation.dart';

part 'commentItem.g.dart';

@JsonSerializable()
class CommentItem {
  String name;
  String strCount;
  String type;

  CommentItem();

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);
}
