import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/goods_detail/model/skuListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';
import 'package:flutter_app/ui/goods_detail/model/skuSpecListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/skuSpecValue.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/component/button_widget.dart';
import 'package:flutter_app/component/count.dart';
import 'package:flutter_app/component/dashed_decoration.dart';

typedef void ConfigClick(SkuMapValue value);
typedef void CancelClick();
typedef void UpdateSkuSuccess();
typedef void AddCarSuccess();

class AddGoodSizeWidget extends StatefulWidget {
  final GoodDetail goodDetail;
  final ConfigClick configClick;
  final CancelClick cancelClick;
  final UpdateSkuSuccess updateSkuSuccess;
  final AddCarSuccess addCarSuccess;
  final num skuId;
  final String extId;
  final num type;

  const AddGoodSizeWidget({
    Key key,
    this.goodDetail,
    this.configClick,
    this.cancelClick,
    this.skuId,
    this.extId,
    this.updateSkuSuccess,
    this.addCarSuccess,
    this.type,
  }) : super(key: key);

  @override
  _AddGoodSizeWidgetState createState() => _AddGoodSizeWidgetState();
}

class _AddGoodSizeWidgetState extends State<AddGoodSizeWidget> {
  ///红色选中边框
  var redBorder = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(3)),
    border: Border.all(width: 0.5, color: redColor),
  );

  ///黑色边框
  var blackBorder = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      border: Border.all(width: 0.5, color: textBlack));

  ///虚线边框
  var blackDashBorder = DashedDecoration(
    gap: 2,
    dashedColor: textLightGrey,
    borderRadius: BorderRadius.all(Radius.circular(3)),
  );

  ///skuMap key键值
  var _selectSkuMapKey = [];

  ///skuMap 描述信息
  var _selectSkuMapDec = [];
  var _selectStrDec = '';

  ///商品价格（真实价格）
  String _price = '';

  ///商品价格（原始价格）
  String _counterPrice = '';

  ///商品数量
  int _goodCount = 1;

  GoodDetail goodDetail;

  List<SpecListItem> _specList;
  num _skuId;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      goodDetail = widget.goodDetail;
      var skuSpecList = goodDetail.skuSpecList;
      _selectSkuMapKey = List.filled(skuSpecList.length, '');
      _selectSkuMapDec = List.filled(skuSpecList.length, '');

      var skuId = widget.skuId;
      if (skuId != null) {
        _skuId = skuId;
        _setSelectSkuMapKey(_skuId);
      }
    });
    super.initState();
  }

  void _setSelectSkuMapKey(num skuId) {
    var skuList = goodDetail.skuList;
    SkuListItem skuListItem;
    for (var value in skuList) {
      if (value.id == skuId) {
        skuListItem = value;
        break;
      }
    }
    if (skuListItem != null) {
      var itemSkuSpecValueList = skuListItem.itemSkuSpecValueList;
      setState(() {
        for (int i = 0; i < _selectSkuMapKey.length; i++) {
          _selectSkuMapDec[i] = itemSkuSpecValueList[i].skuSpecValue.value;
          _selectSkuMapKey[i] =
              itemSkuSpecValueList[i].skuSpecValue.id.toString();
        }
      });
      setState(() {
        _getSkumapItem();
        _setSkuMapDec();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StatefulBuilder(builder: (context, setstate) {
        return Container(
          constraints: BoxConstraints(maxHeight: 800),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(5.0),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //最小包裹高度
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        children: [
                          ///商品描述
                          _selectGoodDetail(context, widget.goodDetail),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15, right: 5),
                                child: Image.asset(
                                  'assets/images/close.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      ///颜色，规格等参数
                      _modelAndSize(context, widget.goodDetail, setstate),
                      //数量
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          '数量',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 25),
                        child: Count(
                          number: _goodCount,
                          min: 1,
                          max: _skuMapItem == null ? 1 : _skuMapItem.sellVolume,
                          onChange: (index) {
                            setstate(() {
                              _goodCount = index;
                            });
                            setState(() {
                              _goodCount = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _defaultBottomBtns(0),
              ),
            ],
          ),
        );
      }),
    );
  }

  ///默认展示形式
  _defaultBottomBtns(int type) {
    return GestureDetector(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        color: backRed,
        child: Text(
          '确定',
          style: t14white,
        ),
      ),
      onTap: () {
        _addCart();
      },
    );
  }

  ///选择的规格
  SkuMapValue _skuMapItem;

  _selectGoodDetail(BuildContext context, GoodDetail goodDetail) {
    String img = (_skuMapItem == null || _skuMapItem.pic == null)
        ? goodDetail.primaryPicUrl
        : _skuMapItem.pic;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            child: Container(
              child: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
              ),
              height: 100,
              width: 100,
            ),
            onTap: () {
              Routers.push(Routers.image, context, {
                'images': [img]
              });
            },
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _skuMapItem == null ||
                        _skuMapItem.promotionDesc == null ||
                        _skuMapItem.promotionDesc == ''
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xFFEF7C15)),
                        child: Text(
                          '${_skuMapItem.promotionDesc ?? ''}',
                          style: t12white,
                        ),
                      ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "价格：",
                        style: t14red,
                      ),
                      Text(
                        '￥$_price',
                        overflow: TextOverflow.ellipsis,
                        style: t14red,
                      ),
                      _price == _counterPrice
                          ? Container()
                          : Container(
                              child: Text(
                                '￥$_counterPrice',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textGrey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                // 商品描述
                Container(
                  child: Text(
                    '已选择：$_selectStrDec',
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: textBlack, fontSize: 14),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _modelAndSize(BuildContext context, GoodDetail goodDetail, setstate) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          SkuSpecListItem skuSpecItem = goodDetail.skuSpecList[index];
          List<SkuSpecValue> skuSpecItemNameList = skuSpecItem.skuSpecValueList;
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(skuSpecItem.name),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Wrap(
                    ///商品属性
                    spacing: 5,
                    runSpacing: 10,
                    children: _skuSpecItemNameList(context, setstate,
                        goodDetail, skuSpecItemNameList, index),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: goodDetail.skuSpecList.length,
      ),
    );
  }

  _skuSpecItemNameList(BuildContext context, setstate, GoodDetail goodDetail,
      List<SkuSpecValue> skuSpecItemNameList, int index) {
    return skuSpecItemNameList.map((item) {
      var isModelSizeValue = _isModelSizeValue(goodDetail, index, item);
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.5),
          padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
          decoration: isModelSizeValue[0],
          child: Text(
            '${item.value}',
            style: isModelSizeValue[1],
            textAlign: TextAlign.center,
          ),
        ),
        onTap: () {
          print(item.value);

          ///弹窗内
          setState(() {
            _selectModelDialogSize(context, index, item);
          });
        },
      );
    }).toList();
  }

  ///选择属性，查询skuMap
  void _selectModelDialogSize(
      BuildContext context, int index, SkuSpecValue item) {
    if (_selectSkuMapKey[index] == item.id.toString()) {
      _selectSkuMapKey[index] = '';
      _selectSkuMapDec[index] = '';
    } else {
      _selectSkuMapKey[index] = item.id.toString();
      _selectSkuMapDec[index] = item.value;
    }

    ///被选择的skuMap
    String skuMapKey = '';
    _selectSkuMapKey.forEach((element) {
      skuMapKey += ';$element';
    });

    skuMapKey = skuMapKey.replaceFirst(';', '');
    SkuMapValue skuMapItem = goodDetail.skuMap['$skuMapKey'];

    ///描述信息
    String selectStrDec = '';
    _selectSkuMapDec.forEach((element) {
      selectStrDec += '$element ';
    });
    _selectStrDec = selectStrDec;
    _skuMapItem = skuMapItem;
    // _setSkuMapDec();
    _getSkumapItem();
  }

  void _setSkuMapDec() {
    String selectStrDec = '';
    _selectSkuMapDec.forEach((element) {
      selectStrDec += '$element ';
    });
    _selectStrDec = selectStrDec;
  }

  void _getSkumapItem() {
    if (_skuMapItem == null) {
      ///顺序不同，导致选择失败
      var keys = goodDetail.skuMap.keys;
      for (var element in keys) {
        var split = element.split(';');
        bool isMatch = false;
        for (var spitElement in split) {
          if (_selectSkuMapKey.indexOf(spitElement) == -1) {
            isMatch = false;
            break;
          } else {
            isMatch = true;
          }
        }
        if (isMatch) {
          _skuMapItem = goodDetail.skuMap['$element'];
          break;
        }
      }
    }

    if (_skuMapItem != null) {
      _price = _skuMapItem.retailPrice.toString();
      _counterPrice = _skuMapItem.counterPrice.toString();
    }
  }

  _isModelSizeValue(GoodDetail goodDetail, int index, SkuSpecValue item) {
    List value = [blackBorder, t12black];

    if (_selectSkuMapKey.contains(item.id.toString())) {
      value[0] = redBorder;
      value[1] = t12red;
      return value;
    } else {
      bool isEmpty = true;
      for (var value in _selectSkuMapKey) {
        if (value != '') {
          isEmpty = false;
          break;
        }
      }

      if (_selectSkuMapKey.length > 1 && isEmpty) {
        value[0] = blackBorder;
        value[1] = t12black;
        return value;
      }

      bool isAllselect = true;
      for (var value in _selectSkuMapKey) {
        if (value == '') {
          isAllselect = false;
          break;
        }
      }

      if (isAllselect) {
        return _allSelect(value, index, item);
      } else {
        if (_selectSkuMapKey.length == 2) {
          if (_selectSkuMapKey[index] != '') {
            value[0] = blackBorder;
            value[1] = t12black;
            return value;
          } else {
            return _allSelect(value, index, item);
          }
        } else {
          return _allSelect(value, index, item);
        }
      }
    }
  }

  _allSelect(List value, int index, SkuSpecValue item) {
    value[0] = _modelSizeDe(index, item);
    value[1] = _modelSizeTextSty(index, item);
    return value;
  }

  _modelSizeDe(int index, SkuSpecValue item) {
    if (_modelSizeValue(index, item)) {
      return blackBorder;
    } else {
      return blackDashBorder;
    }
  }

  _modelSizeTextSty(int index, SkuSpecValue item) {
    if (_modelSizeValue(index, item)) {
      return t12black;
    } else {
      return t12lightGrey;
    }
  }

  _modelSizeValue(int index, SkuSpecValue item) {
    var selectSkuMapKey = List.filled(_selectSkuMapKey.length, '');
    for (var i = 0; i < _selectSkuMapKey.length; i++) {
      selectSkuMapKey[i] = _selectSkuMapKey[i];
    }
    selectSkuMapKey[index] = item.id.toString();
    var keys = goodDetail.skuMap.keys;
    bool isMatch = false;

    var isValue = false;
    for (var element in keys) {
      var split = element.split(';');
      print(split);
      for (var spitElement in selectSkuMapKey) {
        if (spitElement == null || spitElement == '') {
          isMatch = true;
        } else {
          if (split.indexOf(spitElement) == -1) {
            isMatch = false;
            break;
          } else {
            isMatch = true;
          }
        }
      }
      if (isMatch) {
        SkuMapValue skuMapItem = goodDetail.skuMap['$element'];
        if (skuMapItem.sellVolume != 0) {
          isValue = true;
          break;
        } else {
          isValue = false;
          break;
        }
      } else {
        isValue = false;
      }
    }
    return isValue;
  }

  void _addCart() {
    _selectSkuMapKey.forEach((element) {
      if (element == '') {
        var indexOf = _selectSkuMapKey.indexOf(element);
        var name = goodDetail.skuSpecList[indexOf].name;
        Toast.show('请选择$name', context);
        return;
      }
    });
    if (_skuMapItem.sellVolume > 0) {
      _addShoppingCart();
    }
  }

  ///加入购物车
  void _addShoppingCart() async {
    if (_skuId != null) {
      Map<String, dynamic> params = {
        "count": _goodCount,
        "newSkuId": _skuMapItem.id,
        "oldSkuId": _skuId,
        "promId": _skuMapItem.promId,
        'extId': widget.extId,
        'type': widget.type
      };
      var responseData = await updateSkuSpec(params);
      if (responseData.code == '200') {
        if (widget.updateSkuSuccess != null) {
          widget.updateSkuSuccess();
        }
        Navigator.pop(context);
      }
    } else {
      Map<String, dynamic> params = {
        "cnt": _goodCount,
        "skuId": _skuMapItem.id
      };
      await addCart(params).then((value) {
        Toast.show('添加成功', context);
        if (widget.addCarSuccess != null) {
          widget.addCarSuccess();
        }
      });
    }
  }
}
