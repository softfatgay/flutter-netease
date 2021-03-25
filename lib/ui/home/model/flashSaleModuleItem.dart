import 'package:json_annotation/json_annotation.dart';

part 'flashSaleModuleItem.g.dart';

@JsonSerializable()
class FlashSaleModuleItem {
  num itemId;
  num originPrice;
  num activityPrice;
  String picUrl;
  String showPicUrl;

  FlashSaleModuleItem();

  factory FlashSaleModuleItem.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleModuleItemFromJson(json);
}
