import 'package:flutter_app/ui/home/model/bigPromotionModule.dart';
import 'package:flutter_app/ui/home/model/categoryHotSellModule.dart';
import 'package:flutter_app/ui/home/model/flashSaleModule.dart';
import 'package:flutter_app/ui/home/model/focusItem.dart';
import 'package:flutter_app/ui/home/model/indexActivityModule.dart';
import 'package:flutter_app/ui/home/model/kingKongModule.dart';
import 'package:flutter_app/ui/home/model/newItemModel.dart';
import 'package:flutter_app/ui/home/model/policyDescItem.dart';
import 'package:flutter_app/ui/home/model/sceneLightShoppingGuideModule.dart';
import 'package:flutter_app/ui/home/model/tagItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'homeModel.g.dart';

@JsonSerializable()
class HomeModel {
  BigPromotionModule bigPromotionModule;
  List<TagItem> tagList;
  List<PolicyDescItem> policyDescList;
  CategoryHotSellModule categoryHotSellModule;
  bool freshmanFlag;
  List<FocusItem> focusList;
  List<SceneLightShoppingGuideModule> sceneLightShoppingGuideModule;

  KingKongModule kingKongModule;
  List<IndexActivityModule> indexActivityModule;
  List<NewItemModel> newItemList;
  FlashSaleModule flashSaleModule;

  HomeModel();

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
}
