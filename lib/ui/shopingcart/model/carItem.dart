import 'package:flutter_app/ui/shopingcart/model/cartItemListItem.dart';
import 'package:flutter_app/ui/shopingcart/model/redeemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carItem.g.dart';

@JsonSerializable()
class CarItem {
  num id;
  num promId;
  num promType;
  List<CartItemListItem> cartItemList;
  String promTip;
  Object promTipList;
  bool promSatisfy;
  bool checked;
  bool canCheck;
  num promNotSatisfyType;
  num promotionBtn;
  int allowCount;
  num type;
  num suitCount;
  num source;
  List<AddBuyStepListItem> addBuyStepList;

  CarItem();

  factory CarItem.fromJson(Map<String, dynamic> json) =>
      _$CarItemFromJson(json);
}
