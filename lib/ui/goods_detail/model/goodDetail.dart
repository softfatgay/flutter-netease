import 'package:flutter_app/model/categoryL1ListItem.dart';
import 'package:flutter_app/model/itemTagListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/bannerModel.dart';
import 'package:flutter_app/ui/goods_detail/model/commentsItem.dart';
import 'package:flutter_app/ui/goods_detail/model/commondPageModel.dart';
import 'package:flutter_app/ui/goods_detail/model/finalPrice.dart';
import 'package:flutter_app/ui/goods_detail/model/hdrkDetailVOListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/issueListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/priceModel.dart';
import 'package:flutter_app/ui/goods_detail/model/shoppingReward.dart';
import 'package:flutter_app/ui/goods_detail/model/shoppingRewardRule.dart';
import 'package:flutter_app/ui/goods_detail/model/skuListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';
import 'package:flutter_app/ui/goods_detail/model/skuSpecListItem.dart';
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
  PriceModel price;

  Map<String, dynamic> itemDetail;

  List<SkuListItem> skuList;

  List<AttrListItem> attrList;
  Map<String, SkuMapValue> skuMap;
  List<SkuSpecListItem> skuSpecList;

  num sellVolume;
  List<IssueListItem> issueList;
  List<HdrkDetailVOListItem> hdrkDetailVOList;

  List<ResultItem> comments;

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
  List<String> couponShortNameList;
  DetailPromBanner detailPromBanner;
  WelfareCardVO welfareCardVO;

  SimpleBrandInfo simpleBrandInfo;

  SpmcBanner spmcBanner;
  ListPromBanner listPromBanner;
  BrandInfo brandInfo;
  String promTag;
  List<SpecListItem> specList;
  List<AdBannersItem> adBanners;

  TryOutEventReport tryOutEventReport;
  BannerModel banner;
  bool showPrice;

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
class FullRefundPolicy {
  String detailTitle;
  List<String> titles;
  List<String> content;

  FullRefundPolicy();

  factory FullRefundPolicy.fromJson(Map<String, dynamic> json) =>
      _$FullRefundPolicyFromJson(json);
}

@JsonSerializable()
class DetailPromBanner {
  num bannerType;
  String bannerTitleUrl;
  String bannerContentUrl;
  String promoTitle;
  String promoSubTitle;
  String startTime;
  String activityPrice;
  String retailPrice;
  String activityPriceExt;
  String sellVolumeDesc;
  num countdown;

  DetailPromBanner();

  factory DetailPromBanner.fromJson(Map<String, dynamic> json) =>
      _$DetailPromBannerFromJson(json);
}

@JsonSerializable()
class WelfareCardVO {
  String picUrl;
  String schemeUrl;

  WelfareCardVO();

  factory WelfareCardVO.fromJson(Map<String, dynamic> json) =>
      _$WelfareCardVOFromJson(json);
}

@JsonSerializable()
class SpmcBanner {
  String spmcDesc;
  String spmcPrice;
  String spmcPrivilegeMess;
  String spmcEconomizePrice;
  String spmcTagDesc;
  String spmcLinkUrl;
  String btnValue;

  SpmcBanner();

  factory SpmcBanner.fromJson(Map<String, dynamic> json) =>
      _$SpmcBannerFromJson(json);
}

@JsonSerializable()
class SimpleBrandInfo {
  String title;
  num ownType;
  String logoUrl;
  num aspectRatio;

  //
  SimpleBrandInfo();

  factory SimpleBrandInfo.fromJson(Map<String, dynamic> json) =>
      _$SimpleBrandInfoFromJson(json);
}

@JsonSerializable()
class ListPromBanner {
  bool valid;
  String promoTitle;
  String promoSubTitle;
  String content;
  String bannerTitleUrl;
  String bannerContentUrl;
  num styleType;
  num timeType;
  String iconUrl;

  ListPromBanner();

  factory ListPromBanner.fromJson(Map<String, dynamic> json) =>
      _$ListPromBannerFromJson(json);
}

@JsonSerializable()
class SpecListItem {
  String specName;
  String specValue;

  SpecListItem();

  factory SpecListItem.fromJson(Map<String, dynamic> json) =>
      _$SpecListItemFromJson(json);
}

@JsonSerializable()
class BrandInfo {
  num brandId;
  String title;
  String subTitle;
  String desc;
  num brandType;
  num type;
  String picUrl;
  num ownType;
  dynamic merchantId;

  BrandInfo();

  factory BrandInfo.fromJson(Map<String, dynamic> json) =>
      _$BrandInfoFromJson(json);
}

@JsonSerializable()
class AdBannersItem {
  String picUrl;
  String targetUrl;
  AdBannersExtra extra;

  AdBannersItem();
  factory AdBannersItem.fromJson(Map<String, dynamic> json) =>
      _$AdBannersItemFromJson(json);
}

@JsonSerializable()
class AdBannersExtra {
  num materialContentFrom;
  String materialName;
  bool rcmdSort;
  num taskType;
  num itemFrom;
  String crmUserGroupName;
  num resourcesId;
  String materialType;
  String crmUserGroupId;
  String materialId;
  String taskId;

  AdBannersExtra();

  factory AdBannersExtra.fromJson(Map<String, dynamic> json) =>
      _$AdBannersExtraFromJson(json);
}

@JsonSerializable()
class TryOutEventReport {
  String nickName;
  String job;
  String title;
  num score;
  Detail detail;

  TryOutEventReport();
  factory TryOutEventReport.fromJson(Map<String, dynamic> json) =>
      _$TryOutEventReportFromJson(json);
}

@JsonSerializable()
class Detail {
  String reportDetail;

  Detail();
  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
}
