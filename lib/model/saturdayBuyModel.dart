import 'package:flutter_app/model/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saturdayBuyModel.g.dart';

@JsonSerializable()
class SaturdayBuyModel {
  Pagination? pagination;
  List<Result>? result;

  SaturdayBuyModel();

  factory SaturdayBuyModel.fromJson(Map<String, dynamic> json) =>
      _$SaturdayBuyModelFromJson(json);
}

@JsonSerializable()
class Result {
  num? categoryId;
  String? description;
  num? id;
  bool? isRefundPay;
  num? itemId;
  num? joinUsers;
  bool? limitNewUser;
  num? limitPlatform;
  bool? limitTime;
  num? originPrice;
  String? picUrl;
  bool? postageFree;
  num? price;
  List<String>? recentUsers;
  num? recommendRank;
  num? skuNum;
  num? startTime;
  num? status;
  num? tabId;
  String? title;
  num? userNum;

  Result();

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
