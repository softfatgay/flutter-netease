import 'package:json_annotation/json_annotation.dart';

part 'indexActivityModule.g.dart';

@JsonSerializable()
class IndexActivityModule {
  String? backgroundUrl;
  String? picUrl;
  String? activityPrice;
  String? subTitle;
  String? originPrice;
  String? tag;
  String? title;
  String? targetUrl;
  String? showPicUrl;

  IndexActivityModule();

  factory IndexActivityModule.fromJson(Map<String, dynamic> json) =>
      _$IndexActivityModuleFromJson(json);
}
