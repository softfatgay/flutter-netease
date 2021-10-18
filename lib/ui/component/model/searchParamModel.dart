import 'package:json_annotation/json_annotation.dart';

part 'searchParamModel.g.dart';

@JsonSerializable()
class SearchParamModel {
  String? keyWord;
  String? statSearch;
  num? sortType;
  bool? descSorted;
  num? categoryId;
  num? matchType;
  num? floorPrice;
  num? upperPrice;
  num? size;
  num? itemId;
  num? promotionId;
  bool? stillSearch;
  num? searchWordSource;
  bool? needPopWindow;
  num? source;

  SearchParamModel(
      {this.keyWord = '',
      this.sortType = 0,
      this.statSearch = '',
      this.descSorted,
      this.categoryId = 0,
      this.matchType = 0,
      this.floorPrice = -1,
      this.upperPrice = -1,
      this.size = 40,
      this.itemId = 0,
      this.stillSearch = false,
      this.searchWordSource = 5,
      this.needPopWindow = true});

  Map<String, dynamic> toJson() => _$SearchParamModelToJson(this);
}
