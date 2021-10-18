import 'package:json_annotation/json_annotation.dart';

part 'postageVO.g.dart';

@JsonSerializable()
class PostageVO {
  bool showTip;
  bool postFree;
  num priceRangeId;
  num leftPostFreePrice;
  String postageTip;

  PostageVO();

  factory PostageVO.fromJson(Map<String, dynamic> json) =>
      _$PostageVOFromJson(json);
}
