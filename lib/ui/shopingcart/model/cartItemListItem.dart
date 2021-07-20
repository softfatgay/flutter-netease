import 'package:json_annotation/json_annotation.dart';

part 'cartItemListItem.g.dart';

@JsonSerializable()
class CartItemListItem {
  String uniqueKey;
  num id;
  num itemId;
  num status;
  num skuId;
  num sellVolume;
  num cnt;
  num totalPrice;
  num retailPrice;
  num actualPrice;
  num subtotalPrice;
  num preSellStatus;
  num preSellPrice;
  num preSellVolume;
  num type;
  num source;
  List<num> sources;
  String itemName;
  String pic;
  String extId;
  String promTag;
  String priceReductDesc;
  bool valid;
  bool checked;
  int stepNo;
  dynamic checkExt;
  List<SpecListItem> specList;
  List<String> cartItemTips;

  String timingPromotion;
  String finishTip;
  num remainTime;
  WarehouseInfo warehouseInfo;

  CartItemListItem();

  factory CartItemListItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemListItemFromJson(json);
}

@JsonSerializable()
class SpecListItem {
  String specName;
  String specValue;

  SpecListItem();

  factory SpecListItem.fromJson(Map<String, dynamic> json) =>
      _$SpecListItemFromJson(json);
}

@JsonSerializable()
class WarehouseInfo {
  String desc;
  num type;

  WarehouseInfo();

  factory WarehouseInfo.fromJson(Map<String, dynamic> json) =>
      _$WarehouseInfoFromJson(json);
}
