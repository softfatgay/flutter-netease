// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavItem _$NavItemFromJson(Map<String, dynamic> json) {
  return NavItem()
    ..id = json['id'] as num
    ..picUrl = json['picUrl'] as String
    ..mainTitle = json['mainTitle'] as String
    ..viceTitle = json['viceTitle'] as String
    ..columnUrl = json['columnUrl'] as String
    ..onlineType = json['onlineType'] as bool
    ..vaildStartTime = json['vaildStartTime'] as num
    ..vaildEndTime = json['vaildEndTime'] as num
    ..rank = json['rank'] as num;
}

Map<String, dynamic> _$NavItemToJson(NavItem instance) => <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
      'mainTitle': instance.mainTitle,
      'viceTitle': instance.viceTitle,
      'columnUrl': instance.columnUrl,
      'onlineType': instance.onlineType,
      'vaildStartTime': instance.vaildStartTime,
      'vaildEndTime': instance.vaildEndTime,
      'rank': instance.rank,
    };
