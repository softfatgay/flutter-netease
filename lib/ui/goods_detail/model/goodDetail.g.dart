// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodDetail _$GoodDetailFromJson(Map<String, dynamic> json) {
  return GoodDetail()
    ..id = json['id'] as num
    ..listPicUrl = json['listPicUrl'] as String
    ..name = json['name'] as String
    ..seoTitle = json['seoTitle'] as String
    ..simpleDesc = json['simpleDesc'] as String
    ..primaryPicUrl = json['primaryPicUrl'] as String
    ..primarySkuId = json['primarySkuId'] as num
    ..retailPrice = json['retailPrice'] as num
    ..counterPrice = json['counterPrice'] as num
    ..status = json['status'] as num
    ..rank = json['rank'] as num
    ..soldOut = json['soldOut'] as bool
    ..underShelf = json['underShelf'] as bool
    ..updateTime = json['updateTime'] as num
    ..itemDetail = json['itemDetail'] as Map<String, dynamic>
    ..skuList = (json['skuList'] as List)
        ?.map((e) =>
            e == null ? null : SkuListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..attrList = (json['attrList'] as List)
        ?.map((e) =>
            e == null ? null : AttrListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..skuMap = (json['skuMap'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : SkuMapValue.fromJson(e as Map<String, dynamic>)),
    )
    ..skuSpecList = (json['skuSpecList'] as List)
        ?.map((e) => e == null
            ? null
            : SkuSpecListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..sellVolume = json['sellVolume'] as num
    ..issueList = (json['issueList'] as List)
        ?.map((e) => e == null
            ? null
            : IssueListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..hdrkDetailVOList = (json['hdrkDetailVOList'] as List)
        ?.map((e) => e == null
            ? null
            : HdrkDetailVOListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..comments = (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : CommentsItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..newItemFlag = json['newItemFlag'] as bool
    ..primarySkuPreSellPrice = json['primarySkuPreSellPrice'] as num
    ..primarySkuPreSellStatus = json['primarySkuPreSellStatus'] as num
    ..pieceNum = json['pieceNum'] as num
    ..pieceUnitDesc = json['pieceUnitDesc'] as String
    ..colorNum = json['colorNum'] as num
    ..limitedFlag = json['limitedFlag'] as num
    ..promId = json['promId'] as num
    ..preLimitFlag = json['preLimitFlag'] as num
    ..productPlace = json['productPlace'] as String
    ..promotionDesc = json['promotionDesc'] as String
    ..specialPromTag = json['specialPromTag'] as String
    ..extraPrice = json['extraPrice'] as String
    ..appExclusiveFlag = json['appExclusiveFlag'] as bool
    ..itemTagList = (json['itemTagList'] as List)
        ?.map((e) => e == null
            ? null
            : ItemTagListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..isPreemption = json['isPreemption'] as num
    ..preemptionStatus = json['preemptionStatus'] as num
    ..buttonType = json['buttonType'] as num
    ..showTime = json['showTime'] as num
    ..onSaleTime = json['onSaleTime'] as num
    ..itemPromValid = json['itemPromValid'] as bool
    ..autoOnsaleTime = json['autoOnsaleTime'] as num
    ..autoOnsaleTimeLeft = json['autoOnsaleTimeLeft'] as num
    ..displaySkuId = json['displaySkuId'] as num
    ..saleCenterSkuId = json['saleCenterSkuId'] as num
    ..itemType = json['itemType'] as num
    ..points = json['points'] as num
    ..showPoints = json['showPoints'] as bool
    ..pointsPrice = json['pointsPrice'] as num
    ..forbidExclusiveCal = json['forbidExclusiveCal'] as bool
    ..commentCount = json['commentCount'] as num
    ..commentWithPicCount = json['commentWithPicCount'] as num
    ..freightInfo = json['freightInfo'] as String
    ..itemLimit = json['itemLimit'] as String
    ..itemSizeTableFlag = json['itemSizeTableFlag'] as bool
    ..itemSizeTableDetailFlag = json['itemSizeTableDetailFlag'] as bool
    ..featuredSeries = json['featuredSeries'] == null
        ? null
        : FeaturedSeries.fromJson(
            json['featuredSeries'] as Map<String, dynamic>)
    ..categoryList = (json['categoryList'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryL1ListItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..goodCmtRate = json['goodCmtRate'] as String
    ..promoTip = json['promoTip'] as String
    ..shoppingReward = json['shoppingReward'] == null
        ? null
        : ShoppingReward.fromJson(
            json['shoppingReward'] as Map<String, dynamic>)
    ..shoppingRewardRule = json['shoppingRewardRule'] == null
        ? null
        : ShoppingRewardRule.fromJson(
            json['shoppingRewardRule'] as Map<String, dynamic>)
    ..recommendReason =
        (json['recommendReason'] as List)?.map((e) => e as String)?.toList()
    ..skuFreight = json['skuFreight'] == null
        ? null
        : SkuFreight.fromJson(json['skuFreight'] as Map<String, dynamic>)
    ..fullRefundPolicy = json['fullRefundPolicy'] == null
        ? null
        : FullRefundPolicy.fromJson(
            json['fullRefundPolicy'] as Map<String, dynamic>)
    ..couponShortNameList =
        (json['couponShortNameList'] as List)?.map((e) => e as String)?.toList()
    ..detailPromBanner = json['detailPromBanner'] == null
        ? null
        : DetailPromBanner.fromJson(
            json['detailPromBanner'] as Map<String, dynamic>)
    ..welfareCardVO = json['welfareCardVO'] == null
        ? null
        : WelfareCardVO.fromJson(json['welfareCardVO'] as Map<String, dynamic>)
    ..simpleBrandInfo =
        json['simpleBrandInfo'] == null ? null : SimpleBrandInfo.fromJson(json['simpleBrandInfo'] as Map<String, dynamic>)
    ..spmcBanner = json['spmcBanner'] == null ? null : SpmcBanner.fromJson(json['spmcBanner'] as Map<String, dynamic>)
    ..listPromBanner = json['listPromBanner'] == null ? null : ListPromBanner.fromJson(json['listPromBanner'] as Map<String, dynamic>)
    ..promTag = json['promTag'] as String
    ..specList = (json['specList'] as List)?.map((e) => e == null ? null : SpecListItem.fromJson(e as Map<String, dynamic>))?.toList();
}

Map<String, dynamic> _$GoodDetailToJson(GoodDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listPicUrl': instance.listPicUrl,
      'name': instance.name,
      'seoTitle': instance.seoTitle,
      'simpleDesc': instance.simpleDesc,
      'primaryPicUrl': instance.primaryPicUrl,
      'primarySkuId': instance.primarySkuId,
      'retailPrice': instance.retailPrice,
      'counterPrice': instance.counterPrice,
      'status': instance.status,
      'rank': instance.rank,
      'soldOut': instance.soldOut,
      'underShelf': instance.underShelf,
      'updateTime': instance.updateTime,
      'itemDetail': instance.itemDetail,
      'skuList': instance.skuList,
      'attrList': instance.attrList,
      'skuMap': instance.skuMap,
      'skuSpecList': instance.skuSpecList,
      'sellVolume': instance.sellVolume,
      'issueList': instance.issueList,
      'hdrkDetailVOList': instance.hdrkDetailVOList,
      'comments': instance.comments,
      'newItemFlag': instance.newItemFlag,
      'primarySkuPreSellPrice': instance.primarySkuPreSellPrice,
      'primarySkuPreSellStatus': instance.primarySkuPreSellStatus,
      'pieceNum': instance.pieceNum,
      'pieceUnitDesc': instance.pieceUnitDesc,
      'colorNum': instance.colorNum,
      'limitedFlag': instance.limitedFlag,
      'promId': instance.promId,
      'preLimitFlag': instance.preLimitFlag,
      'productPlace': instance.productPlace,
      'promotionDesc': instance.promotionDesc,
      'specialPromTag': instance.specialPromTag,
      'extraPrice': instance.extraPrice,
      'appExclusiveFlag': instance.appExclusiveFlag,
      'itemTagList': instance.itemTagList,
      'isPreemption': instance.isPreemption,
      'preemptionStatus': instance.preemptionStatus,
      'buttonType': instance.buttonType,
      'showTime': instance.showTime,
      'onSaleTime': instance.onSaleTime,
      'itemPromValid': instance.itemPromValid,
      'autoOnsaleTime': instance.autoOnsaleTime,
      'autoOnsaleTimeLeft': instance.autoOnsaleTimeLeft,
      'displaySkuId': instance.displaySkuId,
      'saleCenterSkuId': instance.saleCenterSkuId,
      'itemType': instance.itemType,
      'points': instance.points,
      'showPoints': instance.showPoints,
      'pointsPrice': instance.pointsPrice,
      'forbidExclusiveCal': instance.forbidExclusiveCal,
      'commentCount': instance.commentCount,
      'commentWithPicCount': instance.commentWithPicCount,
      'freightInfo': instance.freightInfo,
      'itemLimit': instance.itemLimit,
      'itemSizeTableFlag': instance.itemSizeTableFlag,
      'itemSizeTableDetailFlag': instance.itemSizeTableDetailFlag,
      'featuredSeries': instance.featuredSeries,
      'categoryList': instance.categoryList,
      'goodCmtRate': instance.goodCmtRate,
      'promoTip': instance.promoTip,
      'shoppingReward': instance.shoppingReward,
      'shoppingRewardRule': instance.shoppingRewardRule,
      'recommendReason': instance.recommendReason,
      'skuFreight': instance.skuFreight,
      'fullRefundPolicy': instance.fullRefundPolicy,
      'couponShortNameList': instance.couponShortNameList,
      'detailPromBanner': instance.detailPromBanner,
      'welfareCardVO': instance.welfareCardVO,
      'simpleBrandInfo': instance.simpleBrandInfo,
      'spmcBanner': instance.spmcBanner,
      'listPromBanner': instance.listPromBanner,
      'promTag': instance.promTag,
      'specList': instance.specList,
    };

ItemDetail _$ItemDetailFromJson(Map<String, dynamic> json) {
  return ItemDetail()
    ..detailHtml = json['detailHtml'] as String
    ..picUrl1 = json['picUrl1'] as String
    ..picUrl2 = json['picUrl2'] as String
    ..picUrl3 = json['picUrl3'] as String
    ..picUrl4 = json['picUrl4'] as String
    ..picUrl5 = json['picUrl5'] as String
    ..videoInfo = json['videoInfo'] == null
        ? null
        : VideoInfo.fromJson(json['videoInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ItemDetailToJson(ItemDetail instance) =>
    <String, dynamic>{
      'detailHtml': instance.detailHtml,
      'picUrl1': instance.picUrl1,
      'picUrl2': instance.picUrl2,
      'picUrl3': instance.picUrl3,
      'picUrl4': instance.picUrl4,
      'picUrl5': instance.picUrl5,
      'videoInfo': instance.videoInfo,
    };

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) {
  return VideoInfo()
    ..mp4VideoUrl = json['mp4VideoUrl'] as String
    ..mp4VideoSize = json['mp4VideoSize'] as String
    ..webmVideoUrl = json['webmVideoUrl'] as String
    ..webmVideoSize = json['webmVideoSize'] as String;
}

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) => <String, dynamic>{
      'mp4VideoUrl': instance.mp4VideoUrl,
      'mp4VideoSize': instance.mp4VideoSize,
      'webmVideoUrl': instance.webmVideoUrl,
      'webmVideoSize': instance.webmVideoSize,
    };

AttrListItem _$AttrListItemFromJson(Map<String, dynamic> json) {
  return AttrListItem()
    ..attrName = json['attrName'] as String
    ..attrValue = json['attrValue'] as String;
}

Map<String, dynamic> _$AttrListItemToJson(AttrListItem instance) =>
    <String, dynamic>{
      'attrName': instance.attrName,
      'attrValue': instance.attrValue,
    };

FeaturedSeries _$FeaturedSeriesFromJson(Map<String, dynamic> json) {
  return FeaturedSeries()
    ..detailPicUrl = json['detailPicUrl'] as String
    ..id = json['id'] as num;
}

Map<String, dynamic> _$FeaturedSeriesToJson(FeaturedSeries instance) =>
    <String, dynamic>{
      'detailPicUrl': instance.detailPicUrl,
      'id': instance.id,
    };

FullRefundPolicy _$FullRefundPolicyFromJson(Map<String, dynamic> json) {
  return FullRefundPolicy()
    ..detailTitle = json['detailTitle'] as String
    ..titles = (json['titles'] as List)?.map((e) => e as String)?.toList()
    ..content = (json['content'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$FullRefundPolicyToJson(FullRefundPolicy instance) =>
    <String, dynamic>{
      'detailTitle': instance.detailTitle,
      'titles': instance.titles,
      'content': instance.content,
    };

DetailPromBanner _$DetailPromBannerFromJson(Map<String, dynamic> json) {
  return DetailPromBanner()
    ..bannerType = json['bannerType'] as num
    ..bannerTitleUrl = json['bannerTitleUrl'] as String
    ..bannerContentUrl = json['bannerContentUrl'] as String
    ..promoTitle = json['promoTitle'] as String
    ..promoSubTitle = json['promoSubTitle'] as String
    ..startTime = json['startTime'] as String
    ..activityPrice = json['activityPrice'] as String
    ..retailPrice = json['retailPrice'] as String
    ..activityPriceExt = json['activityPriceExt'] as String
    ..sellVolumeDesc = json['sellVolumeDesc'] as String
    ..countdown = json['countdown'] as num;
}

Map<String, dynamic> _$DetailPromBannerToJson(DetailPromBanner instance) =>
    <String, dynamic>{
      'bannerType': instance.bannerType,
      'bannerTitleUrl': instance.bannerTitleUrl,
      'bannerContentUrl': instance.bannerContentUrl,
      'promoTitle': instance.promoTitle,
      'promoSubTitle': instance.promoSubTitle,
      'startTime': instance.startTime,
      'activityPrice': instance.activityPrice,
      'retailPrice': instance.retailPrice,
      'activityPriceExt': instance.activityPriceExt,
      'sellVolumeDesc': instance.sellVolumeDesc,
      'countdown': instance.countdown,
    };

WelfareCardVO _$WelfareCardVOFromJson(Map<String, dynamic> json) {
  return WelfareCardVO()
    ..picUrl = json['picUrl'] as String
    ..schemeUrl = json['schemeUrl'] as String;
}

Map<String, dynamic> _$WelfareCardVOToJson(WelfareCardVO instance) =>
    <String, dynamic>{
      'picUrl': instance.picUrl,
      'schemeUrl': instance.schemeUrl,
    };

SpmcBanner _$SpmcBannerFromJson(Map<String, dynamic> json) {
  return SpmcBanner()
    ..spmcDesc = json['spmcDesc'] as String
    ..spmcPrice = json['spmcPrice'] as String
    ..spmcPrivilegeMess = json['spmcPrivilegeMess'] as String
    ..spmcEconomizePrice = json['spmcEconomizePrice'] as String
    ..spmcTagDesc = json['spmcTagDesc'] as String
    ..spmcLinkUrl = json['spmcLinkUrl'] as String;
}

Map<String, dynamic> _$SpmcBannerToJson(SpmcBanner instance) =>
    <String, dynamic>{
      'spmcDesc': instance.spmcDesc,
      'spmcPrice': instance.spmcPrice,
      'spmcPrivilegeMess': instance.spmcPrivilegeMess,
      'spmcEconomizePrice': instance.spmcEconomizePrice,
      'spmcTagDesc': instance.spmcTagDesc,
      'spmcLinkUrl': instance.spmcLinkUrl,
    };

SimpleBrandInfo _$SimpleBrandInfoFromJson(Map<String, dynamic> json) {
  return SimpleBrandInfo()
    ..title = json['title'] as String
    ..ownType = json['ownType'] as num
    ..logoUrl = json['logoUrl'] as String
    ..aspectRatio = json['aspectRatio'] as num;
}

Map<String, dynamic> _$SimpleBrandInfoToJson(SimpleBrandInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'ownType': instance.ownType,
      'logoUrl': instance.logoUrl,
      'aspectRatio': instance.aspectRatio,
    };

ListPromBanner _$ListPromBannerFromJson(Map<String, dynamic> json) {
  return ListPromBanner()
    ..valid = json['valid'] as bool
    ..promoTitle = json['promoTitle'] as String
    ..promoSubTitle = json['promoSubTitle'] as String
    ..content = json['content'] as String
    ..bannerTitleUrl = json['bannerTitleUrl'] as String
    ..bannerContentUrl = json['bannerContentUrl'] as String
    ..styleType = json['styleType'] as num
    ..timeType = json['timeType'] as num
    ..iconUrl = json['iconUrl'] as String;
}

Map<String, dynamic> _$ListPromBannerToJson(ListPromBanner instance) =>
    <String, dynamic>{
      'valid': instance.valid,
      'promoTitle': instance.promoTitle,
      'promoSubTitle': instance.promoSubTitle,
      'content': instance.content,
      'bannerTitleUrl': instance.bannerTitleUrl,
      'bannerContentUrl': instance.bannerContentUrl,
      'styleType': instance.styleType,
      'timeType': instance.timeType,
      'iconUrl': instance.iconUrl,
    };

SpecListItem _$SpecListItemFromJson(Map<String, dynamic> json) {
  return SpecListItem()
    ..specName = json['specName'] as String
    ..specValue = json['specValue'] as String;
}

Map<String, dynamic> _$SpecListItemToJson(SpecListItem instance) =>
    <String, dynamic>{
      'specName': instance.specName,
      'specValue': instance.specValue,
    };
