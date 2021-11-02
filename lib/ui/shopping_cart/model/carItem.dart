import 'package:flutter_app/ui/shopping_cart/model/cartItemListItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/giftStepListItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/redeemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carItem.g.dart';

@JsonSerializable()
class CarItem {
  num? id;
  num? promId;
  num? promType;
  List<CartItemListItem>? cartItemList;
  String? promTip;
  Object? promTipList;
  bool? promSatisfy;
  bool? checked;
  bool? canCheck;
  num? promNotSatisfyType;
  num? promotionBtn;
  int? allowCount;
  num? type;
  num? suitCount;
  num? source;
  List<AddBuyStepListItem>? addBuyStepList;
  List<AddBuyStepListItem>? giftStepList;

  CarItem();

  factory CarItem.fromJson(Map<String, dynamic> json) =>
      _$CarItemFromJson(json);
}
