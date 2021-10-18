import 'package:flutter_app/ui/shopping_cart/model/carItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/postageVO.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shoppingCartModel.g.dart';

@JsonSerializable()
class ShoppingCartModel {
  num totalPrice;
  num promotionPrice;
  num actualPrice;
  num totalPoint;
  num actualPoint;
  PostageVO postageVO;

  List<CarItem> cartGroupList;
  List<CarItem> invalidCartGroupList;

  ShoppingCartModel();

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) =>
      _$ShoppingCartModelFromJson(json);
}
