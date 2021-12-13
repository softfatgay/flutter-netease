// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laywayDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaywayDetailModel _$LaywayDetailModelFromJson(Map<String, dynamic> json) =>
    LaywayDetailModel()
      ..moreLayawayList = (json['moreLayawayList'] as List<dynamic>?)
          ?.map((e) =>
              MoreLayawayListItemModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..policyList = (json['policyList'] as List<dynamic>?)
          ?.map((e) => PolicyListItemModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..layaway = json['layaway'] == null
          ? null
          : LayawayInModel.fromJson(json['layaway'] as Map<String, dynamic>);

Map<String, dynamic> _$LaywayDetailModelToJson(LaywayDetailModel instance) =>
    <String, dynamic>{
      'moreLayawayList': instance.moreLayawayList,
      'policyList': instance.policyList,
      'layaway': instance.layaway,
    };

LayawayInModel _$LayawayInModelFromJson(Map<String, dynamic> json) =>
    LayawayInModel()
      ..id = json['id'] as num?
      ..name = json['name'] as String?
      ..title = json['title'] as String?
      ..phaseNum = json['phaseNum'] as num?
      ..originalPrice = json['originalPrice'] as num?
      ..retailPrice = json['retailPrice'] as num?
      ..primaryPicUrl = json['primaryPicUrl'] as String?
      ..listPicUrl = json['listPicUrl'] as String?
      ..memLevel = json['memLevel'] as num?
      ..status = json['status'] as num?
      ..virtualVolumeSurplus = json['virtualVolumeSurplus'] as num?
      ..units = json['units'] as num?
      ..phaseInterval = json['phaseInterval'] as num?
      ..monthDay = json['monthDay'] as num?
      ..detail = json['detail'] == null
          ? null
          : DetailModel.fromJson(json['detail'] as Map<String, dynamic>)
      ..issueList = (json['issueList'] as List<dynamic>?)
          ?.map((e) => IssueListItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..soldOut = json['soldOut'] as bool?
      ..commonIssueShow = json['commonIssueShow'] as num?
      ..purchaseStatus = json['purchaseStatus'] as num?
      ..saleType = json['saleType'] as num?
      ..phaseSkuList = (json['phaseSkuList'] as List<dynamic>?)
          ?.map(
              (e) => PhaseSkuListItemModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$LayawayInModelToJson(LayawayInModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'phaseNum': instance.phaseNum,
      'originalPrice': instance.originalPrice,
      'retailPrice': instance.retailPrice,
      'primaryPicUrl': instance.primaryPicUrl,
      'listPicUrl': instance.listPicUrl,
      'memLevel': instance.memLevel,
      'status': instance.status,
      'virtualVolumeSurplus': instance.virtualVolumeSurplus,
      'units': instance.units,
      'phaseInterval': instance.phaseInterval,
      'monthDay': instance.monthDay,
      'detail': instance.detail,
      'issueList': instance.issueList,
      'soldOut': instance.soldOut,
      'commonIssueShow': instance.commonIssueShow,
      'purchaseStatus': instance.purchaseStatus,
      'saleType': instance.saleType,
      'phaseSkuList': instance.phaseSkuList,
    };

DetailModel _$DetailModelFromJson(Map<String, dynamic> json) => DetailModel()
  ..keyword = json['keyword'] as String?
  ..seoDesc = json['seoDesc'] as String?
  ..detailHtml = json['detailHtml'] as String?
  ..picUrl1 = json['picUrl1'] as String?
  ..picUrl2 = json['picUrl2'] as String?
  ..picUrl3 = json['picUrl3'] as String?
  ..picUrl4 = json['picUrl4'] as String?;

Map<String, dynamic> _$DetailModelToJson(DetailModel instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'seoDesc': instance.seoDesc,
      'detailHtml': instance.detailHtml,
      'picUrl1': instance.picUrl1,
      'picUrl2': instance.picUrl2,
      'picUrl3': instance.picUrl3,
      'picUrl4': instance.picUrl4,
    };

PhaseSkuListItemModel _$PhaseSkuListItemModelFromJson(
        Map<String, dynamic> json) =>
    PhaseSkuListItemModel()
      ..phaseNo = json['phaseNo'] as num?
      ..skuList = (json['skuList'] as List<dynamic>?)
          ?.map((e) =>
              LayawaySkuListItemModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PhaseSkuListItemModelToJson(
        PhaseSkuListItemModel instance) =>
    <String, dynamic>{
      'phaseNo': instance.phaseNo,
      'skuList': instance.skuList,
    };

LayawaySkuListItemModel _$LayawaySkuListItemModelFromJson(
        Map<String, dynamic> json) =>
    LayawaySkuListItemModel()
      ..id = json['id'] as num?
      ..layawayId = json['layawayId'] as num?
      ..layawayPhaseId = json['layawayPhaseId'] as num?
      ..layawayItemId = json['layawayItemId'] as num?
      ..itemId = json['itemId'] as num?
      ..skuId = json['skuId'] as num?
      ..itemName = json['itemName'] as String?
      ..picUrl = json['picUrl'] as String?
      ..specification = json['specification'] as String?
      ..originalPrice = json['originalPrice'] as num?
      ..count = json['count'] as num?;

Map<String, dynamic> _$LayawaySkuListItemModelToJson(
        LayawaySkuListItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'layawayId': instance.layawayId,
      'layawayPhaseId': instance.layawayPhaseId,
      'layawayItemId': instance.layawayItemId,
      'itemId': instance.itemId,
      'skuId': instance.skuId,
      'itemName': instance.itemName,
      'picUrl': instance.picUrl,
      'specification': instance.specification,
      'originalPrice': instance.originalPrice,
      'count': instance.count,
    };

MoreLayawayListItemModel _$MoreLayawayListItemModelFromJson(
        Map<String, dynamic> json) =>
    MoreLayawayListItemModel()
      ..listPicUrl = json['listPicUrl'] as String?
      ..primaryPicUrl = json['primaryPicUrl'] as String?
      ..name = json['name'] as String?
      ..id = json['id'] as num?
      ..title = json['title'] as String?
      ..retailPrice = json['retailPrice'] as num?
      ..phaseNum = json['phaseNum'] as num?
      ..point = json['point'] as num?
      ..favorPrice = json['favorPrice'] as num?;

Map<String, dynamic> _$MoreLayawayListItemModelToJson(
        MoreLayawayListItemModel instance) =>
    <String, dynamic>{
      'listPicUrl': instance.listPicUrl,
      'primaryPicUrl': instance.primaryPicUrl,
      'name': instance.name,
      'id': instance.id,
      'title': instance.title,
      'retailPrice': instance.retailPrice,
      'phaseNum': instance.phaseNum,
      'point': instance.point,
      'favorPrice': instance.favorPrice,
    };

PolicyListItemModel _$PolicyListItemModelFromJson(Map<String, dynamic> json) =>
    PolicyListItemModel()
      ..title = json['title'] as String?
      ..distributionArea = json['distributionArea'] == null
          ? null
          : DistributionAreaModel.fromJson(
              json['distributionArea'] as Map<String, dynamic>);

Map<String, dynamic> _$PolicyListItemModelToJson(
        PolicyListItemModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'distributionArea': instance.distributionArea,
    };

DistributionAreaModel _$DistributionAreaModelFromJson(
        Map<String, dynamic> json) =>
    DistributionAreaModel()
      ..districtList = (json['districtList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..provinceList = (json['provinceList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..cityList =
          (json['cityList'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..support = json['support'] as bool?;

Map<String, dynamic> _$DistributionAreaModelToJson(
        DistributionAreaModel instance) =>
    <String, dynamic>{
      'districtList': instance.districtList,
      'provinceList': instance.provinceList,
      'cityList': instance.cityList,
      'support': instance.support,
    };
