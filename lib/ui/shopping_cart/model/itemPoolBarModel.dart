import 'package:json_annotation/json_annotation.dart';

part 'itemPoolBarModel.g.dart';

@JsonSerializable()
class ItemPoolBarModel {
  num? subtotalPrice;
  String? promTip;

  ItemPoolBarModel(this.subtotalPrice, this.promTip);

  factory ItemPoolBarModel.fromJson(Map<String, dynamic> json) =>
      _$ItemPoolBarModelFromJson(json);
}
