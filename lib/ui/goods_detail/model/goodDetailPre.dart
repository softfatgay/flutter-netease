import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goodDetailPre.g.dart';

@JsonSerializable()
class GoodDetailPre {
  GoodDetail item;

  List<PolicyListItem> policyList;
  num commentCount;
  num commentWithPicCount;
  num source;

  GoodDetailPre();

  factory GoodDetailPre.fromJson(Map<String, dynamic> json) =>
      _$GoodDetailPreFromJson(json);
}
