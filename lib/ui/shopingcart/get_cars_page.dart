import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopingcart/model/carItem.dart';
import 'package:flutter_app/ui/shopingcart/model/cartItemListItem.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/button_widget.dart';
import 'package:flutter_app/component/slivers.dart';

///换购
class GetCarsPage extends StatefulWidget {
  final Map params;

  const GetCarsPage({Key key, this.params}) : super(key: key);

  @override
  _GetCarsPageState createState() => _GetCarsPageState();
}

class _GetCarsPageState extends State<GetCarsPage> {
  List<CartItemListItem> _dataList = [];
  int _totalCnt = 0;
  int _allowCount = 0;
  String _listTitle = "";

  CarItem _carItem;
  String _from = '';
  num _promotionId = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<CartItemListItem> dataList = [];
    _carItem = widget.params['data'];
    var addBuyStepList = _carItem.addBuyStepList;
    int totalCnt = 0;
    if (addBuyStepList != null && addBuyStepList.isNotEmpty) {
      addBuyStepList.forEach((element_1) {
        if (_listTitle.isEmpty) {
          _listTitle = element_1.title;
        }
        var addBuyItemList = element_1.addBuyItemList;
        if (addBuyItemList != null && addBuyItemList.isNotEmpty) {
          addBuyItemList.forEach((element_2) {
            element_2.stepNo = element_1.stepNo;
            if (element_2.checked) {
              totalCnt += 1;
            }
            dataList.add(element_2);
          });
        }
      });
    }
    setState(() {
      _from = widget.params['from'];
      _promotionId = widget.params['promotionId'];
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
        title: '换购',
      ).build(context),
      body: Container(
        child: Stack(
          children: [
            _buildBody(),
            _buildTips(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildSubmitBtn(),
            )
          ],
        ),
      ),
    );
  }

  _buildBody() {
    return Container(
      color: backWhite,
      padding: EdgeInsets.symmetric(vertical: 45),
      child: CustomScrollView(
        slivers: [
          singleSliverWidget(
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: lineColor, width: 1))),
              width: double.infinity,
              height: 38,
              padding: EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                '$_listTitle',
                style: t14black,
              ),
            ),
          ),
          _buildList()
        ],
      ),
    );
  }

  _buildTips() {
    return Container(
      width: double.infinity,
      height: 38,
      color: backLightYellow,
      padding: EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        '最多可以选择$_allowCount件，已选$_totalCnt件',
        style: t14red,
      ),
    );
  }

  _buildItem(BuildContext context, int index) {
    var item = _dataList[index];
    return GestureDetector(
      child: Container(
        color: backWhite,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.only(right: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: _buildCheckBox(item),
              onTap: () {
                setState(() {
                  if (!item.checked) {
                    if (_allowCount > _totalCnt) {
                      _totalCnt++;
                      item.checked = true;
                    } else {
                      Toast.show('最多可领取$_allowCount件', context);
                    }
                  } else {
                    _totalCnt--;
                    item.checked = false;
                  }
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: backGrey, borderRadius: BorderRadius.circular(4)),
              height: 76,
              width: 76,
              child: CachedNetworkImage(imageUrl: item.pic ?? ''),
            ),
            _buildDec(item),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.goodDetail, context, {'id': item.itemId});
      },
    );
  }

  _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _buildItem(context, index);
    }, childCount: _dataList.length));
  }

  _buildCheckBox(CartItemListItem item) {
    return Container(
      color: backWhite,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      alignment: Alignment.center,
      child: Center(
        child: item.checked
            ? Icon(
                Icons.check_circle,
                size: 22,
                color: Colors.red,
              )
            : Icon(
                Icons.brightness_1_outlined,
                size: 22,
                color: lineColor,
              ),
      ),
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
                  'X${item.cnt}',
                  style: t16black,
                ),
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          item.specList == null || item.specList.isEmpty
              ? Container()
              : Text(
                  '${item.specList[0].specValue}',
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
      if (element.checked) {
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

    var responseData = await getCartsSubmit(param);
    if (responseData.code == '200') {
      Navigator.pop(context);
    }
  }

  _buildSubmitBtn() {
    return ActiveBtn(backRed, () {
      if (_from != null) {
        Routers.push(Routers.makeUpPage, context, {'id': _promotionId,'from':Routers.goodDetail});
      } else {
        _submit();
      }
    });
  }
}
