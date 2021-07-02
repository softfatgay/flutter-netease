// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) {
  return VersionModel()
    ..buildBuildVersion = json['buildBuildVersion'] as String
    ..forceUpdateVersion = json['forceUpdateVersion'] as String
    ..forceUpdateVersionNo = json['forceUpdateVersionNo'] as String
    ..needForceUpdate = json['needForceUpdate'] as bool
    ..downloadURL = json['downloadURL'] as String
    ..buildHaveNewVersion = json['buildHaveNewVersion'] as bool
    ..buildVersionNo = json['buildVersionNo'] as String
    ..buildVersion = json['buildVersion'] as String
    ..buildUpdateDescription = json['buildUpdateDescription'] as String
    ..appKey = json['appKey'] as String
    ..buildKey = json['buildKey'] as String
    ..buildName = json['buildName'] as String
    ..buildIcon = json['buildIcon'] as String
    ..buildFileKey = json['buildFileKey'] as String
    ..buildFileSize = json['buildFileSize'] as String;
}

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'buildBuildVersion': instance.buildBuildVersion,
      'forceUpdateVersion': instance.forceUpdateVersion,
      'forceUpdateVersionNo': instance.forceUpdateVersionNo,
      'needForceUpdate': instance.needForceUpdate,
      'downloadURL': instance.downloadURL,
      'buildHaveNewVersion': instance.buildHaveNewVersion,
      'buildVersionNo': instance.buildVersionNo,
      'buildVersion': instance.buildVersion,
      'buildUpdateDescription': instance.buildUpdateDescription,
      'appKey': instance.appKey,
      'buildKey': instance.buildKey,
      'buildName': instance.buildName,
      'buildIcon': instance.buildIcon,
      'buildFileKey': instance.buildFileKey,
      'buildFileSize': instance.buildFileSize,
    };
