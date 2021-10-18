import 'package:json_annotation/json_annotation.dart';

part 'cells.g.dart';

@JsonSerializable()
class Cells {
  String? subTitleColor;
  bool? rcmdItem;
  String? schemeUrl;
  String? title;
  String? picUrl;
  bool? rcmdSort;
  int? itemCnt;
  int? itemFrom;
  String? subTitle;
  String? titleColor;
  bool? showPrice;
  String? popupUrl;
  int? leftTime;
  String? id;
  String? targetUrl;
  List<dynamic>? itemList;

  Cells();

  factory Cells.fromJson(Map<String, dynamic> json) => _$CellsFromJson(json);

  Map<String, dynamic> toJson() => _$CellsToJson(this);
}

@JsonSerializable()
class ItemListItem {
  num? primarySkuPreSellStatus;
  String? picUrl;
  String? pieceUnitDesc;
  String? schemeUrl;
  num? pieceNum;
  num? primarySkuPreSellPrice;
  num? id;

  ItemListItem();
}
