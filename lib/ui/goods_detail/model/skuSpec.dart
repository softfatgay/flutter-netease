
import 'package:json_annotation/json_annotation.dart';

part 'skuSpec.g.dart';

@JsonSerializable()
class SkuSpec {
  num? id;
  String? name;
  num? type;
  List<SkuSpecValueListItem>? skuSpecValueList;

  SkuSpec();

  factory SkuSpec.fromJson(Map<String, dynamic> json) =>
      _$SkuSpecFromJson(json);
}


@JsonSerializable()
class SkuSpecValueListItem {
  num? id;
  String? value;

  SkuSpecValueListItem();

  factory SkuSpecValueListItem.fromJson(Map<String, dynamic> json) =>
      _$SkuSpecValueListItemFromJson(json);
}
