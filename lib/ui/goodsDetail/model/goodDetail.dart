import 'package:flutter_app/model/categoryL1ListItem.dart';
import 'package:flutter_app/model/itemTagListItem.dart';
import 'package:flutter_app/ui/goodsDetail/model/commentsItem.dart';
import 'package:flutter_app/ui/goodsDetail/model/hdrkDetailVOListItem.dart';
import 'package:flutter_app/ui/goodsDetail/model/issueListItem.dart';
import 'package:flutter_app/ui/goodsDetail/model/shoppingReward.dart';
import 'package:flutter_app/ui/goodsDetail/model/shoppingRewardRule.dart';
import 'package:flutter_app/ui/goodsDetail/model/skuListItem.dart';
import 'package:flutter_app/ui/goodsDetail/model/skuMapValue.dart';
import 'package:flutter_app/ui/goodsDetail/model/skuSpecListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goodDetail.g.dart';

@JsonSerializable()
class GoodDetail {
  num id;
  String listPicUrl;
  String name;
  String seoTitle;
  String simpleDesc;
  String primaryPicUrl;
  num primarySkuId;
  num retailPrice;
  num counterPrice;
  num status;
  num rank;
  bool soldOut;
  bool underShelf;
  num updateTime;

  ItemDetail itemDetail;

  List<SkuListItem> skuList;

  List<AttrListItem> attrList;
  Map<String, SkuMapValue> skuMap;
  List<SkuSpecListItem> skuSpecList;

  num sellVolume;
  List<IssueListItem> issueList;
  List<HdrkDetailVOListItem> hdrkDetailVOList;

  List<CommentsItem> comments;

  bool newItemFlag;
  num primarySkuPreSellPrice;
  num primarySkuPreSellStatus;
  num pieceNum;
  String pieceUnitDesc;
  num colorNum;
  num limitedFlag;
  num promId;
  num preLimitFlag;
  String productPlace;
  String promotionDesc;
  String specialPromTag;
  String extraPrice;
  bool appExclusiveFlag;
  List<ItemTagListItem> itemTagList;
  num isPreemption;
  num preemptionStatus;
  num buttonType;
  num showTime;
  num onSaleTime;
  bool itemPromValid;
  num autoOnsaleTime;
  num autoOnsaleTimeLeft;
  num displaySkuId;
  num saleCenterSkuId;
  num itemType;
  num points;
  bool showPoints;
  num pointsPrice;
  bool forbidExclusiveCal;
  num commentCount;
  num commentWithPicCount;
  String freightInfo;
  String itemLimit;
  bool itemSizeTableFlag;
  bool itemSizeTableDetailFlag;
  FeaturedSeries featuredSeries;
  List<CategoryL1ListItem> categoryList;

  ///是否有评价率
  String goodCmtRate;
  String promoTip;
  ShoppingReward shoppingReward;
  ShoppingRewardRule shoppingRewardRule;
  List<String> recommendReason;

  SkuFreight skuFreight;

  FullRefundPolicy fullRefundPolicy;




  GoodDetail();

  factory GoodDetail.fromJson(Map<String, dynamic> json) =>
      _$GoodDetailFromJson(json);
}

@JsonSerializable()
class ItemDetail {
  String detailHtml;
  String picUrl1;
  String picUrl2;
  String picUrl3;
  String picUrl4;
  String picUrl5;

  VideoInfo videoInfo;

  ItemDetail();

  factory ItemDetail.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailFromJson(json);
}

@JsonSerializable()
class VideoInfo {
  String mp4VideoUrl;
  String mp4VideoSize;
  String webmVideoUrl;
  String webmVideoSize;

  VideoInfo();

  factory VideoInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoInfoFromJson(json);
}

@JsonSerializable()
class AttrListItem {
  String attrName;
  String attrValue;

  AttrListItem();

  factory AttrListItem.fromJson(Map<String, dynamic> json) =>
      _$AttrListItemFromJson(json);
}

@JsonSerializable()
class FeaturedSeries {
  String detailPicUrl;
  num id;

  FeaturedSeries();

  factory FeaturedSeries.fromJson(Map<String, dynamic> json) =>
      _$FeaturedSeriesFromJson(json);
}


@JsonSerializable()
class FullRefundPolicy{

  List<String > titles;

  FullRefundPolicy();

  factory FullRefundPolicy.fromJson(Map<String, dynamic> json) =>
      _$FullRefundPolicyFromJson(json);
}