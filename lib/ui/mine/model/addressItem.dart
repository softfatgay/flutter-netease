import 'package:json_annotation/json_annotation.dart';

part 'addressItem.g.dart';

@JsonSerializable()
class AddressItem {
  String? englishName;
  String? code;
  String? province;
  String? city;
  num? level;
  num? id;
  num? type;
  String? zonename;
  num? parentid;

  AddressItem();

  factory AddressItem.fromJson(Map<String, dynamic> json) =>
      _$AddressItemFromJson(json);
}
