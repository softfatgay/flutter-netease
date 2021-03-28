// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination()
    ..page = json['page'] as num
    ..size = json['size'] as num
    ..totalPage = json['totalPage'] as num
    ..total = json['total'] as num
    ..lastPage = json['lastPage'] as bool;
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'totalPage': instance.totalPage,
      'total': instance.total,
      'lastPage': instance.lastPage,
    };
