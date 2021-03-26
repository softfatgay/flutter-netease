// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotListModel _$HotListModelFromJson(Map<String, dynamic> json) {
  return HotListModel()
    ..currentCategory = json['currentCategory'] == null
        ? null
        : CurrentCategory.fromJson(
            json['currentCategory'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HotListModelToJson(HotListModel instance) =>
    <String, dynamic>{
      'currentCategory': instance.currentCategory,
    };
