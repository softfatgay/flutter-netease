import 'package:flutter_app/ui/userInfo/model/sizeItemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'itemSizeDetailModel.g.dart';

@JsonSerializable()
class ItemSizeDetailModel {
  String? name;
  String? remarks;
  String? roleName;
  List<List<String>>? itemSizeValueList;
  List<List<String>>? roleSizeValueList;
  List<SizeItemModel>? roleList;
  bool? roleSizeComplete;
  num? recommendIndex;

  ItemSizeDetailModel();

  factory ItemSizeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ItemSizeDetailModelFromJson(json);
}
