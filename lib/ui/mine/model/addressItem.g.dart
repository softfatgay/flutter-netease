// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressItem _$AddressItemFromJson(Map<String, dynamic> json) {
  return AddressItem()
    ..englishName = json['englishName'] as String
    ..code = json['code'] as String
    ..province = json['province'] as String
    ..city = json['city'] as String
    ..level = json['level'] as num
    ..id = json['id'] as num
    ..type = json['type'] as num
    ..zonename = json['zonename'] as String
    ..parentid = json['parentid'] as num;
}

Map<String, dynamic> _$AddressItemToJson(AddressItem instance) =>
    <String, dynamic>{
      'englishName': instance.englishName,
      'code': instance.code,
      'province': instance.province,
      'city': instance.city,
      'level': instance.level,
      'id': instance.id,
      'type': instance.type,
      'zonename': instance.zonename,
      'parentid': instance.parentid,
    };
