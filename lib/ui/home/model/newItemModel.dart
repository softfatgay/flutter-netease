import 'package:flutter_app/ui/home/model/newItemTagModul.dart';
import 'package:json_annotation/json_annotation.dart';

part 'newItemModel.g.dart';

@JsonSerializable()
class NewItemModel {
  String? scenePicUrl;
  String? simpleDesc;
  num? retailPrice;
  List<NewItemTagModel>? itemTagList;
  int? id;

  NewItemModel();

  factory NewItemModel.fromJson(Map<String, dynamic> json) =>
      _$NewItemModelFromJson(json);
}
