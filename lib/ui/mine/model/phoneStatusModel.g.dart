// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phoneStatusModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneStatusModel _$PhoneStatusModelFromJson(Map<String, dynamic> json) =>
    PhoneStatusModel()
      ..status = json['status'] as num?
      ..mobile = json['mobile'] as String?
      ..ucMobile = json['ucMobile'] as String?
      ..degrade = json['degrade'] as bool?
      ..mobileBindFlowControl = json['mobileBindFlowControl'] as bool?
      ..frequentlyAccount = json['frequentlyAccount'] as bool?;

Map<String, dynamic> _$PhoneStatusModelToJson(PhoneStatusModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'mobile': instance.mobile,
      'ucMobile': instance.ucMobile,
      'degrade': instance.degrade,
      'mobileBindFlowControl': instance.mobileBindFlowControl,
      'frequentlyAccount': instance.frequentlyAccount,
    };
