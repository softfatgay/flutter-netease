// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wapitemDeliveryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WapitemDeliveryModel _$WapitemDeliveryModelFromJson(
        Map<String, dynamic> json) =>
    WapitemDeliveryModel()
      ..status = json['status'] as num?
      ..addressId = json['addressId'] as num?
      ..addressName = json['addressName'] as String?
      ..deliveryTime = json['deliveryTime'] as String?
      ..deliveryStatus = json['deliveryStatus'] as num?;

Map<String, dynamic> _$WapitemDeliveryModelToJson(
        WapitemDeliveryModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'addressId': instance.addressId,
      'addressName': instance.addressName,
      'deliveryTime': instance.deliveryTime,
      'deliveryStatus': instance.deliveryStatus,
    };
