
import 'package:json_annotation/json_annotation.dart';

part 'skuSpecValue.g.dart';


@JsonSerializable()
class SkuSpecValue {
  num? id;
  num? skuSpecId;
  String? picUrl;
  String? value;

  SkuSpecValue();

  factory SkuSpecValue.fromJson(Map<String, dynamic> json) =>
      _$SkuSpecValueFromJson(json);
}
