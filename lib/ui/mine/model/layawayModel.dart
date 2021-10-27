import 'package:json_annotation/json_annotation.dart';

part 'layawayModel.g.dart';

@JsonSerializable()
class LayawayModel {
  num? id;
  String? name;
  String? title;
  num? phaseNum;
  num? retailPrice;
  num? favorPrice;
  String? primaryPicUrl;
  String? listPicUrl;
  num? point;

  LayawayModel();

  factory LayawayModel.fromJson(Map<String, dynamic> json) =>
      _$LayawayModelFromJson(json);
}
