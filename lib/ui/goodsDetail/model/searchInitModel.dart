import 'package:json_annotation/json_annotation.dart';

part 'searchInitModel.g.dart';

@JsonSerializable()
class SearchInitModel {
  List<HotKeywordVOListItem> hotKeywordVOList;
  SearchInitModel();

  factory SearchInitModel.fromJson(Map<String, dynamic> json) =>
      _$SearchInitModelFromJson(json);
}

@JsonSerializable()
class HotKeywordVOListItem {
  String keyword;
  String schemeUrl;
  num highlight;
  num hidden;
  num type;
  bool algSort;
  Extra extra;

  HotKeywordVOListItem();

  factory HotKeywordVOListItem.fromJson(Map<String, dynamic> json) =>
      _$HotKeywordVOListItemFromJson(json);
}

@JsonSerializable()
class Extra {
  num materialContentFrom;
  String materialName;
  bool rcmdSort;
  num taskType;
  num itemFrom;
  String crmUserGroupName;
  num resourcesId;
  String materialType;
  String crmUserGroupId;
  String materialId;
  String taskId;

  Extra();

  factory Extra.fromJson(Map<String, dynamic> json) => _$ExtraFromJson(json);
}
