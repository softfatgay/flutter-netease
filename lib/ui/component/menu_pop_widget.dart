import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/ui/component/model/searchParamModel.dart';
import 'package:flutter_app/ui/component/price_pop_widget.dart';
import 'package:flutter_app/ui/component/type_pop_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/search_nav_bar.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';

typedef void MenuChange(SearchParamModel? searchParamModel);

class MenuPopWidget extends StatefulWidget {
  final MenuChange? menuChange;
  final SearchParamModel? searchParamModel;
  final List<CategoryL1Item?> categorytList;
  final double menuHeight;

  const MenuPopWidget(
      {Key? key,
      required this.categorytList,
      this.menuChange,
      this.searchParamModel,
      this.menuHeight = 35})
      : super(key: key);

  @override
  _MenuPopWidgetState createState() => _MenuPopWidgetState();
}

class _MenuPopWidgetState extends State<MenuPopWidget> {
  final _lowPriceController = TextEditingController();
  final _upPriceController = TextEditingController();

  num _popType = 0;

  num _descSorted = -1;

  var _searchModel = SearchParamModel();

  num _categoryIndex = 0;

  bool _showPopMenu = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _searchModel.source = 3;
      if (widget.searchParamModel != null) {
        _searchModel = widget.searchParamModel ?? SearchParamModel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: widget.menuHeight,
              child: SearchNavBar(
                height: widget.menuHeight,
                index: _popType as int?,
                pressIndex: (pressIndex) {
                  setState(() {
                    if (_popType == pressIndex) {
                      if (pressIndex != 0) {
                        _showPopMenu = !_showPopMenu;
                      }
                    } else {
                      _showPopMenu = true;
                      if (pressIndex == 0) {
                        _resetPrice();
                        _resetPage();
                      }
                    }
                    _popType = pressIndex;
                  });
                },
                descSorted: _searchModel.descSorted,
              ),
            ),
          ),
          if (_showPopMenu)
            Positioned(
              top: widget.menuHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    color: backWhite,
                    child: _popChild(),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        color: Color(0X4D000000),
                      ),
                      onTap: () {
                        _closeMenuPop();
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  _popChild() {
    if (_popType == 0) {
      return null;
    } else if (_popType == 1) {
      return PricePopWidget(
        confirmClick: setPriceSort,
        lowPriceController: _lowPriceController,
        upPriceController: _upPriceController,
        cancelClick: () {
          _resetPrice();
        },
        descSorted: _descSorted as int,
        sortClick: (sortType) {
          setState(() {
            if (_descSorted == sortType) {
              _descSorted = -1;
            } else {
              _descSorted = sortType;
            }
          });
        },
      );
    } else if (_popType == 2) {
      return TypePopWidget(
        categoryList: widget.categorytList,
        selectIndex: _categoryIndex as int,
        selectedIndex: (index) {
          setState(() {
            _categoryIndex = index;
            _searchModel.categoryId = widget.categorytList[index]!.id;
          });
          _closeMenuPop();
          _resetPage();
        },
      );
    }
    return Container();
  }

  ///价格点击确定
  void setPriceSort() {
    _closeMenuPop();
    if (_descSorted == -1) {
      _searchModel.descSorted = null;
    } else if (_descSorted == 0) {
      _searchModel.descSorted = false;
    } else if (_descSorted == 1) {
      _searchModel.descSorted = true;
    } else {
      _searchModel.descSorted = null;
    }

    if (_lowPriceController.text.isNotEmpty) {
      _searchModel.floorPrice = num.parse(_lowPriceController.text);
    } else {
      _searchModel.floorPrice = -1;
    }
    if (_upPriceController.text.isNotEmpty) {
      _searchModel.upperPrice = num.parse(_upPriceController.text);
    } else {
      _searchModel.upperPrice = -1;
    }

    _resetPage();
  }

  void _closeMenuPop() {
    setState(() {
      _showPopMenu = false;
    });
  }

  ///价格点击取消
  void _resetPrice() {
    setState(() {
      _descSorted = -1;
      _lowPriceController.text = '';
      _upPriceController.text = '';
      _searchModel.descSorted = null;
      _searchModel.floorPrice = -1;
      _searchModel.upperPrice = -1;
      _searchModel.categoryId = 0;
    });
    _closeMenuPop();
  }

  void _resetPage() {
    if (widget.menuChange != null) {
      widget.menuChange!(_searchModel);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _lowPriceController.dispose();
    _upPriceController.dispose();
    super.dispose();
  }
}
