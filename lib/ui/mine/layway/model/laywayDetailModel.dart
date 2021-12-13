import 'package:flutter_app/ui/goods_detail/model/issueListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'laywayDetailModel.g.dart';

@JsonSerializable()
class LaywayDetailModel {
  List<MoreLayawayListItemModel>? moreLayawayList;
  List<PolicyListItemModel>? policyList;
  LayawayInModel? layaway;

  LaywayDetailModel();

  factory LaywayDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LaywayDetailModelFromJson(json);
}

@JsonSerializable()
class LayawayInModel {
  num? id;
  String? name;
  String? title;
  num? phaseNum;
  num? originalPrice;
  num? retailPrice;
  String? primaryPicUrl;
  String? listPicUrl;
  num? memLevel;
  num? status;
  num? virtualVolumeSurplus;
  num? units;
  num? phaseInterval;
  num? monthDay;

  DetailModel? detail;

  List<IssueListItem>? issueList;
  bool? soldOut;
  num? commonIssueShow;
  num? purchaseStatus;
  num? saleType;
  List<PhaseSkuListItemModel>? phaseSkuList;

  LayawayInModel();

  factory LayawayInModel.fromJson(Map<String, dynamic> json) =>
      _$LayawayInModelFromJson(json);
}

@JsonSerializable()
class DetailModel {
  String? keyword;
  String? seoDesc;
  String? detailHtml;
  String? picUrl1;
  String? picUrl2;
  String? picUrl3;
  String? picUrl4;

  DetailModel();

  factory DetailModel.fromJson(Map<String, dynamic> json) =>
      _$DetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailModelToJson(this);
}

@JsonSerializable()
class PhaseSkuListItemModel {
  num? phaseNo;
  List<LayawaySkuListItemModel>? skuList;

  PhaseSkuListItemModel();

  factory PhaseSkuListItemModel.fromJson(Map<String, dynamic> json) =>
      _$PhaseSkuListItemModelFromJson(json);
}

@JsonSerializable()
class LayawaySkuListItemModel {
  num? id;
  num? layawayId;
  num? layawayPhaseId;
  num? layawayItemId;
  num? itemId;
  num? skuId;
  String? itemName;
  String? picUrl;
  String? specification;
  num? originalPrice;
  num? count;

  LayawaySkuListItemModel();
  factory LayawaySkuListItemModel.fromJson(Map<String, dynamic> json) =>
      _$LayawaySkuListItemModelFromJson(json);
}

@JsonSerializable()
class MoreLayawayListItemModel {
  String? listPicUrl;
  String? primaryPicUrl;
  String? name;
  num? id;
  String? title;
  num? retailPrice;
  num? phaseNum;
  num? point;
  num? favorPrice;

  MoreLayawayListItemModel();

  factory MoreLayawayListItemModel.fromJson(Map<String, dynamic> json) =>
      _$MoreLayawayListItemModelFromJson(json);
}

@JsonSerializable()
class PolicyListItemModel {
  String? title;
  DistributionAreaModel? distributionArea;

  PolicyListItemModel();

  factory PolicyListItemModel.fromJson(Map<String, dynamic> json) =>
      _$PolicyListItemModelFromJson(json);
}

@JsonSerializable()
class DistributionAreaModel {
  List<String>? districtList;
  List<String>? provinceList;
  List<String>? cityList;
  bool? support;

  DistributionAreaModel();

  factory DistributionAreaModel.fromJson(Map<String, dynamic> json) =>
      _$DistributionAreaModelFromJson(json);
}
