
import 'package:json_annotation/json_annotation.dart';

part 'issueListItem.g.dart';

@JsonSerializable()
class IssueListItem {
  String question;
  String answer;

  IssueListItem();

  factory IssueListItem.fromJson(Map<String, dynamic> json) =>
      _$IssueListItemFromJson(json);
}

