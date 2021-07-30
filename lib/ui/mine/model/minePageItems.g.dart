// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minePageItems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinePageItems _$MinePageItemsFromJson(Map<String, dynamic> json) {
  return MinePageItems()
    ..fundType = json['fundType'] as num
    ..fundValue = json['fundValue'] as String
    ..fundName = json['fundName'] as String
    ..targetUrl = json['targetUrl'] as String
    ..toast = json['toast'] as String;
}

Map<String, dynamic> _$MinePageItemsToJson(MinePageItems instance) =>
    <String, dynamic>{
      'fundType': instance.fundType,
      'fundValue': instance.fundValue,
      'fundName': instance.fundName,
      'targetUrl': instance.targetUrl,
      'toast': instance.toast,
    };
