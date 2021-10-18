// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrCodeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeModel _$QrCodeModelFromJson(Map<String, dynamic> json) => QrCodeModel()
  ..userId = json['userId'] as num?
  ..userName = json['userName'] as String?
  ..avatarUrl = json['avatarUrl'] as String?
  ..authIconUrl = json['authIconUrl'] as String?
  ..memberLevel = json['memberLevel'] as num?
  ..qrCode = json['qrCode'] as String?;

Map<String, dynamic> _$QrCodeModelToJson(QrCodeModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'avatarUrl': instance.avatarUrl,
      'authIconUrl': instance.authIconUrl,
      'memberLevel': instance.memberLevel,
      'qrCode': instance.qrCode,
    };
