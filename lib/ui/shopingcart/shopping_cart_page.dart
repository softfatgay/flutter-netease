import 'dart:async';
import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/cookieConfig.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopingcart/components/add_good_size_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/cart_item_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/cart_navbar_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/empty_cart_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/invalid_cart_item_widget.dart';
import 'package:flutter_app/ui/shopingcart/model/carItem.dart';
import 'package:flutter_app/ui/shopingcart/model/cartItemListItem.dart';
import 'package:flutter_app/ui/shopingcart/model/shoppingCartModel.dart';
import 'package:flutter_app/utils/eventbus_constans.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/global.dart';
import 'package:flutter_app/widget/service_tag_widget.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/webview_login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/postageVO.dart';

class ShoppingCartPage extends StatefulWidget {
  final Map argument;

  const ShoppingCartPage({Key key, this.argument}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with AutomaticKeepAliveClientMixin {
  var _data; // 完整数据
  ShoppingCartModel _shoppingCartModel;

  List<CarItem> _cartGroupList = []; // 有效的购物车组列表
  ///包邮条件
  PostageVO _postageVO;
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

  final _controller = TextEditingController();

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
      if (event == REFRESH_CART) {
        _checkLogin();
      }
    });
    _checkLogin();
  }

  ///检查是否登录
  _checkLogin() async {
    var responseData = await checkLogin();
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
        HosEventBusUtils.fire(REFRESH_MINE);
      });
    }
  }

  // 获取购物车数据
  void _getData() async {
    var responseData = await shoppingCart();
    if (responseData.code == '200') {
      setState(() {
        _data = responseData.data;
        if (_data != null) {
          setData(_data);
        }
      });
    }
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
      _postageVO = shoppingCartModel.postageVO;

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
    Map<String, dynamic> params = {'isChecked': isChecked};
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
      refreshCartNum();
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
        "promId": item.source,
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
  }

  // 购物车编辑删除
  void _deleteCart() async {
    Map<String, dynamic> item = {
      "skuList": checkList,
    };
    Map<String, dynamic> params = {'selectedSku': json.encode(item)};
    var responseData = await deleteCart(params);
    if (responseData.code == "200") {
      setState(() {
        isEdit = false;
      });
      _data = responseData.data;
      setData(_data);
      refreshCartNum();
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
    var response = await clearInvalidItem(param);
    if (response.code == 200) {
      _getData();
      refreshCartNum();
    }
  }

  /// 更新购物车数量
  void refreshCartNum() {
    HosEventBusUtils.fire(REFRESH_CART_NUM);
  }

  @override
  Widget build(BuildContext context) {
    var argument = widget.argument;
    return _isLogin ? _buildBody(argument, context) : _loginPage(context);
  }

  _buildBody(Map<dynamic, dynamic> argument, BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: CartNavBarWidget(
          isEdit: isEdit,
          editPress: () {
            setState(() {
              checkList.clear();
              isEdit = !isEdit;
            });
          },
        ),
        leading: argument == null
            ? Container()
            : GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    'assets/images/back.png',
                  ),
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
    );
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
                  singleSliverWidget(Container(height: 10)),
                  singleSliverWidget(_invalidList()),
                  singleSliverWidget(Container(height: 10)),
                ],
              ),
            ),
      bottom: 40,
      top: 0,
      left: 0,
      right: 0,
    );
  }

  /// 导航下面，商品上面  标题部分
  _buildTitle() {
    return _topItem == null
        ? Container()
        : Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shoppingCartModel.postageVO.postageTip == null
                    ? ServiceTagWidget()
                    : GestureDetector(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          color: Color(0xFFFFF6E5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${_postageVO == null ? '' : _postageVO.postageTip}',
                                  style: t14Orange,
                                ),
                              ),
                              _postageVO.postFree ? Container() : arrowRightIcon
                            ],
                          ),
                        ),
                        onTap: () {
                          if (!_postageVO.postFree) {
                            Routers.push(Routers.cartItemPoolPage, context, {},
                                (value) {
                              _getData();
                            });
                          }
                        },
                      ),
              ],
            ),
          );
  }

  /// 有效商品列表
  _dataList() {
    return CartItemWidget(
      controller: _controller,
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
        Routers.push(Routers.getCarsPage, context, {'data': itemData}, (value) {
          _getData();
        });
      },
      skuClick: (CartItemListItem item) {
        _getSkuClickGood(item);
      },
      isEdit: isEdit,
      itemList: _itemList,
    );
  }

  _getSkuClickGood(CartItemListItem item) async {
    Map<String, dynamic> params = {
      'id': item.itemId,
      'extId': item.extId,
      'type': item.type,
      'promotionId': item.source,
      'skuId': item.skuId,
    };
    var responseData = await detailForCart(params);
    if (responseData.code == '200') {
      var goodDetail = GoodDetail.fromJson(responseData.data);
      _buildSizeModel(context, item.skuId, item.extId, item.type, goodDetail);
    }
  }

  ///属性选择底部弹窗
  _buildSizeModel(BuildContext context, num skuId, String extId, num type,
      GoodDetail item) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AddGoodSizeWidget(
          goodDetail: item,
          skuId: skuId,
          extId: extId,
          type: type,
          updateSkuSuccess: () {
            _getData();
          },
        );
      },
    );
  }

  // 无效商品列表
  _invalidList() {
    return InvalidCartItemWidget(
      invalidCartGroupList: _invalidCartGroupList,
      clearInvalida: () {
        _clearInvalid();
      },
    );
  }

  /// 底部 商品勾选状态、价格信息、下单 部分
  _buildBuy() {
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
                // _goPay();
                // Routers.push(Routers.webView, context,
                //     {'url': 'https://m.you.163.com/order/confirm'});
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
    _controller.dispose();
    super.dispose();
  }

  void _goPay() async {
    var responseData = await checkLogin();
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
    Map<String, dynamic> postParams = {'orderCart': orderCart};
    // var response = await checkBeforeInit(postParams);
    // Routers.push(Routers.orderInit, context, {'data': orderCart});
  }
}
