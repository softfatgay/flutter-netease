import 'package:flutter_app/ui/topic/model/navItem.dart';
import 'package:flutter_app/ui/topic/model/result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topicData.g.dart';

@JsonSerializable()
class TopicData {
  bool hasMore;
  List<Result> result;

  TopicData();

  factory TopicData.fromJson(Map<String, dynamic> json) =>
      _$TopicDataFromJson(json);
}
