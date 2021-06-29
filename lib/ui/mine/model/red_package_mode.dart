import 'package:flutter_app/model/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'red_package_mode.g.dart';

@JsonSerializable()
class RedPackageMode {
  SearchResult searchResult;
  BannerData banner;

  RedPackageMode();
  factory RedPackageMode.fromJson(Map<String, dynamic> json) =>
      _$RedPackageModeFromJson(json);
}

@JsonSerializable()
class SearchResult {
  Pagination pagination;
  List<PackageItem> result;

  SearchResult();

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@JsonSerializable()
class PackageItem {
  num id;
  num validStartTime;
  num validEndTime;
  num condition;
  String name;
  num price;
  String rule;

  num redpackageId;

  PackageItem();
  factory PackageItem.fromJson(Map<String, dynamic> json) =>
      _$PackageItemFromJson(json);
}

@JsonSerializable()
class BannerData {
  String backgroundPic;
  String title;
  String icon;

  BannerData();

  factory BannerData.fromJson(Map<String, dynamic> json) =>
      _$BannerDataFromJson(json);
}
