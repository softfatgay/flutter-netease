// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderInitModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderInitModel _$OrderInitModelFromJson(Map<String, dynamic> json) {
  return OrderInitModel()
    ..shipAddressList = (json['shipAddressList'] as List)
        ?.map((e) => e == null
            ? null
            : ShipAddressListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..shipAddress = json['shipAddress'] == null
        ? null
        : ShipAddressListItem.fromJson(
            json['shipAddress'] as Map<String, dynamic>)
    ..orderCartItemList = (json['orderCartItemList'] as List)
        ?.map((e) => e == null
            ? null
            : OrderCartItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..shipAddressId = json['shipAddressId'] as num
    ..itemPrice = json['itemPrice'] as num
    ..activityCouponPrice = json['activityCouponPrice'] as num
    ..activityPriceDesc = json['activityPriceDesc'] as String
    ..couponPrice = json['couponPrice'] as num
    ..freightPrice = json['freightPrice'] as num
    ..actualPrice = json['actualPrice'] as num
    ..couponList = (json['couponList'] as List)
        ?.map((e) =>
            e == null ? null : CouponItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..useGiftCard = json['useGiftCard'] as bool
    ..giftCardBalance = json['giftCardBalance'] as num
    ..giftCardCash = json['giftCardCash'] as num;
}

Map<String, dynamic> _$OrderInitModelToJson(OrderInitModel instance) =>
    <String, dynamic>{
      'shipAddressList': instance.shipAddressList,
      'shipAddress': instance.shipAddress,
      'orderCartItemList': instance.orderCartItemList,
      'shipAddressId': instance.shipAddressId,
      'itemPrice': instance.itemPrice,
      'activityCouponPrice': instance.activityCouponPrice,
      'activityPriceDesc': instance.activityPriceDesc,
      'couponPrice': instance.couponPrice,
      'freightPrice': instance.freightPrice,
      'actualPrice': instance.actualPrice,
      'couponList': instance.couponList,
      'useGiftCard': instance.useGiftCard,
      'giftCardBalance': instance.giftCardBalance,
      'giftCardCash': instance.giftCardCash,
    };

ShipAddressListItem _$ShipAddressListItemFromJson(Map<String, dynamic> json) {
  return ShipAddressListItem()
    ..id = json['id'] as num
    ..provinceId = json['provinceId'] as num
    ..provinceName = json['provinceName'] as String
    ..cityId = json['cityId'] as num
    ..cityName = json['cityName'] as String
    ..districtId = json['districtId'] as num
    ..districtName = json['districtName'] as String
    ..address = json['address'] as String
    ..fullAddress = json['fullAddress'] as String
    ..name = json['name'] as String
    ..mobile = json['mobile'] as String
    ..dft = json['dft'] as String
    ..email = json['email'] as String
    ..zipCode = json['zipCode'] as String
    ..townId = json['townId'] as num
    ..townName = json['townName'] as String
    ..completed = json['completed'] as bool
    ..incompleteDesc = json['incompleteDesc'] as String;
}

Map<String, dynamic> _$ShipAddressListItemToJson(
        ShipAddressListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provinceId': instance.provinceId,
      'provinceName': instance.provinceName,
      'cityId': instance.cityId,
      'cityName': instance.cityName,
      'districtId': instance.districtId,
      'districtName': instance.districtName,
      'address': instance.address,
      'fullAddress': instance.fullAddress,
      'name': instance.name,
      'mobile': instance.mobile,
      'dft': instance.dft,
      'email': instance.email,
      'zipCode': instance.zipCode,
      'townId': instance.townId,
      'townName': instance.townName,
      'completed': instance.completed,
      'incompleteDesc': instance.incompleteDesc,
    };
