// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bannerItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerItem _$BannerItemFromJson(Map<String, dynamic> json) => BannerItem()
  ..id = json['id'] as num?
  ..picUrl = json['picUrl'] as String?
  ..targetUrl = json['targetUrl'] as String?;

Map<String, dynamic> _$BannerItemToJson(BannerItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
      'targetUrl': instance.targetUrl,
    };
