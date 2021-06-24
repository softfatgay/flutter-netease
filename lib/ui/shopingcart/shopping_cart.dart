import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/shopingcart/cart_item_widget.dart';
import 'package:flutter_app/ui/shopingcart/empty_cart_widget.dart';
import 'package:flutter_app/ui/shopingcart/invalid_cart_item_widget.dart';
import 'package:flutter_app/ui/shopingcart/model/carItem.dart';
import 'package:flutter_app/ui/shopingcart/model/cartItemListItem.dart';
import 'package:flutter_app/ui/shopingcart/model/shoppingCartModel.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/service_tag_widget.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/webview_login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShoppingCart extends StatefulWidget {
  final Map argument;

  const ShoppingCart({Key key, this.argument}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart>
    with AutomaticKeepAliveClientMixin {
  var _data; // 完整数据
  ShoppingCartModel _shoppingCartModel;

  List<CarItem> _cartGroupList = []; // 有效的购物车组列表
  CarItem _topItem; // 顶部商品数据
  List<CarItem> _itemList = []; // 显示的商品数据
  List<CarItem> _invalidCartGroupList = []; // 无效的购物车组列表
  double _price = 0; // 价格
  double _promotionPrice = 0; // 促销价
  double _actualPrice = 0; // 实际价格

  bool isChecked = false; // 是否全部勾选选中
  bool _isCheckedAll = false; // 是否全部勾选选中

  bool loading = false; // 是否正在加载
  int _selectedNum = 0; // 选中商品数量

  bool isEdit = false; // 是否正在编辑

  bool _isLogin = true;
  int allCount = 0;
  List checkList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  /*
  *   初始化
  * */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HosEventBusUtils.on((event) {
      if (event == 'refresh') {
        print("ShoppingCart-----------------");
        _checkLogin();
      }
    });
    _checkLogin();
  }

  ///检查是否登录
  _checkLogin() async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    };
    var responseData = await checkLogin(params);
    var isLogin = responseData.data;
    setState(() {
      if (isLogin != null) {
        _isLogin = isLogin;
      } else {
        _isLogin = false;
      }
    });
    if (isLogin) {
      _getData();
      Timer(Duration(seconds: 1), () {
        HosEventBusUtils.fire('mine_refresh');
      });
    }
  }

  /*
  *   数据逻辑
  * */

  // 获取购物车数据
  void _getData() async {
    Map<String, dynamic> params = {"csrf_token": csrf_token}; // 参数
    var responseData = await shoppingCart(params);
    setState(() {
      _data = responseData.data;
      if (_data != null) {
        setData(_data);
      }
    });
  }

  // 更新状态机 刷新界面
  void setData(var _data) {
    if (_data == null) {
      _getData();
    }

    var shoppingCartModel = ShoppingCartModel.fromJson(_data);
    setState(() {
      loading = false;
      _shoppingCartModel = shoppingCartModel;
      _cartGroupList = shoppingCartModel.cartGroupList;

      _invalidCartGroupList = shoppingCartModel.invalidCartGroupList;
      _price = double.parse(shoppingCartModel.actualPrice.toString());
      _promotionPrice =
          double.parse(shoppingCartModel.promotionPrice.toString());
      _actualPrice = double.parse(shoppingCartModel.actualPrice.toString());

      if (_cartGroupList.length > 0) {
        _topItem = _cartGroupList[0];
        if (_cartGroupList.length > 1) {
          _itemList = _cartGroupList;
          // _itemList.removeAt(0);
          _selectedNum = 0;

          ///获取选择的数量
          _itemList.forEach((element) {
            var cartItemList = element.cartItemList;
            cartItemList.forEach((item) {
              if (item.checked) {
                _selectedNum += item.cnt;
              }
            });
          });

          ///判断是否全选
          _itemList.forEach((element) {
            var cartItemList = element.cartItemList;
            cartItemList.forEach((item) {
              _isCheckedAll = true;
              if (!item.checked) {
                _isCheckedAll = false;
                return;
              }
            });
          });
        }
      }
    });
  }

  /// 购物车 全选/不选 网络请求
  _check() async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      'isChecked': isChecked
    };
    var responseData = await shoppingCartCheck(params);
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  /// 购物车  某个勾选框 选/不选 请求
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
    var responseData = await shoppingCartCheckOne(params);
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  /// 购物车  商品 选购数量变化 请求
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
    var responseData = await shoppingCartCheckNum(params);
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  /// 获取价格
  _getPrice() {
    return _price;
  }

  /// 编辑状态 删除
  void _deleteCheckItem(bool check, CarItem itemData, CartItemListItem item) {
    if (check) {
      var map = {
        "type": item.type,
        "promId": itemData.promId,
        "addBuy": item.id == 0 ? true : false,
        "skuId": item.skuId,
        "extId": item.extId
      };
      setState(() {
        checkList.add(map);
      });
    } else {
      if (checkList.length > 0) {
        for (int i = 0; i < checkList.length; i++) {
          if (checkList[i]['skuId'] == item.skuId) {
            setState(() {
              checkList.removeAt(i);
            });
          }
        }
      }
    }
    print(checkList);
  }

  // 清空购物车
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
    var responseData = await deleteCart(params);
    if (responseData.code == "200") {
      setState(() {
        isEdit = false;
      });
      _data = responseData.data;
      setData(_data);
    }
  }

  ///清除无效商品
  _clearInvalid() async {
    List invalidSku = [];
    _invalidCartGroupList.forEach((item) {
      var cartItemList = item.cartItemList;
      cartItemList.forEach((element) {
        var map = {
          "type": element.type,
          "promId": item.promId,
          "skuId": element.skuId,
          "gift": false
        };
        invalidSku.add(map);
      });
    });

    var map = {
      'skuList': invalidSku,
    };

    Map<String, dynamic> param = {'invalidSku': map};
    Map<String, dynamic> header = {
      "Cookie": cookie,
      "csrf_token": csrf_token,
    };
    var response = await clearInvalidItem(param);
    if (response.code == 200) {
      _getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var argument = widget.argument;
    return _isLogin
        ? Scaffold(
            backgroundColor: backColor,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              centerTitle: true,
              title: _navBar(),
              leading: argument == null
                  ? Container()
                  : GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: textBlack,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
            ),
            body: Stack(
              children: [
                _data == null ? Loading() : _buildData(context),
                Positioned(
                  child: _buildBuy(),
                  bottom: 0,
                  left: 0,
                  right: 0,
                ),
                loading ? Loading() : Container(),
              ],
            ),
          )
        : _loginPage(context);
  }

  _loginPage(BuildContext context) {
    return WebLoginWidget(
      onValueChanged: (value) {
        if (value) {
          setState(() {
            _isLogin = value;
          });
          _checkLogin();
        }
      },
    );
  }

  _buildData(BuildContext context) {
    return Positioned(
      child: (_data == null ||
              _cartGroupList.isEmpty ||
              _cartGroupList.length == 0)
          ? EmptyCartWidget()
          : MediaQuery.removePadding(
              removeTop: true,
              removeBottom: true,
              context: context,
              child: CustomScrollView(
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
      top: 0,
      //MediaQuery.of(context).padding.top + 46,
      left: 0,
      right: 0,
    );
  }

  ///  导航头
  Widget _navBar() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border(bottom: BorderSide(color: backColor,width: 1))
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                '购物车',
                style: t16black,
              ),
            ),
          ),
          isEdit
              ? Container()
              : GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: redLightColor,
                    ),
                    child: Text(
                      '领券',
                      style: t14white,
                    ),
                  ),
                  onTap: () {
                    Routers.push(Routers.webViewPageAPP, context,
                        {'url': 'https://m.you.163.com/coupon/cartCoupon'});
                  },
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
              style: t14black,
            ),
          )
        ],
      ),
    );
  }

  /// 导航下面，商品上面  标题部分
  Widget _buildTitle() {
    return _topItem == null
        ? Container()
        : Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shoppingCartModel.postageVO.postageTip == null
                    ? ServiceTagWidget()
                    : Container(
                        alignment: Alignment.centerLeft,
                        color: textLightYellow,
                        padding: EdgeInsets.only(left: 15),
                        height: ScreenUtil().setHeight(40),
                        child: Text(
                          '${_data['postageVO']['postageTip']}',
                          style: t14red,
                        ),
                      ),
                SizedBox(
                  height: 6,
                )
              ],
            ),
          );
  }

  /// 有效商品列表
  Widget _dataList() {
    return CartItemWidget(
      checkOne: (CarItem itemData, num source, num type, num skuId, bool check,
          String extId) {
        _checkOne(source, type, skuId, check, extId);
      },
      deleteCheckItem: (bool check, CarItem itemData, CartItemListItem item) {
        _deleteCheckItem(check, itemData, item);
      },
      numChange: (num source, num type, num skuId, num cnt, String extId) {
        _checkOneNum(source, type, skuId, cnt, extId);
      },
      goRedeem: (CarItem itemData) {
        Routers.push(Routers.getCarsPage, context, {'data': itemData}, () {
          _getData();
        });
      },
      isEdit: isEdit,
      itemList: _itemList,
    );
  }

  // 无效商品列表
  Widget _invalidList() {
    return InvalidCartItemWidget(
      invalidCartGroupList: _invalidCartGroupList,
      clearInvalida: () {
        _clearInvalid();
      },
    );
  }

  /// 底部 商品勾选状态、价格信息、下单 部分
  Widget _buildBuy() {
    ///编辑状态
    if (isEdit) {
      return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  '已选(${checkList.length})',
                  style: t14grey,
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
      ///正常状态
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
                  style: t14grey,
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
                        style: TextStyle(
                            color: textRed, fontSize: 14, height: 1.1),
                      ),
                    ),
                    _promotionPrice == 0
                        ? Container()
                        : Container(
                            child: Text(
                              '已优惠：¥$_promotionPrice',
                              style: TextStyle(
                                  color: textGrey, fontSize: 12, height: 1.1),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                color: _getPrice() > 0 ? redColor : Color(0xFFB4B4B4),
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: double.infinity,
                child: Text(
                  '下单',
                  style: t14white,
                ),
              ),
              onTap: () {
                Toast.show('暂未开发', context);
                _goPay();
                // Routers.push(Util.webView, context,{'id':'https://m.you.163.com/order/confirm?sfrom=3995230&_stat_referer=itemDetail_buy'});
              },
            )
          ],
        ),
      );
    }
  }

  // 分割线
  Widget line = Container(
    height: 10,
    color: Color(0xFFEAEAEA),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    HosEventBusUtils.off();
    super.dispose();
  }

  void _goPay() async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    };
    var responseData = await checkLogin(params);
    var isLogin = responseData.data;
    if (!isLogin) {
      return;
    }

    ///组装数据
    List cartGroupList = [];

    _cartGroupList.forEach((cartGroupItem) {
      List cartItemListData = [];
      List addBuyItemListData = [];

      Map<String, dynamic> map = {
        'promId': cartGroupItem.promId,
        'suitCount': cartGroupItem.suitCount,
        'promSatisfy': cartGroupItem.promSatisfy,
        'giftItemList': []
      };

      ///购物车列表
      var cartItemList = cartGroupItem.cartItemList;
      if (cartItemList != null && cartItemList.isNotEmpty) {
        cartItemList.forEach((cartItemListItem) {
          if (cartItemListItem.checked) {
            var map = {
              'id':
                  '${cartItemListItem.source}_${cartItemListItem.skuId}_${cartItemListItem.preSellStatus}_${cartItemListItem.status}',
              'uniqueKey': cartItemListItem.uniqueKey,
              'skuId': cartItemListItem.skuId,
              'count': cartItemListItem.cnt,
              'source': cartItemListItem.source,
              'sources': cartItemListItem.sources,
              'isPreSell': cartItemListItem.preSellStatus == 0 ? false : true,
              'extId': cartItemListItem.extId,
              'type': cartItemListItem.type,
              'checkExt': cartItemListItem.checkExt
            };
            cartItemListData.add(map);
          }
        });
      }

      ///换购商品列表
      var addBuyStepList = cartGroupItem.addBuyStepList;
      if (addBuyStepList != null && addBuyStepList.isNotEmpty) {
        addBuyStepList.forEach((addBuyStepListItem) {
          var addBuyItemList = addBuyStepListItem.addBuyItemList;
          if (addBuyItemList != null && addBuyItemList.isNotEmpty) {
            addBuyItemList.forEach((addBuyItemListItem) {
              if (addBuyItemListItem.checked) {
                var map = {
                  'id':
                      '${addBuyItemListItem.source}_${addBuyItemListItem.skuId}_${addBuyItemListItem.preSellStatus}_${addBuyItemListItem.status}',
                  'uniqueKey': addBuyItemListItem.uniqueKey,
                  'skuId': addBuyItemListItem.skuId,
                  'count': addBuyItemListItem.cnt,
                  'source': addBuyItemListItem.source,
                  'sources': addBuyItemListItem.sources,
                  'isPreSell':
                      addBuyItemListItem.preSellStatus == 0 ? false : true,
                  'extId': addBuyItemListItem.extId,
                  'type': addBuyItemListItem.type,
                  'checkExt': addBuyItemListItem.checkExt
                };
                addBuyItemListData.add(map);
              }
            });
          }
        });
      }

      map['cartItemList'] = cartItemListData;
      map['addBuyItemList'] = addBuyItemListData;

      cartGroupList.add(map);
    });

    var orderCart = {'cartGroupList': cartGroupList};
    var postparam = {'orderCart': orderCart};
    var param = {"csrf_token": csrf_token};
    var response = await checkBeforeInit(param, postparam);

    // Routers.push(Util.orderInit, context, {'data': orderCart});
  }
}
