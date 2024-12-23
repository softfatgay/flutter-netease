// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floorItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorItem _$FloorItemFromJson(Map<String, dynamic> json) => FloorItem(
      (json['layout'] as num?)?.toInt(),
      (json['columnNum'] as num?)?.toInt(),
      (json['floorType'] as num?)?.toInt(),
      (json['cells'] as List<dynamic>?)
          ?.map((e) => Cells.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['style'] as num?)?.toInt(),
      (json['taskId'] as num?)?.toInt(),
      json['height'] as num?,
    );

Map<String, dynamic> _$FloorItemToJson(FloorItem instance) => <String, dynamic>{
      'layout': instance.layout,
      'columnNum': instance.columnNum,
      'floorType': instance.floorType,
      'cells': instance.cells,
      'style': instance.style,
      'taskId': instance.taskId,
      'height': instance.height,
    };
