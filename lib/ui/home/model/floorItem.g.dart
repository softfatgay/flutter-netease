// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floorItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorItem _$FloorItemFromJson(Map<String, dynamic> json) {
  return FloorItem(
    json['layout'] as int,
    json['columnNum'] as int,
    json['floorType'] as int,
    (json['cells'] as List)
        ?.map(
            (e) => e == null ? null : Cells.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['style'] as int,
    json['taskId'] as int,
    json['height'] as int,
  );
}

Map<String, dynamic> _$FloorItemToJson(FloorItem instance) => <String, dynamic>{
      'layout': instance.layout,
      'columnNum': instance.columnNum,
      'floorType': instance.floorType,
      'cells': instance.cells,
      'style': instance.style,
      'taskId': instance.taskId,
      'height': instance.height,
    };
