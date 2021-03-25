import 'package:flutter_app/ui/home/model/cells.dart';
import 'package:json_annotation/json_annotation.dart';

part 'floorItem.g.dart';

@JsonSerializable()
class FloorItem {
  int layout;
  int columnNum;
  int floorType;
  List<Cells> cells;
  int style;
  int taskId;
  int height;

  FloorItem(this.layout, this.columnNum, this.floorType, this.cells, this.style,
      this.taskId, this.height);

  factory FloorItem.fromJson(Map<String, dynamic> json) =>
      _$FloorItemFromJson(json);
}
