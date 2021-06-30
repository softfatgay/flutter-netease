import 'package:json_annotation/json_annotation.dart';

part 'phoneStatusModel.g.dart';

@JsonSerializable()
class PhoneStatusModel {
  num status;
  String mobile;
  String ucMobile;
  bool degrade;
  bool mobileBindFlowControl;
  bool frequentlyAccount;

  PhoneStatusModel();

  factory PhoneStatusModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneStatusModelFromJson(json);
}
