import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

///TextStyle
///
///  alpha标准透明度（注意下面是透明度）
///
///  100%   --   00
///  90%   --   1A
///  80%   --   33
///  70%   --   4D
///  60%   --   66
///  50%   --   80
///  40%   --   99
///  30%   --   B3
///  20%   --   CC
///  10%   --   E6
///  0%   --   FF
///命名规则：  t-字体大小-颜色-权重-A-不透明度（整形1代表0.1）

const FontWeight fontWeightLight = FontWeight.w300; // light
const FontWeight fontWeightRegular = FontWeight.w400; // normal/default
const FontWeight fontWeightMedium = FontWeight.w600;
const FontWeight fontWeightSemibold = FontWeight.w600;
const FontWeight fontWeightBold = FontWeight.w700; // 系统bold
const double textHeight = 1.1;

const TextStyle t10white = TextStyle(
  color: textWhite,
  fontSize: 10,
  height: 1.1,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t12white = TextStyle(
  color: textWhite,
  fontSize: 12,
  height: 1.1,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t12whiteBold = TextStyle(
  color: textWhite,
  fontSize: 12,
  decoration: TextDecoration.none,
  fontWeight: fontWeightBold,
);

const TextStyle t12whiteA3 = TextStyle(
  color: Color(0xB3FFFFFF),
  fontSize: 12,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t12white70 = TextStyle(
  color: textWhite70,
  fontSize: 12,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t12whiteA7 = TextStyle(
  color: Color(0xB3FFFFFF),
  fontSize: 12,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14white = TextStyle(
  color: textWhite,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14whiteBold = TextStyle(
  color: textWhite,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightMedium,
);

const TextStyle t20whitebold = TextStyle(
  color: textWhite,
  fontSize: 20,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t12blackbold = TextStyle(
  color: textBlack,
  fontSize: 12,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t12black = TextStyle(
  color: textBlack,
  fontSize: 12,
  decoration: TextDecoration.none,
  height: 1.1,
  fontWeight: fontWeightRegular,
);

const TextStyle t12blackBold = TextStyle(
  color: textBlack,
  fontSize: 12,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t13black = TextStyle(
  color: textBlack,
  fontSize: 13,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14black = TextStyle(
  color: textBlack,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14blackBold = TextStyle(
  color: textBlack,
  fontSize: 14,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t16black = TextStyle(
  color: textBlack,
  fontSize: 16,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t16blackbold = TextStyle(
  color: textBlack,
  fontSize: 16,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t18black = TextStyle(
  color: textBlack,
  fontSize: 18,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t18blackbold = TextStyle(
  color: textBlack,
  fontSize: 18,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t20black = TextStyle(
  color: textBlack,
  fontSize: 20,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t20blackBold = TextStyle(
  color: textBlack,
  fontSize: 20,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t24blackBold = TextStyle(
  color: textBlack,
  fontSize: 24,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t28blackBold = TextStyle(
  color: textBlack,
  fontSize: 28,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t32blackBold = TextStyle(
  color: textBlack,
  fontSize: 32,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t10red = TextStyle(
  color: textRed,
  fontSize: 10,
  height: 1.1,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t12red = TextStyle(
  color: textRed,
  fontSize: 12,
  height: 1.1,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14red = TextStyle(
  color: textRed,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t16red = TextStyle(
  color: textRed,
  fontSize: 16,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t16redBold = TextStyle(
  color: textRed,
  fontSize: 16,
  decoration: TextDecoration.none,
  fontWeight: fontWeightSemibold,
);

const TextStyle t18redBold = TextStyle(
  color: textRed,
  fontSize: 18,
  decoration: TextDecoration.none,
  fontWeight: fontWeightSemibold,
);

const TextStyle t27redBold = TextStyle(
  color: textRed,
  fontSize: 27,
  decoration: TextDecoration.none,
  fontWeight: fontWeightSemibold,
);

const TextStyle t10grey = TextStyle(
  color: textGrey,
  fontSize: 10,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t12grey = TextStyle(
  color: textGrey,
  fontSize: 12,
  fontWeight: fontWeightRegular,
  decoration: TextDecoration.none,
);

const TextStyle t12greyBold = TextStyle(
  color: textGrey,
  fontSize: 12,
  decoration: TextDecoration.none,
  fontWeight: fontWeightMedium,
);

const TextStyle t12darkGrey = TextStyle(
  color: textDarkGrey,
  fontSize: 12,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t12lightGrey = TextStyle(
  color: textHint,
  fontSize: 12,
  height: 1.1,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14grey = TextStyle(
  color: textGrey,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14darkGrey = TextStyle(
  color: textDarkGrey,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t16grey = TextStyle(
  color: textGrey,
  fontSize: 16,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t16darkGrey = TextStyle(
  color: textDarkGrey,
  fontSize: 16,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t18grey = TextStyle(
  color: textGrey,
  fontSize: 18,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14lightGrey = TextStyle(
  color: textLightGrey,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t16white = TextStyle(
  color: textWhite,
  fontSize: 16,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t16whiteblod = TextStyle(
  color: textWhite,
  fontSize: 16,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t18whiteBold = TextStyle(
  color: textWhite,
  fontSize: 18,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t24white = TextStyle(
  color: textWhite,
  fontSize: 24,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t24whiteblod = TextStyle(
  color: textWhite,
  fontSize: 24,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t12blue = TextStyle(
  color: textBlue,
  fontSize: 12,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14blue = TextStyle(
  color: textBlue,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14blueBold = TextStyle(
  color: textBlue,
  fontSize: 14,
  fontWeight: fontWeightMedium,
  decoration: TextDecoration.none,
);

const TextStyle t16blue = TextStyle(
  color: textBlue,
  fontSize: 16,
  fontWeight: fontWeightRegular,
  decoration: TextDecoration.none,
);

const TextStyle t18blue = TextStyle(
  color: textBlue,
  fontSize: 18,
  fontWeight: fontWeightRegular,
  decoration: TextDecoration.none,
);

const TextStyle t24blue = TextStyle(
  color: textBlue,
  fontSize: 24,
  fontWeight: fontWeightRegular,
  decoration: TextDecoration.none,
);

const TextStyle t12hintText = TextStyle(
  color: textHint,
  fontSize: 12,
  fontWeight: fontWeightRegular,
  decoration: TextDecoration.none,
);

const TextStyle t14hintText = TextStyle(
  color: textHint,
  fontSize: 14,
  fontWeight: fontWeightRegular,
  decoration: TextDecoration.none,
);

const TextStyle t16hintText = TextStyle(
  color: textHint,
  fontSize: 16,
  decoration: TextDecoration.none,
);

const TextStyle t14Green = TextStyle(
  color: textGreen,
  fontSize: 14,
  decoration: TextDecoration.none,
);

///提醒字体
const TextStyle t12warmingRed = TextStyle(
  color: textWarning,
  fontSize: 12,
  decoration: TextDecoration.none,
);

///提醒字体
const TextStyle t14warmingYellow = TextStyle(
  color: textWarning,
  fontSize: 14,
  decoration: TextDecoration.none,
);

const TextStyle t10Yellow = TextStyle(
  color: textYellow,
  fontSize: 10,
  height: 1.1,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t12Yellow = TextStyle(
  color: textYellow,
  fontSize: 12,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14Yellow = TextStyle(
  color: textYellow,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t14YellowBold = TextStyle(
  color: textYellow,
  fontSize: 14,
  decoration: TextDecoration.none,
  fontWeight: fontWeightMedium,
);

///橘色字体

const TextStyle t10Orange = TextStyle(
  color: textOrange,
  fontSize: 10,
  height: 1.1,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

const TextStyle t12Orange = TextStyle(
  color: textOrange,
  fontSize: 12,
  height: 1.1,
  decoration: TextDecoration.none,
  fontWeight: fontWeightRegular,
);

///-------------------------数字字体----------------------------

///-------------------------白色----------------------------
const TextStyle num12White = TextStyle(
    color: textWhite,
    fontSize: 12,
    decoration: TextDecoration.none,
    fontFamily: 'DINAlternateBold');

const TextStyle num14White = TextStyle(
    color: textWhite,
    fontSize: 14,
    decoration: TextDecoration.none,
    fontFamily: 'DINAlternateBold');

const TextStyle num16White = TextStyle(
    color: textWhite,
    fontSize: 16,
    decoration: TextDecoration.none,
    fontFamily: 'DINAlternateBold');

const TextStyle num18White = TextStyle(
    color: textWhite,
    fontSize: 18,
    decoration: TextDecoration.none,
    fontFamily: 'DINAlternateBold');

const TextStyle num24White = TextStyle(
  color: textWhite,
  fontSize: 24,
  decoration: TextDecoration.none,
  fontFamily: 'DINAlternateBold',
);
