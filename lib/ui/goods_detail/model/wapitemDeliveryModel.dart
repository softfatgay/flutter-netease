import 'package:json_annotation/json_annotation.dart';

part 'wapitemDeliveryModel.g.dart';

@JsonSerializable()
class WapitemDeliveryModel {
  num? status;
  num? addressId;
  String? addressName;
  String? deliveryTime;
  num? deliveryStatus;

  WapitemDeliveryModel();

  factory WapitemDeliveryModel.fromJson(Map<String, dynamic> json) =>
      _$WapitemDeliveryModelFromJson(json);
}
