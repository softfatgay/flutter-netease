import 'package:json_annotation/json_annotation.dart';

part 'versionModel.g.dart';

@JsonSerializable()
class VersionModel {
  String? buildBuildVersion;
  String? forceUpdateVersion;
  String? forceUpdateVersionNo;
  bool? needForceUpdate;
  String? downloadURL;
  bool? buildHaveNewVersion;
  String? buildVersionNo;
  String? buildVersion;
  String? buildUpdateDescription;
  String? appKey;
  String? buildKey;
  String? buildName;
  String? buildIcon;
  String? buildFileKey;
  String? buildFileSize;

  VersionModel();

  factory VersionModel.fromJson(Map<String, dynamic> json) =>
      _$VersionModelFromJson(json);
}
