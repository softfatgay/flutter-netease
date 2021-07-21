import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goodDetailDownData.g.dart';

@JsonSerializable()
class GoodDetailDownData {
  num id;
  String html;

  List<AttrListItem> attrList;
  List<String> reportPicList;
  List<IssueListItem> issueList;
  String name;
  String desc;
  String pic;
  bool itemSizeTableFlag;
  bool itemSizeTableDetailFlag;
  num updateTime;

  GoodDetailDownData();

  factory GoodDetailDownData.fromJson(Map<String, dynamic> json) =>
      _$GoodDetailDownDataFromJson(json);
}

@JsonSerializable()
class IssueListItem {
  String question;
  String answer;

  IssueListItem();

  factory IssueListItem.fromJson(Map<String, dynamic> json) =>
      _$IssueListItemFromJson(json);
}
