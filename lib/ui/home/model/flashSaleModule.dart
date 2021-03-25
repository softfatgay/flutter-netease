import 'package:flutter_app/ui/home/model/flashSaleModuleItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flashSaleModule.g.dart';

@JsonSerializable()
class FlashSaleModule {
  num activityPrice;

  String primaryPicUrl;
  num nextStartTime;
  num remainTime;
  num flashSaleScreenId;
  bool showFlash;
  List<FlashSaleModuleItem> itemList;

  FlashSaleModule();

  factory FlashSaleModule.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleModuleFromJson(json);
}
