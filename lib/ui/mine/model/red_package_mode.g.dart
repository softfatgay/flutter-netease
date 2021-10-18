// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'red_package_mode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedPackageMode _$RedPackageModeFromJson(Map<String, dynamic> json) =>
    RedPackageMode()
      ..searchResult = json['searchResult'] == null
          ? null
          : SearchResult.fromJson(json['searchResult'] as Map<String, dynamic>)
      ..banner = json['banner'] == null
          ? null
          : BannerData.fromJson(json['banner'] as Map<String, dynamic>);

Map<String, dynamic> _$RedPackageModeToJson(RedPackageMode instance) =>
    <String, dynamic>{
      'searchResult': instance.searchResult,
      'banner': instance.banner,
    };

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult()
  ..pagination = json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
  ..result = (json['result'] as List<dynamic>?)
      ?.map((e) => PackageItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'result': instance.result,
    };

PackageItem _$PackageItemFromJson(Map<String, dynamic> json) => PackageItem()
  ..id = json['id'] as num?
  ..validStartTime = json['validStartTime'] as num?
  ..validEndTime = json['validEndTime'] as num?
  ..condition = json['condition'] as num?
  ..name = json['name'] as String?
  ..price = json['price'] as num?
  ..rule = json['rule'] as String?
  ..isSelected = json['isSelected'] as bool?
  ..redpackageId = json['redpackageId'] as num?
  ..schemeUrl = json['schemeUrl'] as String?
  ..tagList = (json['tagList'] as List<dynamic>?)
      ?.map((e) => TagListItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PackageItemToJson(PackageItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'validStartTime': instance.validStartTime,
      'validEndTime': instance.validEndTime,
      'condition': instance.condition,
      'name': instance.name,
      'price': instance.price,
      'rule': instance.rule,
      'isSelected': instance.isSelected,
      'redpackageId': instance.redpackageId,
      'schemeUrl': instance.schemeUrl,
      'tagList': instance.tagList,
    };

BannerData _$BannerDataFromJson(Map<String, dynamic> json) => BannerData()
  ..backgroundPic = json['backgroundPic'] as String?
  ..title = json['title'] as String?
  ..icon = json['icon'] as String?;

Map<String, dynamic> _$BannerDataToJson(BannerData instance) =>
    <String, dynamic>{
      'backgroundPic': instance.backgroundPic,
      'title': instance.title,
      'icon': instance.icon,
    };

TagListItem _$TagListItemFromJson(Map<String, dynamic> json) => TagListItem()
  ..tagType = json['tagType'] as num?
  ..tagName = json['tagName'] as String?
  ..tagStyle = json['tagStyle'] as num?;

Map<String, dynamic> _$TagListItemToJson(TagListItem instance) =>
    <String, dynamic>{
      'tagType': instance.tagType,
      'tagName': instance.tagName,
      'tagStyle': instance.tagStyle,
    };
