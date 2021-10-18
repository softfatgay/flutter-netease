import 'package:json_annotation/json_annotation.dart';

part 'globalModel.g.dart';

@JsonSerializable()
class GlobalModel {
  String? environment;
  String? nickname;
  String? username;
  String? userid;
  List<CateListItem>? cateList;

  GlobalModel();
  factory GlobalModel.fromJson(Map<String, dynamic> json) =>
      _$GlobalModelFromJson(json);
}

@JsonSerializable()
class CateListItem {
  num? id;
  num? superCategoryId;
  num? showIndex;
  String? name;
  String? imgUrl;
  num? type;
  num? categoryType;

  CateListItem();

  factory CateListItem.fromJson(Map<String, dynamic> json) =>
      _$CateListItemFromJson(json);
}
