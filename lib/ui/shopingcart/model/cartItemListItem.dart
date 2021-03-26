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
  String itemName;
  String pic;
  String extId;
  bool valid;
  bool checked;
  List<SpecListItem> specList;
  List<String> cartItemTips;

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
