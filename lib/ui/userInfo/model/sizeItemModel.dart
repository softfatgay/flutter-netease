import 'package:json_annotation/json_annotation.dart';

part 'sizeItemModel.g.dart';

@JsonSerializable()
class SizeItemModel {
  num hipCircumference;
  num footLength;
  num gender;
  num footCircumference;
  num waistCircumference;
  num shoulderBreadth;
  bool dft;
  String roleName;
  num bust;
  num underBust;
  num id;
  num bodyWeight;
  num height;

  SizeItemModel();

  factory SizeItemModel.fromJson(Map<String, dynamic> json) =>
      _$SizeItemModelFromJson(json);
}
