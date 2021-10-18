import 'package:flutter_app/ui/topic/model/topicItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  List<TopicItem>? topics;

  Result();

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
