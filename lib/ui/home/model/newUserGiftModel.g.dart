// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newUserGiftModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUserGift _$NewUserGiftFromJson(Map<String, dynamic> json) {
  return NewUserGift()
    ..showEntrance = json['showEntrance'] as bool
    ..showGiftWin = json['showGiftWin'] as bool
    ..showItemDetailGiftWin = json['showItemDetailGiftWin'] as bool
    ..winType = json['winType'] as num
    ..newUser = json['newUser'] as bool
    ..newUserGift = json['newUserGift'] == null
        ? null
        : NewUserGiftData.fromJson(json['newUserGift'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NewUserGiftToJson(NewUserGift instance) =>
    <String, dynamic>{
      'showEntrance': instance.showEntrance,
      'showGiftWin': instance.showGiftWin,
      'showItemDetailGiftWin': instance.showItemDetailGiftWin,
      'winType': instance.winType,
      'newUser': instance.newUser,
      'newUserGift': instance.newUserGift,
    };

NewUserGiftData _$NewUserGiftDataFromJson(Map<String, dynamic> json) {
  return NewUserGiftData()
    ..showPic = json['showPic'] as String
    ..price = json['price'] as num
    ..expireTime = json['expireTime'] as num
    ..useExpireTime = json['useExpireTime'] as num
    ..status = json['status'] as num
    ..currentTime = json['currentTime'] as num;
}

Map<String, dynamic> _$NewUserGiftDataToJson(NewUserGiftData instance) =>
    <String, dynamic>{
      'showPic': instance.showPic,
      'price': instance.price,
      'expireTime': instance.expireTime,
      'useExpireTime': instance.useExpireTime,
      'status': instance.status,
      'currentTime': instance.currentTime,
    };
