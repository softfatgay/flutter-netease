import 'package:json_annotation/json_annotation.dart';

part 'versionFirModel.g.dart';

@JsonSerializable()
class BaseInfoFirModel {
  String id;
  String type;
  String name;
  String desc;
  String short;
  bool is_opened;
  String bundle_id;
  String org_id;
  bool is_show_plaza;
  String passwd;
  num is_store_auto_sync;
  String download_domain;
  bool download_domain_https_ready;
  bool send_shared_user_update_email;
  bool store_link_visible;
  num genre_id;
  String custom_market_url;
  bool download_token_can_expired;
  num created_at;
  bool has_combo;
  String icon_url;

  BaseInfoFirModel();

  factory BaseInfoFirModel.fromJson(Map<String, dynamic> json) =>
      _$BaseInfoFirModelFromJson(json);
}

@JsonSerializable()
class VersionFirModel {
  String name;
  String version;
  String changelog;
  num updated_at;
  String versionShort;
  String build;
  String installUrl;

  VersionFirModel();

  factory VersionFirModel.fromJson(Map<String, dynamic> json) =>
      _$VersionFirModelFromJson(json);
}
