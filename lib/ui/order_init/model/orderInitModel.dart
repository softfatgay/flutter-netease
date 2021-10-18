import 'package:flutter_app/model/couponItem.dart';
import 'package:flutter_app/model/orderCartItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderInitModel.g.dart';

@JsonSerializable()
class OrderInitModel {
  List<ShipAddressListItem>? shipAddressList;
  ShipAddressListItem? shipAddress;
  List<OrderCartItem>? orderCartItemList;
  num? shipAddressId;
  num? itemPrice;
  num? activityCouponPrice;
  String? activityPriceDesc;
  num? couponPrice;
  num? freightPrice;
  num? actualPrice;
  List<CouponItem>? couponList;
  bool? useGiftCard;
  num? giftCardBalance;
  num? giftCardCash;

  OrderInitModel();

  factory OrderInitModel.fromJson(Map<String, dynamic> json) =>
      _$OrderInitModelFromJson(json);
}

@JsonSerializable()
class ShipAddressListItem {
  num? id;
  num? provinceId;
  String? provinceName;
  num? cityId;
  String? cityName;
  num? districtId;
  String? districtName;
  String? address;
  String? fullAddress;
  String? name;
  String? mobile;
  String? dft;
  String? email;
  String? zipCode;
  num? townId;
  String? townName;
  bool? completed;
  String? incompleteDesc;

  ShipAddressListItem();

  factory ShipAddressListItem.fromJson(Map<String, dynamic> json) =>
      _$ShipAddressListItemFromJson(json);
}
