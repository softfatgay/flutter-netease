// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabGroupModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabGroupModel _$TabGroupModelFromJson(Map<String, dynamic> json) =>
    TabGroupModel()
      ..categoryList = (json['categoryList'] as List<dynamic>?)
          ?.map((e) => TabModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..tabList = (json['tabList'] as List<dynamic>?)
          ?.map((e) => TabModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TabGroupModelToJson(TabGroupModel instance) =>
    <String, dynamic>{
      'categoryList': instance.categoryList,
      'tabList': instance.tabList,
    };
