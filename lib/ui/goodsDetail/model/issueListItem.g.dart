// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issueListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueListItem _$IssueListItemFromJson(Map<String, dynamic> json) {
  return IssueListItem()
    ..question = json['question'] as String
    ..answer = json['answer'] as String;
}

Map<String, dynamic> _$IssueListItemToJson(IssueListItem instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
    };
