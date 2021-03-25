// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagItem _$TagItemFromJson(Map<String, dynamic> json) {
  return TagItem()
    ..floorPrice = (json['floorPrice'] as num)?.toDouble()
    ..picUrl = json['picUrl'] as String
    ..newOnShelf = json['newOnShelf'] as bool
    ..webIndexVerticalPicUrl = json['webIndexVerticalPicUrl'] as String
    ..simpleDesc = json['simpleDesc'] as String
    ..name = json['name'] as String
    ..appListPicUrl = json['appListPicUrl'] as String
    ..id = json['id'] as int;
}

Map<String, dynamic> _$TagItemToJson(TagItem instance) => <String, dynamic>{
      'floorPrice': instance.floorPrice,
      'picUrl': instance.picUrl,
      'newOnShelf': instance.newOnShelf,
      'webIndexVerticalPicUrl': instance.webIndexVerticalPicUrl,
      'simpleDesc': instance.simpleDesc,
      'name': instance.name,
      'appListPicUrl': instance.appListPicUrl,
      'id': instance.id,
    };
