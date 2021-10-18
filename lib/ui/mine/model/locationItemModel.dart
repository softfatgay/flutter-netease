import 'package:json_annotation/json_annotation.dart';

part 'locationItemModel.g.dart';

@JsonSerializable()
class LocationItemModel {
  String? zipCode;
  String? townName;
  String? address;
  String? incompleteDesc;
  String? districtName;
  String? mobile;
  num? cityId;
  bool? completed;
  num? townId;
  num? provinceId;
  bool? dft;
  num? districtId;
  String? cityName;
  String? fullAddress;
  String? name;
  num? id;
  String? provinceName;

  LocationItemModel();

  factory LocationItemModel.fromJson(Map<String, dynamic> json) =>
      _$LocationItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationItemModelToJson(this);
}
