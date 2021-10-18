import 'package:json_annotation/json_annotation.dart';

part 'orderCartItem.g.dart';

@JsonSerializable()
class OrderCartItem {
  num? itemId;
  num? skuId;
  num? count;
  num? originalPrice;
  num? retailPrice;
  num? actualPrice;
  num? totalPrice;
  num? subtotalPrice;
  num? retailPoint;
  num? actualPoint;
  num? source;
  num? preSellStatus;
  num? preSellPrice;
  num? preSellVolume;
  num? promType;
  num? preemptionStatus;
  num? type;
  num? extId;
  num? pointsPrice;

  String? picUrl;
  String? name;
  String? preSellDesc;
  String? promTag;
  String? id;
  List<String>? specValueList;

  bool? isGift;
  bool? isAddBuy;
  bool? newItemFlag;
  bool? isAreaSupported;

  OrderCartItem();

  factory OrderCartItem.fromJson(Map<String, dynamic> json) =>
      _$OrderCartItemFromJson(json);
}
