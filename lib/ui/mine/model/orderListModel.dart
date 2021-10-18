import 'package:json_annotation/json_annotation.dart';

part 'orderListModel.g.dart';

@JsonSerializable()
class OrderListModel {
  bool? nextHasMore;
  num? lastOrderId;
  List<OrderListItem>? list;

  OrderListModel();

  factory OrderListModel.fromJson(Map<String, dynamic> json) =>
      _$OrderListModelFromJson(json);
}

@JsonSerializable()
class OrderListItem {
  String? no;
  String? typeDesc;
  num? actualPrice;
  num? freightPrice;
  String? freshBargainOrderCancelDialogTip;
  num? orderType;
  num? cancelStatus;
  num? invoiceFinishStep;
  num? source;
  num? subOrderId;
  num? id;
  num? orderStepId;
  num? remainTime;
  num? createTime;
  num? depositType;
  num? invoiceCreateTime;
  bool? hasFreshBargain;
  bool? moneySavingCardOrder;
  bool? cancelOption;
  bool? bargainFlag;
  bool? pointsOrderFlag;
  bool? exchangeFlag;
  bool? deleteOption;
  bool? hasSpmc;
  bool? crowdfundingFlag;
  bool? returnRecordOption;
  bool? orderCancelStepOption;
  bool? payOption;
  bool? addrUpdateFlag;
  bool? cancelPayedOption;
  List<PackageListItem>? packageList;

  OrderListItem();

  factory OrderListItem.fromJson(Map<String, dynamic> json) =>
      _$OrderListItemFromJson(json);
}

@JsonSerializable()
class PackageListItem {
  bool? isPreSell;

  bool? returnOption;

  String? specDesc;

  num? count;

  bool? saleGiftCardFlag;

  bool? virtualFlag;

  num? preSellPrice;

  bool? commentOption;

  num? itemId;

  num? sequence;

  bool? serviceProcessOption;

  bool? rebateOption;

  String? name;

  bool? addrUpdateFlag;

  num? orderCartItemId;

  num? id;

  num? commentBtnStatus;

  bool? confirmOption;

  bool? deliveryOption;

  num? skuId;

  num? status;

  List<String>? picUrlList;

  PackageListItem();

  factory PackageListItem.fromJson(Map<String, dynamic> json) =>
      _$PackageListItemFromJson(json);
}
