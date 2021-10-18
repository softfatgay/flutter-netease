// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topicData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicData _$TopicDataFromJson(Map<String, dynamic> json) => TopicData()
  ..hasMore = json['hasMore'] as bool?
  ..result = (json['result'] as List<dynamic>?)
      ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TopicDataToJson(TopicData instance) => <String, dynamic>{
      'hasMore': instance.hasMore,
      'result': instance.result,
    };
