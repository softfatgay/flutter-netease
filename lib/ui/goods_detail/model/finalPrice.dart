import 'package:json_annotation/json_annotation.dart';

part 'finalPrice.g.dart';

@JsonSerializable()
class FinalPrice {
  String prefix;
  String price;
  String suffix;

  FinalPrice();
  factory FinalPrice.fromJson(Map<String, dynamic> json) =>
      _$FinalPriceFromJson(json);
}
