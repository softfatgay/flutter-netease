// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationItemModel _$LocationItemModelFromJson(Map<String, dynamic> json) {
  return LocationItemModel()
    ..zipCode = json['zipCode'] as String
    ..townName = json['townName'] as String
    ..address = json['address'] as String
    ..incompleteDesc = json['incompleteDesc'] as String
    ..districtName = json['districtName'] as String
    ..mobile = json['mobile'] as String
    ..cityId = json['cityId'] as num
    ..completed = json['completed'] as bool
    ..townId = json['townId'] as num
    ..provinceId = json['provinceId'] as num
    ..dft = json['dft'] as bool
    ..districtId = json['districtId'] as num
    ..cityName = json['cityName'] as String
    ..fullAddress = json['fullAddress'] as String
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..provinceName = json['provinceName'] as String;
}

Map<String, dynamic> _$LocationItemModelToJson(LocationItemModel instance) =>
    <String, dynamic>{
      'zipCode': instance.zipCode,
      'townName': instance.townName,
      'address': instance.address,
      'incompleteDesc': instance.incompleteDesc,
      'districtName': instance.districtName,
      'mobile': instance.mobile,
      'cityId': instance.cityId,
      'completed': instance.completed,
      'townId': instance.townId,
      'provinceId': instance.provinceId,
      'dft': instance.dft,
      'districtId': instance.districtId,
      'cityName': instance.cityName,
      'fullAddress': instance.fullAddress,
      'name': instance.name,
      'id': instance.id,
      'provinceName': instance.provinceName,
    };
