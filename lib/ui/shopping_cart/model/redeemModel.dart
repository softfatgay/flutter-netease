import 'package:flutter_app/ui/shopping_cart/model/cartItemListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'redeemModel.g.dart';

@JsonSerializable()
class RedeemModel {
  List<CartGroupListItem> cartGroupList;
  num totalPrice;
  num promotionPrice;
  num actualPrice;

  RedeemModel();

  factory RedeemModel.fromJson(Map<String, dynamic> json) =>
      _$RedeemModelFromJson(json);
}

@JsonSerializable()
class CartGroupListItem {
  num promId;
  num promType;
  String promTip;
  num allowCount;
  List<AddBuyStepListItem> addBuyStepList;

  CartGroupListItem();

  factory CartGroupListItem.fromJson(Map<String, dynamic> json) =>
      _$CartGroupListItemFromJson(json);
}

@JsonSerializable()
class AddBuyStepListItem {
  num stepNo;
  String title;
  bool isSatisfy;
  List<CartItemListItem> addBuyItemList;

  AddBuyStepListItem();

  factory AddBuyStepListItem.fromJson(Map<String, dynamic> json) =>
      _$AddBuyStepListItemFromJson(json);
}

@JsonSerializable()
class AddBuyItemListItem {
  String uniqueKey;
  num id;
  num itemId;
  String itemName;
  num status;
  String pic;
  num skuId;
  bool valid;
  num sellVolume;
  List<SpecListItem> specList;
  num cnt;
  num totalPrice;
  num retailPrice;
  num actualPrice;
  num subtotalPrice;
  String extId;
  bool checked;
  num promId;

  AddBuyItemListItem();

  factory AddBuyItemListItem.fromJson(Map<String, dynamic> json) =>
      _$AddBuyItemListItemFromJson(json);
}
