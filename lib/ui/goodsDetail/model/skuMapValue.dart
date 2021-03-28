import 'package:flutter_app/model/itemTagListItem.dart';
import 'package:flutter_app/ui/goodsDetail/model/hdrkDetailVOListItem.dart';
import 'package:flutter_app/ui/goodsDetail/model/shoppingReward.dart';
import 'package:flutter_app/ui/goodsDetail/model/skuSpec.dart';
import 'package:flutter_app/ui/goodsDetail/model/skuSpecValue.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skuMapValue.g.dart';

@JsonSerializable()
class SkuMapValue {
  num id;
  num counterPrice;
  num retailPrice;
  bool primarySku;
  num sellVolume;
  num noActivitySellVolume;
  bool valid;
  List<ItemSkuSpecValueListItem> itemSkuSpecValueList;
  num preSellStatus;
  num preSellPrice;
  num preSellVolume;
  Object preSellDesc;
  num purchaseAttribute;
  bool giftCardFlag;
  bool virtualFlag;
  num limitedFlag;
  num promId;
  num preLimitFlag;
  bool limitPurchaseFlag;
  num limitPurchaseCount;
  num limitPointCount;
  num buttonType;
  num limitPrice;
  bool selected;
  bool promValid;
  List<HdrkDetailVOListItem> hdrkDetailVOList;
  String promotionDesc;

  List<ItemTagListItem> itemTagList;
  num points;
  num pointsPrice;
  String pic;
  num preemptionStatus;

  ShoppingReward shoppingReward;
  String skuTitle;
  num calcPrice;
  String desc;
  String skuLimit;
  num operationAttribute;
  SkuFreight skuFreight;



  SkuMapValue();

  factory SkuMapValue.fromJson(Map<String, dynamic> json) =>
      _$SkuMapValueFromJson(json);
}

@JsonSerializable()
class ItemSkuSpecValueListItem {
  num id;
  num skuId;
  num skuSpecId;
  num skuSpecValueId;
  SkuSpec skuSpec;

  SkuSpecValue skuSpecValue;

  ItemSkuSpecValueListItem();

  factory ItemSkuSpecValueListItem.fromJson(Map<String, dynamic> json) =>
      _$ItemSkuSpecValueListItemFromJson(json);
}


@JsonSerializable()
class SkuFreight{
  String title;
  String freightInfo;
  String vipFreightInfo;
  List<PolicyListItem> policyList;
  num type;

  SkuFreight();

  factory SkuFreight.fromJson(Map<String, dynamic> json) =>
      _$SkuFreightFromJson(json);
}

@JsonSerializable()
class PolicyListItem{
String title;
String content;
String distributionArea;

PolicyListItem();

factory PolicyListItem.fromJson(Map<String, dynamic> json) =>
    _$PolicyListItemFromJson(json);

}
