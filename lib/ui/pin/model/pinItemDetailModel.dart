import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/goods_detail/model/skuListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';
import 'package:flutter_app/ui/goods_detail/model/skuSpecListItem.dart';
import 'package:flutter_app/ui/mine/model/addressItem.dart';
import 'package:flutter_app/ui/mine/model/locationItemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pinItemDetailModel.g.dart';

@JsonSerializable()
class PinItemDetailModel {
  List<AttrListItem> attrList;
  Map<String, dynamic> itemDetail;
  ItemInfo itemInfo;
  List<SkuListItem> skuList;
  Map<String, SkuMapValue> skuMap;
  List<SkuSpecListItem> skuSpecList;
  List<LocationItemModel> shipAddressList;
  List<PinOrderCartItem> pinOrderCartItemList;

  SkuInfo skuInfo;
  num huoDongId;

  PinItemDetailModel();

  factory PinItemDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PinItemDetailModelFromJson(json);
}

@JsonSerializable()
class ItemInfo {
  String commentGoodRates;
  num customType;
  String deliverTime;
  String desc;
  num endTime;
  num feeExpLimit;
  num flag;
  bool huoDongTimeOut;
  num id;
  bool isRefundPay;
  num itemId;
  num joinUserType;
  num joinUsers;
  bool limitApp;
  bool limitNew;
  num limitPlatform;
  num limitTime;
  num modeType;
  String name;
  @JsonKey(name: 'num')
  num numC;
  num originPrice;
  num originTotalPrice;
  String picUrl;

  bool postageFree;
  num prePrice;
  num price;
  String primaryPicUrl;
  bool privateVolume;
  num productNo;
  String productType;
  String secondPicUrl;

  List<SkuListItem> skuList;
  String skuPicUrl;
  bool soldOut;
  num startTime;
  num startUserType;
  String status;
  num tabId;
  List<TagListItem> tagList;
  List<dynamic> tags;
  String title;
  num totalPrice;
  String tuanActivityUrl;
  bool tuanSoldOut;
  bool useSkuPinPrice;
  num userNum;

  ItemInfo();

  factory ItemInfo.fromJson(Map<String, dynamic> json) =>
      _$ItemInfoFromJson(json);
}

@JsonSerializable()
class TagListItem {
  String name;
  num type;

  TagListItem();

  factory TagListItem.fromJson(Map<String, dynamic> json) =>
      _$TagListItemFromJson(json);
}

@JsonSerializable()
class PinOrderCartItem {
  num count;
  num itemId;
  String name;
  num originPrice;
  String picUrl;
  num retailPrice;
  num skuId;
  List<String> specValueList;
  num subtotalPrice;

  PinOrderCartItem();

  factory PinOrderCartItem.fromJson(Map<String, dynamic> json) =>
      _$PinOrderCartItemFromJson(json);
}

@JsonSerializable()
class SkuInfo {
  num counterPrice;
  num id;
  num maxBuyCount;
  num pinPrice;
  bool primarySku;
  num retailPrice;
  num sellVolume;
  bool valid;

  SkuInfo();

  factory SkuInfo.fromJson(Map<String, dynamic> json) =>
      _$SkuInfoFromJson(json);
}
