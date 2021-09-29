import 'package:flutter_app/ui/home/model/itemPicBeanList.dart';
import 'package:flutter_app/ui/sort/model/bannerItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topLogo.g.dart';

@JsonSerializable()
class TopLogo {
  String logoUrl;
  num width;
  num height;
  num type;

  TopLogo();

  factory TopLogo.fromJson(Map<String, dynamic> json) =>
      _$TopLogoFromJson(json);
}
