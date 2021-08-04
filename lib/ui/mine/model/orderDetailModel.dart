import 'package:json_annotation/json_annotation.dart';

part 'orderDetailModel.g.dart';

@JsonSerializable()
class OrderDetailModel {
  num id;
  String no;
  num createTime;
  num remainTime;
  bool payOption;
  bool cancelOption;
  bool cancelPayedOption;
  dynamic cancelDialog;
  bool payMethodOption;
  bool orderCancelStepOption;
  bool deleteOption;
  List<PackageListItem> packageList;
  num itemPrice;
  num couponPrice;
  num activityCouponPrice;
  num giftCardPrice;
  num freightPrice;
  dynamic spmcFreightPrice;
  num actualPrice;
  String showActualPrice;
  num realPrice;
  Address address;
  num payMethod;
  String payDesc;
  num source;
  Indicator indicator;
  List<ActivityListItem> activityList;
  String activityPriceDesc;
  List<String> payComlpeteDescList;
  RedPacketVO redPacketVO;
  num points;

  String freshBargainOrderCancelDialogTip;

  OrderDetailModel();

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);
}

@JsonSerializable()
class PackageListItem {
  num id;
  num sequence;
  num status;

  List<SkuListItem> skuList;
  bool confirmOption;
  bool commentOption;
  bool deliveryOption;
  bool isPreSell;
  bool returnOption;
  num commentBtnStatus;
  String packageDesc;
  bool isSelfPick;
  bool serviceProcessOption;
  bool allGoodAfterSale;
  bool rebateOption;

  PackageListItem();
  factory PackageListItem.fromJson(Map<String, dynamic> json) =>
      _$PackageListItemFromJson(json);
}

@JsonSerializable()
class Address {
  String name;
  String mobile;
  String fullAddress;
  String provinceName;
  String cityName;
  String districtName;
  String townName;
  String address;
  num shipAddressId;
  String email;
  String zipCode;

  Address();
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@JsonSerializable()
class Indicator {
  num itemPrice;
  num couponPrice;
  num freightPrice;
  num delivery;
  num comment;

  Indicator();
  factory Indicator.fromJson(Map<String, dynamic> json) =>
      _$IndicatorFromJson(json);
}

@JsonSerializable()
class ActivityListItem {
  String tips;
  num price;
  num type;
  num identifyType;

  ActivityListItem();
  factory ActivityListItem.fromJson(Map<String, dynamic> json) =>
      _$ActivityListItemFromJson(json);
}

@JsonSerializable()
class RedPacketVO {
  num id;
  String name;
  num price;
  num validStartTime;
  num validEndTime;
  num condition;
  String conditionDesc;
  String rule;
  num redpackageId;
  String schemeUrl;

  RedPacketVO();
  factory RedPacketVO.fromJson(Map<String, dynamic> json) =>
      _$RedPacketVOFromJson(json);
}

@JsonSerializable()
class SkuListItem {
  num itemId;
  num skuId;
  num orderId;
  num packageId;
  String picUrl;
  String name;
  List<String> specValueList;
  num count;
  num originPrice;
  num retailPrice;
  num subtotalPrice;
  num totalPrice;
  num preSellPrice;
  bool isGift;
  bool isAddBuy;

  SkuListItem();

  factory SkuListItem.fromJson(Map<String, dynamic> json) =>
      _$SkuListItemFromJson(json);
}
