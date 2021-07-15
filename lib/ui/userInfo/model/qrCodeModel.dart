import 'package:json_annotation/json_annotation.dart';

part 'qrCodeModel.g.dart';

@JsonSerializable()
class QrCodeModel {
  num userId;
  String userName;
  String avatarUrl;
  String authIconUrl;
  num memberLevel;
  String qrCode;

  QrCodeModel();

  factory QrCodeModel.fromJson(Map<String, dynamic> json) =>
      _$QrCodeModelFromJson(json);
}
