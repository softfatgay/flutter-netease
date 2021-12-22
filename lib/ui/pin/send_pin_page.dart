import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/goods_detail/model/skuListItem.dart';
import 'package:flutter_app/ui/mine/model/locationItemModel.dart';
import 'package:flutter_app/ui/pin/model/pinItemDetailModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/toast.dart';

class SendPinPage extends StatefulWidget {
  final Map? params;

  const SendPinPage({Key? key, this.params}) : super(key: key);

  @override
  _SendPinPageState createState() => _SendPinPageState();
}

class _SendPinPageState extends State<SendPinPage> {
  SkuListItem? _skuListItem;

  late PinItemDetailModel _detailModel;
  ItemInfo? _itemInfo;

  bool _loading = true;

  bool _checked = true;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _skuListItem = widget.params!['skuItem'];
    });
    super.initState();
    _sendInfo();
  }

  void _sendInfo() async {
    Map<String, dynamic> params = {
      'pinItemId': _skuListItem!.baseId,
      'skuId': _skuListItem!.skuId,
      'huoDongId': 0,
    };
    var responseData = await pinOrder(params);
    if (responseData.code == '200') {
      setState(() {
        _detailModel = PinItemDetailModel.fromJson(responseData.data);
        _itemInfo = _detailModel.itemInfo;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: TopAppBar(
        title: '拼团',
      ).build(context),
      body: _loading
          ? Loading()
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _address(),
                        _price(),
                        _good(),
                        _arguement(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    height: 52,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                          color: backWhite,
                          border: Border(
                              top: BorderSide(color: lineColor, width: 1))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            '实付：¥${_itemInfo!.totalPrice}',
                            style: num14Red,
                          )),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 1),
                              decoration: BoxDecoration(
                                  color: backRed,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${_itemInfo!.totalPrice}',
                                    style: num14White,
                                  ),
                                  Text(
                                    '发起拼团',
                                    style: t12white,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              _pinSubmit();
                            },
                          )
                        ],
                      ),
                    )),
              ],
            ),
    );
  }

  _address() {
    var addressItem = LocationItemModel();
    var address = _detailModel.shipAddressList!;
    for (var item in address) {
      if (item.dft!) {
        addressItem = item;
      }
    }
    return Container(
      color: backWhite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/address_line.png', width: double.infinity),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text('${addressItem.name}'),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text('${addressItem.mobile}'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 6, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('${addressItem.fullAddress}'),
                    )
                  ],
                ),
              ),
              arrowRightIcon,
              SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }

  _price() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: backWhite,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
              child: Text(
            '商品合计',
            style: t14black,
          )),
          Text(
            '¥${_itemInfo!.totalPrice}',
            style: num14Black,
          ),
        ],
      ),
    );
  }

  _good() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: backWhite,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _detailModel.pinOrderCartItemList!
              .map((item) => _goodItem(item))
              .toList()),
    );
  }

  Container _goodItem(PinOrderCartItem item) {
    return Container(
      child: Row(
        children: [
          RoundNetImage(
            backColor: backColor,
            url: '${item.picUrl}',
            height: 60,
            width: 60,
            corner: 4,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (item.subtotalPrice == item.retailPrice)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                            color: backRed,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          '全额返',
                          style: TextStyle(
                              fontSize: 12, height: 1, color: textWhite),
                        ),
                      ),
                    Expanded(
                      child: Text(
                        '${item.name}',
                        style: t14black,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (item.specValueList != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: item.specValueList!
                        .map((e) => Container(
                              child: Text('$e'),
                            ))
                        .toList(),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '¥${item.retailPrice}  ',
                        style: num14Black,
                      ),
                      Text(
                        '¥${item.originPrice}',
                        style: TextStyle(
                            fontSize: 12,
                            color: textGrey,
                            decoration: TextDecoration.lineThrough,
                            fontFamily: 'DINAlternateBold'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _arguement() {
    return Container(
      child: Row(
        children: [
          Checkbox(value: _checked, onChanged: (checked) {}),
          Text(
            '我已同意',
            style: t14grey,
          ),
          GestureDetector(
            child: Text(
              '《严选平台服务协议》',
              style: t14black,
            ),
            onTap: () {
              Routers.push(Routers.webView, context,
                  {'url': '${NetConstants.baseUrl}help#/agreement'});
            },
          ),
        ],
      ),
    );
  }

  void _pinSubmit() async {
    var addressItem = LocationItemModel();
    var address = _detailModel.shipAddressList!;
    for (var item in address) {
      if (item.dft!) {
        addressItem = item;
      }
    }

    Map<String, dynamic> params = {
      'pinItemId': _itemInfo!.id,
      'skuId': _detailModel.skuInfo!.id,
      'huoDongId': _detailModel.huoDongId,
      'shipAddressId': addressItem.id
    };
    var responseData = await pinSubmit(params);
    if (responseData.code == '200') {
      Toast.show('发起拼团成功', context);
      Navigator.pop(context);
    }
  }
}
