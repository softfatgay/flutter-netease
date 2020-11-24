import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/cart_check_box.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/content_loading.dart';
import 'package:flutter_app/widget/shopping_cart_count.dart';
import 'package:flutter_app/widget/slivers.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  var _data;
  List _cartGroupList = List();
  var _topItem;
  List _itemList = List();
  List _invalidCartGroupList = List();
  double _price = 0;
  double _promotionPrice = 0;
  double _actualPrice = 0;

  bool isChecked = false;
  bool _isCheckedAll = false;

  bool loading = false;
  int _selectedNum = 0;

  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    Map<String, dynamic> params = {"csrf_token": csrf_token};
    Map<String, dynamic> header = {"Cookie": cookie};

    var responseData = await shoppingCart(params, header: header);
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  void setData(var _data) {
    if (_data == null) {
      _getData();
    }
    setState(() {
      try {
        loading = false;
        _cartGroupList = _data['cartGroupList'];
        _invalidCartGroupList = _data['invalidCartGroupList'];
        _price = double.parse(_data['actualPrice'].toString());
        _promotionPrice = double.parse(_data['promotionPrice'].toString());
        _actualPrice = double.parse(_data['actualPrice'].toString());

        if (_cartGroupList.length > 0) {
          _topItem = _cartGroupList[0];
          if (_cartGroupList.length > 1) {
            _itemList = _cartGroupList;
            _itemList.removeAt(0);

            _selectedNum = 0;
            for (int i = 0; i < _itemList.length; i++) {
              List itemItems = _itemList[i]['cartItemList'];
              for (int i = 0; i < itemItems.length; i++) {
                if (itemItems[i]['checked']) {
                  print('/////////////');
                  _selectedNum += itemItems[i]['cnt'];
                }
              }
            }

            for (int i = 0; i < _itemList.length; i++) {
              List itemItems = _itemList[i]['cartItemList'];
              for (int i = 0; i < itemItems.length; i++) {
                _isCheckedAll = true;
                if (!itemItems[i]['checked']) {
                  _isCheckedAll = false;
                  return;
                }
              }
            }
          }
        }
      } catch (e) {
        loading = false;
      }
    });
  }

  _check() async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      'isChecked': isChecked
    };
    Map<String, dynamic> header = {"Cookie": cookie};
    var responseData = await shoppingCartCheck(params, header: header);
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  _checkOne(int source, int type, int skuId, bool isChecked, var extId) async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      'source': source,
      'type': type,
      'skuId': skuId,
      'isChecked': isChecked,
      'extId': extId,
    };
    Map<String, dynamic> header = {"Cookie": cookie};
    var responseData = await shoppingCartCheckOne(params, header: header);
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  _checkOneNum(int source, int type, int skuId, int cnt, var extId) async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      'source': source,
      'type': type,
      'skuId': skuId,
      'cnt': cnt,
      'extId': extId,
    };
    Map<String, dynamic> header = {"Cookie": cookie};
    var responseData = await shoppingCartCheckNum(params, header: header);
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                  color: Colors.white,
                border: Border(bottom: BorderSide(color: backColor,width: 1))
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    '购物车',
                    style: TextStyle(color: textBlack, fontSize: 18),
                  )),
                  isEdit
                      ? Container()
                      : Text(
                          '领券',
                          style: TextStyle(color: textRed, fontSize: 14),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        checkList.clear();
                        isEdit = !isEdit;
                      });
                    },
                    child: Text(
                      isEdit ? '完成' : '编辑',
                      style: TextStyle(color: textBlack, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
          ),
          _data == null
              ? Loading()
              : Positioned(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    removeBottom: true,
                      context: context, child: CustomScrollView(
                    slivers: [
                      singleSliverWidget(_buildTitle()),
                      singleSliverWidget(_dataList()),
                      singleSliverWidget(_invalidList()),
                      singleSliverWidget(Container(
                        height: 50,
                      ))
                    ],
                  )),
                  bottom: 50,
                  top: MediaQuery.of(context).padding.top + 46,
                  left: 0,
                  right: 0,
                ),
          Positioned(
            child: _buildBuy(),
            bottom: 0,
            left: 0,
            right: 0,
          ),
          loading ? Loading() : Container(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            color: backYellow,
            padding: EdgeInsets.only(left: 15),
            height: 44,
            child: Text(
              '${_data['postageVO']['postageTip']}',
              style: TextStyle(color: textRed, fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 6),
                  padding: EdgeInsets.fromLTRB(5, 1, 5, 2),
                  decoration: BoxDecoration(
                      color: redLightColor,
                      borderRadius: BorderRadius.circular(2)),
                  child: Text(
                    '全场换购',
                    style: t12white,
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${_topItem['promTip']}',
                    style: t16black,
                  ),
                )),
                GestureDetector(
                  child: Row(
                    children: [
                      Text(
                        '${_topItem['promotionBtn'] == 3 ? '再逛逛' : '去凑单'}',
                        style: t14red,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: textGrey,
                        size: 14,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.fromLTRB(50, 0, 15, 0),
              color: Color(0xFFFFF7F5),
              child: Row(
                children: [
                  Expanded(
                      child: Text(_actualPrice > 100 ? '去换购商品' : '查看换购商品')),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: textGrey,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 6,
          )
        ],
      ),
    );
  }

  Widget _dataList() {
    return  ListView.builder(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var itemData = _itemList[index];
        List itemList = itemData['cartItemList'];
        List<Widget> itemItems = itemList.map<Widget>((item) {
          return _buildItem(itemData, item, index);
        }).toList();
        itemItems.add(line);
        return Column(
          children: itemItems,
        );
      },
      itemCount: _itemList.length,
    );
  }

  Widget _buildItem(var itemData, var item, int index) {
    List cartItemTips = item['cartItemTips'];
    return Container(
      margin: EdgeInsets.only(bottom: 0.5),
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildCheckBox(itemData, item, index),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFDBDBDB),
                    borderRadius: BorderRadius.circular(4)),
                height: 90,
                width: 90,
                child: CachedNetworkImage(imageUrl: item['pic']),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isEdit
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '${item['itemName']}',
                                style: t14black,
                              ),
                            ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: lineColor, width: 1)),
                        child: Text(
                          '${_specValue(item)}',
                          style: t12grey,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                '¥${item['actualPrice'] == 0 ? item['actualPrice'] : item['retailPrice']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  item['retailPrice'] > item['actualPrice']
                                      ? '¥${item['retailPrice']}'
                                      : '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textGrey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: CartCount(
                                number: item['cnt'],
                                min: 1,
                                max: item['sellVolume'],
                                onChange: (index) {
                                  _checkOneNum(item['source'], item['type'],
                                      item['skuId'], index, item['extId']);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          (cartItemTips == null || cartItemTips.length == 0)
              ? Container()
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(35, 10, 0, 0),
                  decoration: BoxDecoration(color: backGrey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cartItemTips.map((item) {
                      return Container(
                        child: Text(
                          '• ${item}',
                          style: t12lgrey,
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  Widget line = Container(
    height: 10,
    color: Color(0xFFEAEAEA),
  );

  _specValue(var item) {
    List specList = item['specList'];
    String specName = '';
    for (var value in specList) {
      specName += value['specValue'];
      specName += "; ";
    }
    var replaceRange =
        specName.replaceRange(specName.length - 2, specName.length - 1, "");
    return replaceRange;
  }

  Widget _invalidList() {
    return (_invalidCartGroupList == null || _invalidCartGroupList.length == 0)
        ? Container()
        : Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: lineColor, width: 0.3))),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '失效商品',
                      style: t16black,
                    )),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: lineColor, width: 0.5)),
                      child: Text(
                        '清除失效商品',
                        style: t14black,
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildInvalidItem(_invalidCartGroupList[index]);
                },
                itemCount: _invalidCartGroupList.length,
              ),
            ],
          );
  }

  Widget _buildInvalidItem(var itemD) {
    List items = itemD['cartItemList'];
    return Column(
      children: items.map((item) {
        return Container(
          margin: EdgeInsets.only(bottom: 0.5),
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFDBDBDB),
                        borderRadius: BorderRadius.circular(4)),
                    height: 90,
                    width: 90,
                    child: CachedNetworkImage(imageUrl: item['pic']),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              '${item['itemName']}',
                              style: t16black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Text(
                              '${_specValue(item)}',
                              style: t14grey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '¥${item['retailPrice']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  int allCount = 0;

  _getPrice() {
    return _price;
  }

  List checkList = [];

  ///左侧选择框，编辑框
  _buildCheckBox(itemData, item, index) {
    if (isEdit) {
      return Container(
        margin: EdgeInsets.only(right: 6),
        child: CartCheckBox(
          onCheckChanged: (check) {
            _deleteCheckItem(check, itemData, item);
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(right: 6),
        child: InkWell(
          onTap: () {
            if (itemData['canCheck'] || item['checked']) {
              _checkOne(item['source'], item['type'], item['skuId'],
                  !item['checked'], item['extId']);
            }
          },
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: item['checked']
                  ? Icon(
                      Icons.check_circle,
                      size: 22,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.brightness_1_outlined,
                      size: 22,
                      color:
                          itemData['canCheck'] ? lineColor : Color(0xFFF7F6FA),
                    ),
            ),
          ),
        ),
      );
    }
  }

  void _deleteCheckItem(bool check, itemData, item) {
    if (check) {
      var map = {
        "type": item['type'],
        "promId": itemData['promId'],
        "addBuy": false,
        "skuId": item['skuId'],
        "extId": item['extId']
      };
      setState(() {
        checkList.add(map);
      });
    } else {
      if (checkList.length > 0) {
        for (int i = 0; i < checkList.length; i++) {
          if (checkList[i]['skuId'] == item['skuId']) {
            setState(() {
              checkList.removeAt(i);
            });
          }
        }
      }
    }
    print(checkList);
  }

  Widget _buildBuy() {
    if (isEdit) {
      return Container(
        color: Colors.white,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  '已选(${checkList.length})',
                  style: t16black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (checkList.length > 0) {
                  _deleteCart();
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                color: checkList.length > 0 ? redColor : Color(0xFFB4B4B4),
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: double.infinity,
                child: Text(
                  '删除所选',
                  style: t14white,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: InkWell(
                onTap: () {
                  setState(() {
                    // _isCheckedAll = !_isCheckedAll;
                    isChecked = !isChecked;
                    _check();
                  });
                },
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: _isCheckedAll
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
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Text(
                  '已选($_selectedNum)',
                  style: t16black,
                ),
              ),
              onTap: () {
                setState(() {
                  // _isCheckedAll = !_isCheckedAll;
                  isChecked = !isChecked;
                  _check();
                });
              },
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        '合计：¥${_getPrice()}',
                        style: t16red,
                      ),
                    ),
                    _promotionPrice == 0
                        ? Container()
                        : Container(
                            child: Text(
                              '已优惠：¥$_promotionPrice',
                              style: t14grey,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.center,
              color: _getPrice() > 0 ? redColor : Color(0xFFB4B4B4),
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: double.infinity,
              child: Text(
                '下单',
                style: t14white,
              ),
            )
          ],
        ),
      );
    }
  }

  void _deleteCart() async {
    Map<String, dynamic> item = {
      "skuList": checkList,
    };
    Map<String, dynamic> params = {
      'selectedSku': json.encode(item),
      "csrf_token": csrf_token,
    };

    Map<String, dynamic> header = {
      "Cookie": cookie,
      "csrf_token": csrf_token,
    };

    print(params);
    var responseData = await deleteCart(params, header: header);
  }
}
