

import 'package:flutter_app/model/itemListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brandIndexModel.g.dart';

@JsonSerializable()
class BrandIndexModel{
  String? extInfo;
  bool? hasMore;
  List<ItemListItem>? itemList;

  BrandIndexModel();

  factory BrandIndexModel.fromJson(Map<String, dynamic> json) =>
      _$BrandIndexModelFromJson(json);
}