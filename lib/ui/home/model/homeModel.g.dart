// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel()
  ..bigPromotionModule = json['bigPromotionModule'] == null
      ? null
      : BigPromotionModule.fromJson(
          json['bigPromotionModule'] as Map<String, dynamic>)
  ..tagList = (json['tagList'] as List<dynamic>?)
      ?.map((e) => TagItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..policyDescList = (json['policyDescList'] as List<dynamic>?)
      ?.map((e) => PolicyDescItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..categoryHotSellModule = json['categoryHotSellModule'] == null
      ? null
      : CategoryHotSellModule.fromJson(
          json['categoryHotSellModule'] as Map<String, dynamic>)
  ..freshmanFlag = json['freshmanFlag'] as bool?
  ..focusList = (json['focusList'] as List<dynamic>?)
      ?.map((e) => FocusItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..sceneLightShoppingGuideModule =
      (json['sceneLightShoppingGuideModule'] as List<dynamic>?)
          ?.map((e) =>
              SceneLightShoppingGuideModule.fromJson(e as Map<String, dynamic>))
          .toList()
  ..kingKongModule = json['kingKongModule'] == null
      ? null
      : KingKongModule.fromJson(json['kingKongModule'] as Map<String, dynamic>)
  ..indexActivityModule = (json['indexActivityModule'] as List<dynamic>?)
      ?.map((e) => IndexActivityModule.fromJson(e as Map<String, dynamic>))
      .toList()
  ..newItemList = (json['newItemList'] as List<dynamic>?)
      ?.map((e) => NewItemModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..flashSaleModule = json['flashSaleModule'] == null
      ? null
      : FlashSaleModule.fromJson(
          json['flashSaleModule'] as Map<String, dynamic>);

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'bigPromotionModule': instance.bigPromotionModule,
      'tagList': instance.tagList,
      'policyDescList': instance.policyDescList,
      'categoryHotSellModule': instance.categoryHotSellModule,
      'freshmanFlag': instance.freshmanFlag,
      'focusList': instance.focusList,
      'sceneLightShoppingGuideModule': instance.sceneLightShoppingGuideModule,
      'kingKongModule': instance.kingKongModule,
      'indexActivityModule': instance.indexActivityModule,
      'newItemList': instance.newItemList,
      'flashSaleModule': instance.flashSaleModule,
    };
