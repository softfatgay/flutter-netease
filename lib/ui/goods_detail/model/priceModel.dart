import 'package:flutter_app/ui/goods_detail/model/finalPrice.dart';
import 'package:json_annotation/json_annotation.dart';

part 'priceModel.g.dart';

@JsonSerializable()
class PriceModel {
  FinalPrice finalPrice;
  String counterPrice = '';
  String basicPrice = '';

  PriceModel();

  factory PriceModel.fromJson(Map<String, dynamic> json) =>
      _$PriceModelFromJson(json);
}
