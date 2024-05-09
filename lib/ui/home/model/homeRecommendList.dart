import 'package:flutter_app/model/itemListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'homeRecommendList.g.dart';

@JsonSerializable()
class HomeRecommendList {
  List<ItemListItem>? itemList = [];
  String rcmdVer = "";
  String itemIdsStr = "";
  var hasMore = false;

  HomeRecommendList();

  factory HomeRecommendList.fromJson(Map<String, dynamic> json) =>
      _$HomeRecommendListFromJson(json);

}
