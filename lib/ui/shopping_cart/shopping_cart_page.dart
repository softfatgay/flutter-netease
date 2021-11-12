import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/component/service_tag_widget.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/component/webview_login_page.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopping_cart/components/add_good_size_widget.dart';
import 'package:flutter_app/ui/shopping_cart/components/cart_item_widget.dart';
import 'package:flutter_app/ui/shopping_cart/components/cart_navbar_widget.dart';
import 'package:flutter_app/ui/shopping_cart/components/empty_cart_widget.dart';
import 'package:flutter_app/ui/shopping_cart/components/shopping_buy_button.dart';
import 'package:flutter_app/ui/shopping_cart/model/carItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/cartItemListItem.dart';
import 'package:flutter_app/ui/shopping_cart/model/shoppingCartModel.dart';
import 'package:flutter_app/utils/eventbus_constans.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';
import 'package:flutter_app/utils/toast.dart';

import 'model/postageVO.dart';

const double _checkBoxWidth = 40.0;

class ShoppingCartPage extends StatefulWidget {
  final Map? params;

  const ShoppingCartPage({Key? key, this.params}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with AutomaticKeepAliveClientMixin {
  var _data; // 完整数据
  late ShoppingCartModel _shoppingCartModel;

  List<CarItem> _cartGroupList = []; // 有效的购物车组列表
  ///包邮条件
  PostageVO? _postageVO;
  List<CarItem> _invalidCartGroupList = []; // 无效的购物车组列表
  num _price = 0; // 价格
  num _promotionPrice = 0; // 促销价

  bool isChecked = false; // 是否全部勾选选中
  bool _isCheckedAll = false; // 是否全部勾选选中

  bool _loading = false; // 是否正在加载
  int _selectedNum = 0; // 选中商品数量

  bool _isEdit = false; // 是否正在编辑

  bool _isLogin = true;
  List _checkList = [];

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
    HosEventBusUtils.on((dynamic event) {
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
    if (isLogin == null) {
      setState(() {
        _isLogin = false;
      });
    } else {
      setState(() {
        _isLogin = isLogin;
      });
      if (isLogin) {
        _getData();
        Timer(Duration(seconds: 1), () {
          HosEventBusUtils.fire(REFRESH_MINE);
          HosEventBusUtils.fire(REFRESH_CART_NUM);
        });
      }
    }
  }

  // 获取购物车数据
  void _getData() async {
    setState(() {
      _loading = true;
    });
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
      _loading = false;
      _shoppingCartModel = shoppingCartModel;
      _cartGroupList = shoppingCartModel.cartGroupList ?? [];
      _postageVO = shoppingCartModel.postageVO;

      _invalidCartGroupList = shoppingCartModel.invalidCartGroupList ?? [];
      _price = shoppingCartModel.actualPrice ?? 0;
      _promotionPrice = shoppingCartModel.promotionPrice ?? 0;
    });
    if (_cartGroupList.length > 0) {
      _setCheckedNum(_cartGroupList);
    }
  }

  _setCheckedNum(List<CarItem> cartGroupList) {
    ///获取选择的数量
    int selectedNum = 0;

    ///判断是否全选
    bool isCheckedAll = true;
    _cartGroupList.forEach((element) {
      var cartItemList = element.cartItemList!;
      cartItemList.forEach((item) {
        if (item.checked!) {
          selectedNum += item.cnt as int;
        }
        if (_itemCanCheck(item)) {
          if (!item.checked!) {
            isCheckedAll = false;
          }
        }
      });
    });
    setState(() {
      _selectedNum = selectedNum;
      _isCheckedAll = isCheckedAll;
    });
  }

  _itemCanCheck(CartItemListItem item) {
    if ((item.limitPurchaseFlag! && (item.limitPurchaseCount! < item.cnt!)) ||
        item.preemptionStatus == 0 ||
        item.sellVolume! < item.cnt! ||
        item.sellVolume == 0 ||
        item.id == 0 ||
        item.type == 110) {
      return false;
    }
    return true;
  }

  /// 购物车 全选/不选 网络请求
  _checkAllOrNot() async {
    setState(() {
      _loading = true;
    });
    Map<String, dynamic> params = {'isChecked': _isCheckedAll};
    var responseData = await shoppingCartCheck(params);
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  /// 购物车  某个勾选框 选/不选 请求
  _checkOne(CartItemListItem item) async {
    setState(() {
      _loading = true;
    });
    Map<String, dynamic> params = {
      'source': item.source,
      'type': item.type,
      'skuId': item.skuId,
      'isChecked': !item.checked!,
      'extId': item.extId,
    };
    var responseData = await shoppingCartCheckOne(params);
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  /// 购物车  分组选择或不选
  _checkGroup(CarItem itemData) async {
    setState(() {
      _loading = true;
    });
    List skuList = [];
    var carItem = itemData.cartItemList;
    carItem!.forEach((element) {
      Map<String, dynamic> params = {
        'type': element.type,
        'skuId': element.skuId,
        'promId': itemData.promId,
        'gift': false,
        'addBuy': false,
        'extId': element.extId,
        'checked': !itemData.checked!
      };
      skuList.add(params);
    });

    Map<String, dynamic> params = {'skuList': skuList};
    var responseData =
        await batchUpdateCheck({'selectedSku': json.encode(params)});
    setState(() {
      _data = responseData.data;
      setData(_data);
    });
  }

  /// 购物车  商品 选购数量变化 请求
  _checkOneNum(CartItemListItem item, num cnt) async {
    setState(() {
      _loading = true;
    });
    Map<String, dynamic> params = {
      'source': item.source,
      'type': item.type,
      'skuId': item.skuId,
      'cnt': cnt,
      'extId': item.extId,
    };
    var responseData = await shoppingCartCheckNum(params);
    if (responseData.code == '200') {
      setState(() {
        _data = responseData.data;
        setData(_data);
        refreshCartNum();
      });
    } else {
      setState(() {
        _loading = false;
      });
      Toast.show('msg', context);
    }
  }

  /// 获取价格
  _getPrice() {
    return _price;
  }

  /// 编辑状态 删除
  void _deleteCheckItem(CarItem itemData, CartItemListItem item, bool check) {
    if (check) {
      var map = {
        "type": item.type,
        "promId": item.source,
        "addBuy": item.id == 0 ? true : false,
        "skuId": item.skuId,
        "extId": item.extId
      };
      setState(() {
        _checkList.add(map);
      });
    } else {
      if (_checkList.length > 0) {
        for (int i = 0; i < _checkList.length; i++) {
          if (_checkList[i]['skuId'] == item.skuId) {
            setState(() {
              _checkList.removeAt(i);
            });
          }
        }
      }
    }
  }

  // 购物车编辑删除
  void _deleteCart() async {
    Map<String, dynamic> item = {
      "skuList": _checkList,
    };
    Map<String, dynamic> params = {'selectedSku': json.encode(item)};
    var responseData = await deleteCart(params);
    if (responseData.code == "200") {
      setState(() {
        _isEdit = false;
      });
      _data = responseData.data;
      setData(_data);
      refreshCartNum();
    }
  }

  ///清除无效商品
  _showClearInvalidDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                // border: Border.all(color: textGrey, width: 1),
                // borderRadius: BorderRadius.circular(4),
                ),
            child: Text(
              '确定清除无效商品？',
              style: t16black,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: t16grey,
              ),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '确认',
                style: t16red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _clearInvalid();
              },
            ),
          ],
        );
      },
    );
  }

  ///清除无效商品
  _clearInvalid() async {
    List invalidSku = [];
    _invalidCartGroupList.forEach((item) {
      var cartItemList = item.cartItemList!;
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
    Map<String, dynamic> param = {'invalidSku': convert.jsonEncode(map)};
    print(param);
    var response = await clearInvalidItem(param);
    if (response.data != null) {
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
    super.build(context);
    return WillPopScope(
      onWillPop: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }
        return Future.value(false);
      },
      child: _buildShoppingCart(),
    );
  }

  _buildShoppingCart() {
    var argument = widget.params;
    return _isLogin ? _buildBody(argument, context) : _loginPage(context);
  }

  _buildBody(Map<dynamic, dynamic>? argument, BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colors.white,
        centerTitle: false,
        toolbarHeight: 45,
        leadingWidth: 0,
        titleSpacing: 0,
        shadowColor: backColor,
        title: CartNavBarWidget(
          canBack: widget.params != null,
          isEdit: _isEdit,
          editPress: () {
            setState(() {
              _checkList.clear();
              _isEdit = !_isEdit;
              if (_isEdit) {
                // _setEditChecked();
              }
            });
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
          _loading ? _pageLoading() : Container(),
        ],
      ),
    );
  }

  /// 点击编辑的时候,重置所有编辑选择状态
  _setEditChecked() {
    setState(() {
      _cartGroupList.forEach((element) {
        element.editChecked = false;
        var cartItemList = element.cartItemList ?? [];
        cartItemList.forEach((element) {
          element.editChecked = false;
        });
      });
    });
  }

  Container _pageLoading() {
    return Container(
      color: Colors.transparent,
      child: Loading(),
      width: double.infinity,
      height: double.infinity,
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
      bottom: 36,
      top: 0,
      left: 0,
      right: 0,
      child: _cartGroupList.isEmpty
          ? EmptyCartWidget()
          : CustomScrollView(
              slivers: [
                singleSliverWidget(_buildTitle()),
                singleSliverWidget(_dataList()),
                singleSliverWidget(Container(height: 10)),
                singleSliverWidget(_invalidTitle()),
                singleSliverWidget(_invalidList()),
                singleSliverWidget(Container(height: 10)),
              ],
            ),
    );
  }

  _invalidTitle() {
    if (_invalidCartGroupList.isNotEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: lineColor, width: 0.3))),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '失效商品',
                style: t16black,
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: textBlack, width: 0.5),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '清除失效商品',
                  style: t13black,
                ),
              ),
              onTap: () {
                _showClearInvalidDialog();
              },
            )
          ],
        ),
      );
    }
    return Container();
  }

  /// 导航下面，商品上面  标题部分
  _buildTitle() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shoppingCartModel.postageVO!.postageTip == null
              ? ServerTagWidget()
              : GestureDetector(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    color: Color(0xFFFFF6E5),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${_postageVO == null ? '' : _postageVO!.postageTip ?? ''}',
                            style: t14Orange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!_postageVO!.postFree!) arrowRightIcon
                      ],
                    ),
                  ),
                  onTap: () {
                    if (!_postageVO!.postFree!) {
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
      checkOne: (CartItemListItem item) {
        _checkOne(item);
      },
      checkGroup: (CarItem? itemData) {
        _checkGroup(itemData!);
      },
      deleteCheckItem: (CarItem itemData, CartItemListItem item, bool check) {
        _deleteCheckItem(itemData, item, check);
      },
      numChange: (CartItemListItem item, num? cnt) {
        _checkOneNum(item, cnt!);
      },
      goRedeem: (CarItem itemData) {
        Routers.push(Routers.getCarsPage, context,
            {'data': itemData, 'promType': itemData.promType}, (value) {
          _getData();
        });
      },
      skuClick: (CartItemListItem item) {
        _getSkuClickGood(item);
      },
      isEdit: _isEdit,
      dataList: _cartGroupList,
      callBack: () {
        _getData();
      },
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
    if (responseData.code == '200' && responseData.data != null) {
      var goodDetail = GoodDetail.fromJson(responseData.data);
      _buildSizeModel(context, item.skuId, item.extId, item.type, goodDetail);
    }
  }

  ///属性选择底部弹窗
  _buildSizeModel(BuildContext context, num? skuId, String? extId, num? type,
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
    return CartItemWidget(
      controller: _controller,
      checkOne: (CartItemListItem item) {
        _checkOne(item);
      },
      checkGroup: (CarItem? itemData) {
        _checkGroup(itemData!);
      },
      deleteCheckItem: (CarItem itemData, CartItemListItem item, bool check) {
        _deleteCheckItem(itemData, item, check);
      },
      numChange: (CartItemListItem item, num? cnt) {
        _checkOneNum(item, cnt!);
      },
      goRedeem: (CarItem itemData) {
        Routers.push(Routers.getCarsPage, context,
            {'data': itemData, 'promType': itemData.promType}, (value) {
          _getData();
        });
      },
      skuClick: (CartItemListItem item) {
        _getSkuClickGood(item);
      },
      isEdit: _isEdit,
      dataList: _invalidCartGroupList,
      isInvalid: true,
      callBack: () {
        _getData();
      },
    );
  }

  /// 底部 商品勾选状态、价格信息、下单 部分
  _buildBuy() {
    return ShoppingBuyButton(
      price: _price,
      promotionPrice: _promotionPrice,
      checkList: _checkList,
      isCheckedAll: _isCheckedAll,
      isEdit: _isEdit,
      selectedNum: _selectedNum,
      checkAll: (bool) {
        setState(() {
          _isCheckedAll = !_isCheckedAll;
          _checkAllOrNot();
        });
      },
      editDelete: () {
        ///删除所选
        _deleteCart();
      },
    );
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
          if (cartItemListItem.checked!) {
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
              if (addBuyItemListItem.checked!) {
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
