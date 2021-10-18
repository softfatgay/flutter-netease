import 'package:json_annotation/json_annotation.dart';

part 'buyNow.g.dart';

@JsonSerializable()
class BuyNow {
  num? itemId;
  num? purchaseAttribute;
  num? countPrice;
  num? retailPrice;
  num? primarySkuId;
  String? itemName;
  String? itemUrl;
  bool? valid;

  BuyNow();

  factory BuyNow.fromJson(Map<String, dynamic> json) => _$BuyNowFromJson(json);
}
