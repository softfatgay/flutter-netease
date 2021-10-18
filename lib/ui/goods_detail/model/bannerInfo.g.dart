// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bannerInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerInfo _$BannerInfoFromJson(Map<String, dynamic> json) => BannerInfo()
  ..duration = json['duration'] as num?
  ..hasVideo = json['hasVideo'] as bool?
  ..picUrl = json['picUrl'] as String?
  ..videoUrl = json['videoUrl'] as String?
  ..size = json['size'] as num?
  ..width = json['width'] as num?
  ..isVideo = json['isVideo'] as bool?
  ..height = json['height'] as num?;

Map<String, dynamic> _$BannerInfoToJson(BannerInfo instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'hasVideo': instance.hasVideo,
      'picUrl': instance.picUrl,
      'videoUrl': instance.videoUrl,
      'size': instance.size,
      'width': instance.width,
      'isVideo': instance.isVideo,
      'height': instance.height,
    };
