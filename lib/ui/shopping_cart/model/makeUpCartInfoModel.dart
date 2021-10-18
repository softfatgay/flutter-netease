import 'package:flutter_app/ui/shopping_cart/model/redeemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'makeUpCartInfoModel.g.dart';

@JsonSerializable()
class MakeUpCartInfoModel {
  ItemPoolBarVO itemPoolBarVO;
  num validStartTime;
  num validEndTime;
  String validTimeDesc;
  List<AddBuyStepListItem> addBuyStepList;

  MakeUpCartInfoModel({this.validTimeDesc = ''});

  factory MakeUpCartInfoModel.fromJson(Map<String, dynamic> json) =>
      _$MakeUpCartInfoModelFromJson(json);
}

@JsonSerializable()
class ItemPoolBarVO {
  num subtotalPrice;
  String promTip;

  ItemPoolBarVO();

  factory ItemPoolBarVO.fromJson(Map<String, dynamic> json) =>
      _$ItemPoolBarVOFromJson(json);
}
