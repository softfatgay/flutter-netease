import 'package:flutter_app/ui/home/model/floorItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bigPromotionModule.g.dart';

@JsonSerializable()
class BigPromotionModule {
  List<FloorItem>? floorList;

  BigPromotionModule();

  factory BigPromotionModule.fromJson(Map<String, dynamic> json) =>
      _$BigPromotionModuleFromJson(json);
}
