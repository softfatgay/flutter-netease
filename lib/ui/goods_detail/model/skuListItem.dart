import 'package:flutter_app/ui/goods_detail/model/skuSpec.dart';
import 'package:flutter_app/ui/goods_detail/model/skuSpecValue.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skuListItem.g.dart';

@JsonSerializable()
class SkuListItem {
  num? id;
  num? counterPrice;
  num? retailPrice;
  bool? primarySku;
  num? sellVolume;
  num? noActivitySellVolume;
  bool? valid;

  num? baseId;
  num? startTime;
  num? endTime;
  String? name;
  num? pinPrice;
  num? skuNum;
  num? userNum;
  num? skuId;



  List<ItemSkuSpecValueListItem>? itemSkuSpecValueList;

  SkuListItem();

  factory SkuListItem.fromJson(Map<String, dynamic> json) =>
      _$SkuListItemFromJson(json);
}

@JsonSerializable()
class ItemSkuSpecValueListItem {
  num? id;
  num? skuId;
  num? skuSpecId;
  num? skuSpecValueId;
  SkuSpec? skuSpec;
  SkuSpecValue? skuSpecValue;

  ItemSkuSpecValueListItem();

  factory ItemSkuSpecValueListItem.fromJson(Map<String, dynamic> json) =>
      _$ItemSkuSpecValueListItemFromJson(json);
}
