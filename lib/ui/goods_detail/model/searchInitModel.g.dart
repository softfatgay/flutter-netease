// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchInitModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchInitModel _$SearchInitModelFromJson(Map<String, dynamic> json) {
  return SearchInitModel()
    ..hotKeywordVOList = (json['hotKeywordVOList'] as List)
        ?.map((e) => e == null
            ? null
            : HotKeywordVOListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..defaultKeywords = (json['defaultKeywords'] as List)
        ?.map((e) => e == null
            ? null
            : HotKeywordVOListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SearchInitModelToJson(SearchInitModel instance) =>
    <String, dynamic>{
      'hotKeywordVOList': instance.hotKeywordVOList,
      'defaultKeywords': instance.defaultKeywords,
    };

HotKeywordVOListItem _$HotKeywordVOListItemFromJson(Map<String, dynamic> json) {
  return HotKeywordVOListItem()
    ..keyword = json['keyword'] as String
    ..schemeUrl = json['schemeUrl'] as String
    ..highlight = json['highlight'] as num
    ..hidden = json['hidden'] as num
    ..type = json['type'] as num
    ..algSort = json['algSort'] as bool
    ..extra = json['extra'] == null
        ? null
        : Extra.fromJson(json['extra'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HotKeywordVOListItemToJson(
        HotKeywordVOListItem instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'schemeUrl': instance.schemeUrl,
      'highlight': instance.highlight,
      'hidden': instance.hidden,
      'type': instance.type,
      'algSort': instance.algSort,
      'extra': instance.extra,
    };

Extra _$ExtraFromJson(Map<String, dynamic> json) {
  return Extra()
    ..materialContentFrom = json['materialContentFrom'] as num
    ..materialName = json['materialName'] as String
    ..rcmdSort = json['rcmdSort'] as bool
    ..taskType = json['taskType'] as num
    ..itemFrom = json['itemFrom'] as num
    ..crmUserGroupName = json['crmUserGroupName'] as String
    ..resourcesId = json['resourcesId'] as num
    ..materialType = json['materialType'] as String
    ..crmUserGroupId = json['crmUserGroupId'] as String
    ..materialId = json['materialId'] as String
    ..taskId = json['taskId'] as String;
}

Map<String, dynamic> _$ExtraToJson(Extra instance) => <String, dynamic>{
      'materialContentFrom': instance.materialContentFrom,
      'materialName': instance.materialName,
      'rcmdSort': instance.rcmdSort,
      'taskType': instance.taskType,
      'itemFrom': instance.itemFrom,
      'crmUserGroupName': instance.crmUserGroupName,
      'resourcesId': instance.resourcesId,
      'materialType': instance.materialType,
      'crmUserGroupId': instance.crmUserGroupId,
      'materialId': instance.materialId,
      'taskId': instance.taskId,
    };
