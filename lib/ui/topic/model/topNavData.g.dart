// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topNavData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopData _$TopDataFromJson(Map<String, dynamic> json) {
  return TopData()
    ..checkNavType = json['checkNavType'] as bool
    ..navList = (json['navList'] as List)
        ?.map((e) =>
            e == null ? null : NavItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TopDataToJson(TopData instance) => <String, dynamic>{
      'checkNavType': instance.checkNavType,
      'navList': instance.navList,
    };
