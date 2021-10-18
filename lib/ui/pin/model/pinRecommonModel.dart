import 'package:json_annotation/json_annotation.dart';

part 'pinRecommonModel.g.dart';

@JsonSerializable()
class PinRecommonModel {
  String? name;
  num? price;
  num? id;
  num? itemId;
  String? picUrl;

  PinRecommonModel();

  factory PinRecommonModel.fromJson(Map<String, dynamic> json) =>
      _$PinRecommonModelFromJson(json);
}
