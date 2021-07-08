import 'package:json_annotation/json_annotation.dart';

part 'newUserGiftModel.g.dart';

@JsonSerializable()
class NewUserGift {
  bool showEntrance;
  bool showGiftWin;
  bool showItemDetailGiftWin;
  num winType;
  bool newUser;
  NewUserGiftData newUserGift;

  NewUserGift();

  factory NewUserGift.fromJson(Map<String, dynamic> json) =>
      _$NewUserGiftFromJson(json);
}

@JsonSerializable()
class NewUserGiftData {
  String showPic;
  num price;
  num expireTime;
  num useExpireTime;
  num status;
  num currentTime;

  NewUserGiftData();

  factory NewUserGiftData.fromJson(Map<String, dynamic> json) =>
      _$NewUserGiftDataFromJson(json);
}
