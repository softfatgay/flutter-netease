import 'package:flutter_app/ui/shopping_cart/model/cartItemListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'giftStepListItem.g.dart';

@JsonSerializable()
class GiftStepListItem {
  num? stepNo;
  String? title;
  bool? isSatisfy;
  bool? ordered;
  List<CartItemListItem>? giftItemList;

  GiftStepListItem();

  factory GiftStepListItem.fromJson(Map<String, dynamic> json) =>
      _$GiftStepListItemFromJson(json);
}
