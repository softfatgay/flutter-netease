


import 'package:json_annotation/json_annotation.dart';
part 'pagination.g.dart';
@JsonSerializable()
class Pagination {
  num? page;
  num? size;
  num? totalPage;
  num? total;
  bool? lastPage;

  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}