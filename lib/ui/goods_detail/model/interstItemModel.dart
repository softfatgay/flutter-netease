import 'package:json_annotation/json_annotation.dart';

part 'interstItemModel.g.dart';

@JsonSerializable()
class InterstItemModel {
  num? categoryCode;
  String? categoryName;
  String? picUrl;
  num? rank;
  bool? selectFlag;

  InterstItemModel();

  factory InterstItemModel.fromJson(Map<String, dynamic> json) =>
      _$InterstItemModelFromJson(json);
}
