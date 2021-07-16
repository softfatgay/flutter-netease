// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saturdayBuyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaturdayBuyModel _$SaturdayBuyModelFromJson(Map<String, dynamic> json) {
  return SaturdayBuyModel()
    ..pagination = json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
    ..result = (json['result'] as List)
        ?.map((e) =>
            e == null ? null : Result.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SaturdayBuyModelToJson(SaturdayBuyModel instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result()
    ..categoryId = json['categoryId'] as num
    ..description = json['description'] as String
    ..id = json['id'] as num
    ..isRefundPay = json['isRefundPay'] as bool
    ..itemId = json['itemId'] as num
    ..joinUsers = json['joinUsers'] as num
    ..limitNewUser = json['limitNewUser'] as bool
    ..limitPlatform = json['limitPlatform'] as num
    ..limitTime = json['limitTime'] as bool
    ..originPrice = json['originPrice'] as num
    ..picUrl = json['picUrl'] as String
    ..postageFree = json['postageFree'] as bool
    ..price = json['price'] as num
    ..recentUsers =
        (json['recentUsers'] as List)?.map((e) => e as String)?.toList()
    ..recommendRank = json['recommendRank'] as num
    ..skuNum = json['skuNum'] as num
    ..startTime = json['startTime'] as num
    ..status = json['status'] as num
    ..tabId = json['tabId'] as num
    ..title = json['title'] as String
    ..userNum = json['userNum'] as num;
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'description': instance.description,
      'id': instance.id,
      'isRefundPay': instance.isRefundPay,
      'itemId': instance.itemId,
      'joinUsers': instance.joinUsers,
      'limitNewUser': instance.limitNewUser,
      'limitPlatform': instance.limitPlatform,
      'limitTime': instance.limitTime,
      'originPrice': instance.originPrice,
      'picUrl': instance.picUrl,
      'postageFree': instance.postageFree,
      'price': instance.price,
      'recentUsers': instance.recentUsers,
      'recommendRank': instance.recommendRank,
      'skuNum': instance.skuNum,
      'startTime': instance.startTime,
      'status': instance.status,
      'tabId': instance.tabId,
      'title': instance.title,
      'userNum': instance.userNum,
    };
