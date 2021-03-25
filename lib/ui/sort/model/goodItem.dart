import 'package:flutter_app/ui/home/model/categoryItem.dart';
import 'package:flutter_app/ui/sort/model/itemTagItem.dart';
import 'package:flutter_app/ui/sort/model/listPromBanner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goodItem.g.dart';

@JsonSerializable()
class GoodItem {
  num id;
  String listPicUrl;
  String name;
  String seoTitle;
  String simpleDesc;
  String primaryPicUrl;
  String productPlace;
  num counterPrice;
  num primarySkuId;
  num retailPrice;
  num status;
  List<ItemTagItem> itemTagList;
  ListPromBanner listPromBanner;

  GoodItem();

  factory GoodItem.fromJson(Map<String, dynamic> json) =>
      _$GoodItemFromJson(json);
}
