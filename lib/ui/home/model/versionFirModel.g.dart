// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versionFirModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseInfoFirModel _$BaseInfoFirModelFromJson(Map<String, dynamic> json) {
  return BaseInfoFirModel()
    ..id = json['id'] as String
    ..type = json['type'] as String
    ..name = json['name'] as String
    ..desc = json['desc'] as String
    ..short = json['short'] as String
    ..is_opened = json['is_opened'] as bool
    ..bundle_id = json['bundle_id'] as String
    ..org_id = json['org_id'] as String
    ..is_show_plaza = json['is_show_plaza'] as bool
    ..passwd = json['passwd'] as String
    ..is_store_auto_sync = json['is_store_auto_sync'] as num
    ..download_domain = json['download_domain'] as String
    ..download_domain_https_ready = json['download_domain_https_ready'] as bool
    ..send_shared_user_update_email =
        json['send_shared_user_update_email'] as bool
    ..store_link_visible = json['store_link_visible'] as bool
    ..genre_id = json['genre_id'] as num
    ..custom_market_url = json['custom_market_url'] as String
    ..download_token_can_expired = json['download_token_can_expired'] as bool
    ..created_at = json['created_at'] as num
    ..has_combo = json['has_combo'] as bool
    ..icon_url = json['icon_url'] as String;
}

Map<String, dynamic> _$BaseInfoFirModelToJson(BaseInfoFirModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'desc': instance.desc,
      'short': instance.short,
      'is_opened': instance.is_opened,
      'bundle_id': instance.bundle_id,
      'org_id': instance.org_id,
      'is_show_plaza': instance.is_show_plaza,
      'passwd': instance.passwd,
      'is_store_auto_sync': instance.is_store_auto_sync,
      'download_domain': instance.download_domain,
      'download_domain_https_ready': instance.download_domain_https_ready,
      'send_shared_user_update_email': instance.send_shared_user_update_email,
      'store_link_visible': instance.store_link_visible,
      'genre_id': instance.genre_id,
      'custom_market_url': instance.custom_market_url,
      'download_token_can_expired': instance.download_token_can_expired,
      'created_at': instance.created_at,
      'has_combo': instance.has_combo,
      'icon_url': instance.icon_url,
    };

VersionFirModel _$VersionFirModelFromJson(Map<String, dynamic> json) {
  return VersionFirModel()
    ..name = json['name'] as String
    ..version = json['version'] as String
    ..changelog = json['changelog'] as String
    ..updated_at = json['updated_at'] as num
    ..versionShort = json['versionShort'] as String
    ..build = json['build'] as String
    ..installUrl = json['installUrl'] as String;
}

Map<String, dynamic> _$VersionFirModelToJson(VersionFirModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'changelog': instance.changelog,
      'updated_at': instance.updated_at,
      'versionShort': instance.versionShort,
      'build': instance.build,
      'installUrl': instance.installUrl,
    };
