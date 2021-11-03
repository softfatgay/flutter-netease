import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/response_data.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopping_cart/model/carItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/cartItemListItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/redeemModel.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/button_widget.dart';
import 'package:flutter_app/component/slivers.dart';

const double _imageWith = 76;

///换购
class GetCarsPage extends StatefulWidget {
  final Map? params;

  const GetCarsPage({Key? key, this.params}) : super(key: key);

  @override
  _GetCarsPageState createState() => _GetCarsPageState();
}

class _GetCarsPageState extends State<GetCarsPage> {
  List<CartItemListItem> _dataList = [];
  int _totalCnt = 0;
  int? _allowCount = 0;
  String? _listTitle = "";

  late CarItem _carItem;
  String? _from = '';
  num? _promotionId = -1;
  List<AddBuyStepListItem> _listData = [];

  String _pageTitle = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<CartItemListItem> dataList = [];
    _carItem = widget.params!['data'] ?? CarItem();
    List<AddBuyStepListItem> listData = [];
    var promType = _carItem.promType;
    if (promType == 102) {
      ///满赠查看赠品
      listData = _carItem.giftStepList ?? [];
    } else {
      ///换购
      listData = _carItem.addBuyStepList ?? [];
    }

    int totalCnt = 0;
    if (listData.isNotEmpty) {
      List<CartItemListItem> cartItemList = [];
      listData.forEach((element_1) {
        if (_listTitle!.isEmpty) {
          _listTitle = element_1.title;
        }

        cartItemList = [];
        if (promType == 102) {
          ///满赠查看赠品
          cartItemList = element_1.giftItemList ?? [];
        } else {
          ///换购
          cartItemList = element_1.addBuyItemList ?? [];
        }
        if (cartItemList.isNotEmpty) {
          cartItemList.forEach((element_2) {
            element_2.stepNo = element_1.stepNo as int?;
            if (element_2.checked!) {
              totalCnt += 1;
            }
            dataList.add(element_2);
          });
        }
      });
    }
    setState(() {
      if (promType == 102) {
        _pageTitle = '满赠';
      } else {
        _pageTitle = '换购';
      }
      _listData = listData;
      _from = widget.params!['from'];
      _promotionId = widget.params!['promotionId'];
      _allowCount = _carItem.allowCount;
      _totalCnt = totalCnt;
      _dataList = dataList;
    });
    // _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: _pageTitle,
      ).build(context),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            _buildBodyC(),
            _buildTips(),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              left: 0,
              right: 0,
              child: _buildSubmitBtn(),
            )
          ],
        ),
      ),
    );
  }

  _buildBodyC() {
    List<Widget> widgets = [];
    _listData.forEach((element) {
      widgets.add(_buildTitle(element.title));
      widgets.add(_itemItems(element));
    });

    return Padding(
      padding: EdgeInsets.only(top: 38, bottom: 45),
      child: SingleChildScrollView(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  _itemItems(AddBuyStepListItem data) {
    List<CartItemListItem> cartItemList = [];
    if (_carItem.promType == 102) {
      ///满赠查看赠品
      cartItemList = data.giftItemList ?? [];
    } else {
      ///换购
      cartItemList = data.addBuyItemList ?? [];
    }

    return Column(
      children:
          cartItemList.map<Widget>((e) => _buildItem(context, e)).toList(),
    );
  }

  _buildTitle(String? title) {
    return title == null
        ? Container()
        : Container(
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                border: Border(bottom: BorderSide(color: lineColor, width: 1))),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            child: Text(
              '$title',
              style: t14black,
            ),
          );
  }

  _buildTips() {
    return Container(
      width: double.infinity,
      height: 38,
      color: Color(0xFFFFF8D8),
      padding: EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        '最多可以选择$_allowCount件，已选$_totalCnt件',
        style: t12Orange,
      ),
    );
  }

  _buildItem(BuildContext context, CartItemListItem item) {
    return GestureDetector(
      child: Container(
        color: backWhite,
        padding: EdgeInsets.only(right: 12, top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCheckbox(context, item),
            _buildImageInfo(context, item),
            SizedBox(width: 8),
            _buildDec(item),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.goodDetail, context, {'id': item.itemId});
      },
    );
  }

  _buildCheckbox(BuildContext context, CartItemListItem item) {
    return GestureDetector(
      child: _buildCheckBox(item),
      onTap: () {
        setState(() {
          if (item.sellVolume! > 0) {
            if (!item.checked!) {
              if (_allowCount! > _totalCnt) {
                _totalCnt++;
                item.checked = true;
              } else {
                Toast.show('最多可领取$_allowCount件', context);
              }
            } else {
              _totalCnt--;
              item.checked = false;
            }
          }
        });
      },
    );
  }

  _buildImageInfo(BuildContext context, CartItemListItem item) {
    return Container(
      height: _imageWith,
      width: _imageWith,
      child: Stack(
        children: [
          RoundNetImage(
            url: item.pic,
            backColor: backGrey,
            corner: 4,
            height: _imageWith,
            width: _imageWith,
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _imgFlag(item))
        ],
      ),
    );
  }

  _imgFlag(CartItemListItem item) {
    if (item.limitPurchaseFlag!) {
      ///限购标签
      return _limitPurchaseFlag(item);
    } else if (item.preemptionStatus! == 0) {
      ///无法购买标签
      return _cantBuyFlag(item, '无法领取');
    } else if (item.sellVolume == 0) {
      ///库存为0
      return _cantBuyFlag(item, '已领完');
    } else if (item.sellVolume! < 5) {
      return _cantBuyFlag(item, '仅剩${item.sellVolume}件');
    }
    return Container();
  }

  ///无法购买标签
  _cantBuyFlag(CartItemListItem item, String tips) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x80333333),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
      ),
      padding: EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.center,
      child: Text(
        '$tips',
        style: TextStyle(fontSize: 12, color: textWhite, height: 1.1),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  ///限购标签
  _limitPurchaseFlag(CartItemListItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF48F18),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
      ),
      padding: EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.center,
      child: Text(
        '限购${item.limitPurchaseCount}件',
        style: TextStyle(fontSize: 12, color: textWhite, height: 1.1),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildCheckBox(CartItemListItem item) {
    return Container(
      color: backWhite,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      alignment: Alignment.center,
      child: Center(
        child: item.sellVolume == 0
            ? _cantClickBox()
            : (item.checked! ? _checkedBox() : _canClickBox()),
      ),
    );
  }

  ///不能点击
  _cantClickBox() {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backGrey,
      ),
    );
  }

  ///可以点击
  _canClickBox() {
    return Icon(
      Icons.brightness_1_outlined,
      size: 22,
      color: Color(0xFFDBDBDB),
    );
  }

  ///已选择
  _checkedBox() {
    return Icon(
      Icons.check_circle,
      size: 22,
      color: redColor,
    );
  }

  _buildDec(CartItemListItem item) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${item.itemName}',
                  style: t14black,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  'x${item.cnt}',
                  style: t16black,
                ),
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          item.specList == null || item.specList!.isEmpty
              ? Container()
              : Text(
                  '${item.specList![0].specValue}',
                  style: t12grey,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                '¥${item.actualPrice}',
                style: t14black,
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  '¥${item.retailPrice}',
                  style: TextStyle(
                    fontSize: 14,
                    color: textGrey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _submit() async {
    List dataList = [];
    _dataList.forEach((element) {
      if (element.checked!) {
        var item = {
          'promotionId': _carItem.promId,
          'stepNo': element.stepNo,
          'skuId': element.skuId,
        };
        dataList.add(item);
      }
    });

    var param = {
      'promotionId': _carItem.promId,
      'selectList': dataList,
    };

    var responseData = ResponseData();

    if (_carItem.promType == 102) {
      responseData = await selectGiftSubmit(param);
    } else {
      responseData = await getCartsSubmit(param);
    }
    // var responseData = await getCartsSubmit(param);
    if (responseData.code == '200') {
      if (_from != null) {
        Routers.push(Routers.makeUpPage, context,
            {'id': _promotionId, 'from': Routers.goodDetail});
      } else {
        Navigator.pop(context);
      }
    }
  }

  _buildSubmitBtn() {
    return NormalBtn('确定', backRed, () {
      _submit();
    }, corner: 0);
  }
}
