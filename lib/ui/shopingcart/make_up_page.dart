import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/goods_detail/components/search_nav_bar.dart';
import 'package:flutter_app/ui/goods_detail/components/search_price_filed.dart';
import 'package:flutter_app/ui/goods_detail/components/search_sliver_bar.dart';
import 'package:flutter_app/ui/goods_detail/model/searchInitModel.dart';
import 'package:flutter_app/ui/goods_detail/model/searchParamModel.dart';
import 'package:flutter_app/ui/shopingcart/components/pop_menu_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/price_pop_widget.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/ui/sort/model/searchResultModel.dart';
import 'package:flutter_app/utils/local_storage.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/floating_action_button.dart';
import 'package:flutter_app/widget/global.dart';
import 'package:flutter_app/widget/search_widget.dart';
import 'package:flutter_app/widget/sliver_footer.dart';

class MakeUpPage extends StatefulWidget {
  final Map arguments;

  MakeUpPage({this.arguments});

  @override
  _MakeUpPageState createState() => _MakeUpPageState();
}

class _MakeUpPageState extends State<MakeUpPage> {
  TextEditingController _controller;
  final _scrollController = new ScrollController();
  String _textValue = '';

  var _keywordList = [];
  var _hotKeyWordList = [];

  ///分类
  List<CategoryL1ListItem> _categoryL1List;

  ///搜索提示
  var _searchTipsData = [];

  var _serachResult = false;

  //初始化,状态
  var _isFirstLoading = true;
  var _bottomTipsText = '';

  //请求是以这个参数为加载更多
  var _paeSize = 40;
  var _itemId = 0;
  var _keyword = '';
  var _searIndex = 0;

  ///搜索框垂直padding
  final _paddingV = 8.0;

  ///搜索高度
  final _searchHeight = 48.0;

  final _sliverBarheight = 40.0;

  final _lowPriceController = TextEditingController();
  final _upPriceController = TextEditingController();

  var _searchModel = SearchParamModel();

  ///搜索结果
  List<ItemListItem> _directlyList = [];
  var _hasMore = false;

  bool _showPopMenu = false;

  ///降序？
  int _descSorted = -1;

  bool _noData = false;

  final _streamController = StreamController<bool>.broadcast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController.fromValue(TextEditingValue(
        // 设置内容
        text: _textValue,
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: _textValue.length))));

    setState(() {
      _textValue = widget.arguments['id'];
    });
    _getKeyword();
    _searchInit();
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels > 700) {
        _streamController.sink.add(true);
      } else {
        _streamController.sink.add(false);
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasMore) {
          _getTipsResult(false);
        }
      }
    });
  }

  void _searchInit() async {
    var responseData = await searchInit();
    if (responseData.code == '200') {
      var searchInitModel = SearchInitModel.fromJson(responseData.data);
      setState(() {
        _hotKeyWordList = searchInitModel.hotKeywordVOList;
      });
    }
  }

  void _getTipsResult(bool showProgress) async {
    var params = {
      '_stat_search': _searchModel.statSearch,
      'keyword': _searchModel.keyWord,
      'sortType': _searchModel.sortType,
      // 'descSorted': _searchModel.descSorted,
      'categoryId': _searchModel.categoryId,
      'matchType': _searchModel.matchType,
      'floorPrice': _searchModel.floorPrice,
      'upperPrice': _searchModel.upperPrice,
      'size': _paeSize,
      'itemId': _itemId,
      'stillSearch': _searchModel.stillSearch,
      'searchWordSource': _searchModel.searchWordSource,
      'needPopWindow': _searchModel.needPopWindow
    };

    // var params = _searchModel.toJson();
    setState(() {
      if (showProgress) {
        _noData = false;
        _isFirstLoading = true;
      } else {
        _isFirstLoading = false;
      }
    });

    if (_searchModel.descSorted != null) {
      params.addAll({'descSorted': _searchModel.descSorted});
    }
    var responseData = await searchSearch(params, showProgress: showProgress);
    var data = responseData.data;
    if (data == null) {
      setState(() {
        if (_isFirstLoading) {
          _noData = true;
        }
      });
    }
    var searchResultModel = SearchResultModel.fromJson(data);
    setState(() {
      var directlyList = searchResultModel.directlyList;
      var categoryL1List = searchResultModel.categoryL1List;
      if (categoryL1List != null && categoryL1List.isNotEmpty) {
        _categoryL1List = categoryL1List;
      }
      _hasMore = searchResultModel.hasMore;
      if (directlyList == null || directlyList.isEmpty) {
        _bottomTipsText = '没有找到您想要的内容';
        if (_isFirstLoading) {
          _noData = true;
        }
      } else {
        _directlyList.addAll(directlyList);
        if (!_hasMore) {
          _bottomTipsText = '没有更多了';
        }
        _serachResult = true;
      }
    });
  }

  void _getSearchTips() async {
    Map<String, dynamic> params = {'keywordPrefix': _textValue};
    var responseData = await searchTips(params);
    // Util.hideKeyBord(context);
    setState(() {
      _searchTipsData = responseData.data;
      _serachResult = false;
      _hasMore = false;
      if (_searchTipsData.length == 0) {
        _bottomTipsText = '暂时没有您想要的内容';
      } else {
        _bottomTipsText = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SearchNavBar(
                collapsedHeight: 35,
                index: 0,
                pressIndex: (pressIndex) {},
                descSorted: false),
            Positioned(
              top: 35,
              left: 0,
              right: 0,
              child: PopMenuWidet(
                child: PricePopWidget(),
              ),
            )
          ],
        ),
        floatingActionButton: StreamBuilder(
            stream: _streamController.stream,
            initialData: false,
            builder: (context, snapshot) {
              return snapshot.data
                  ? floatingAB(_scrollController)
                  : Container();
            }));
  }

  _showResult() {
    return Container(
      color: backWhite,
      padding: EdgeInsets.only(top: _searchHeight - _paddingV),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          _sliverBar(),
          _serachResult
              ? GoodItemWidget(dataList: _directlyList)
              : _buildSearchTips(),
          SliverFooter(hasMore: _hasMore, tipsText: _bottomTipsText),
        ],
      ),
    );
  }

  _sliverBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SearchSliverBar(
        index: _searIndex,
        descSorted: _searchModel.descSorted,
        pressIndex: (index) {
          setState(() {
            if (_searchModel.descSorted == null) {
              _descSorted = -1;
            } else {
              if (_searchModel.descSorted) {
                _descSorted = 2;
              } else {
                _descSorted = 1;
              }
            }
            if (index == 0) {
              _resetPrice();
              _searIndex = index;
              _getTipsResult(true);
            } else if (index == 1 || index == 2) {
              if (_searIndex != index) {
                _searIndex = index;
                _showPopMenu = true;
              } else {
                _showPopMenu = !_showPopMenu;
              }
            }
          });
        },
        showBack: false,
        collapsedHeight: _sliverBarheight,
        expandedHeight: _sliverBarheight + MediaQuery.of(context).padding.top,
        paddingTop: MediaQuery.of(context).padding.top,
      ),
    );
  }

  void _resetPrice() {
    _descSorted = -1;
    _lowPriceController.text = '';
    _upPriceController.text = '';
    _searchModel.descSorted = null;
    _searchModel.floorPrice = -1;
    _searchModel.upperPrice = -1;
  }

  _buildSearchTips() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        Widget widget = Container(
            margin: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey[200]),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _searchTipsData[index],
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: arrowRightIcon,
                )
              ],
            ));
        return GestureDetector(
          child: widget,
          onTap: () {
            setState(() {
              _searchModel.keyWord = _searchTipsData[index];
              _searchModel.searchWordSource = 7;
              _searchModel.statSearch = 'autoComplete';
              _searchResult();
              _getKeyword();
            });
          },
        );
      }, childCount: _searchTipsData.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 8,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0),
    );
  }

  void _searchResult() {
    _directlyList = [];
    Util.hideKeyBord(context);
    _saveKey(_searchModel.keyWord);
    _controller.text = _searchModel.keyWord;
    _getTipsResult(true);
  }

  ///本地存储keyword
  void _saveKey(String key) async {
    var sp = await LocalStorage.sp;
    var keywordStr = sp.getString(LocalStorage.keyWord);
    if (keywordStr != null) {
      var split = keywordStr.split(';');
      if (split.indexOf(key) == -1) {
        sp.setString(LocalStorage.keyWord, keywordStr + ';$key');
      }
    } else {
      sp.setString(LocalStorage.keyWord, '$key');
    }
  }

  _clearKeyword() async {
    var sp = await LocalStorage.sp;
    sp.remove(LocalStorage.keyWord);
    _getKeyword();
  }

  void _getKeyword() async {
    var sp = await LocalStorage.sp;
    var keyword = sp.getString(LocalStorage.keyWord);
    print('sp-----------$keyword');
    if (keyword != null && keyword != '') {
      var split = keyword.split(';');
      // split.removeAt(0);
      var reversed = split.reversed.toList();
      setState(() {
        _keywordList = reversed;
      });
    } else {
      setState(() {
        _keywordList = [];
      });
    }
  }

  _historyItem(BuildContext context) {
    return _keywordList
        .map((value) => GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: textLightGrey, width: 0.5)),
                child: Text(
                  '$value',
                  style: t12black,
                ),
              ),
              onTap: () {
                setState(() {
                  _searchModel.keyWord = value;
                  _searchModel.searchWordSource = 5;
                  _searchModel.statSearch = 'history';
                  _searchResult();
                });
              },
            ))
        .toList();
  }

  _hotItem(BuildContext context) {
    return _hotKeyWordList
        .map(
          (value) => GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: textLightGrey, width: 0.5)),
              child: Text(
                '${value.keyword}',
                style: t12black,
              ),
            ),
            onTap: () {
              setState(() {
                _searchModel.keyWord = value.keyword;
              });
              _searchResult();
            },
          ),
        )
        .toList();
  }

  _popMenu() {
    if (_searIndex == 1 && _showPopMenu) {
      return Container(
        color: Color(0X4D000000),
        child: Column(
          children: [
            Container(
              color: backWhite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          '筛选',
                          style: t14black,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 30,
                            child: SearchPriceTextFiled(
                              hintText: '最低价',
                              // textStyle: t12black,
                              // borderColor: textGrey,
                              controller: _lowPriceController,
                            ),
                          ),
                        ),
                        Container(
                          width: 20,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: textBlack,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 30,
                            child: SearchPriceTextFiled(
                              hintText: '最高价',
                              // textStyle: t12black,
                              // borderColor: textGrey,
                              controller: _upPriceController,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          '排序',
                          style: t14black,
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: _desSortColor(1), width: 1),
                                borderRadius: BorderRadius.circular(3)),
                            child: Text(
                              '从低到高',
                              style: TextStyle(
                                  fontSize: 12, color: _desSortColor(1)),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_descSorted != 1) {
                                _descSorted = 1;
                              } else {
                                _descSorted = -1;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: _desSortColor(2), width: 1),
                                borderRadius: BorderRadius.circular(3)),
                            child: Text(
                              '从高到低',
                              style: TextStyle(
                                  fontSize: 12, color: _desSortColor(2)),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_descSorted != 2) {
                                _descSorted = 2;
                              } else {
                                _descSorted = -1;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(height: 1),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 13),
                              alignment: Alignment.center,
                              child: Text(
                                '取消',
                                style: t14black,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _resetPrice();
                                _showPopMenu = false;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: lineColor, width: 1))),
                              padding: EdgeInsets.symmetric(vertical: 13),
                              alignment: Alignment.center,
                              child: Text(
                                '确定',
                                style: t14red,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                setPriceSort();
                                _showPopMenu = false;
                                _searchResult();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showPopMenu = false;
                    _descSorted = -1;
                  });
                },
              ),
            ),
          ],
        ),
      );
    } else if (_searIndex == 2 && _showPopMenu) {
      return Container(
        color: Color(0X4D000000),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              color: backWhite,
              child: Wrap(
                children: _categoryL1List
                    .map(
                      (item) => GestureDetector(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: _searchModel.categoryId == item.id
                                      ? textRed
                                      : textGrey,
                                  width: 1),
                              borderRadius: BorderRadius.circular(3)),
                          child: Text(
                            '${item.name}',
                            style: _searchModel.categoryId == item.id
                                ? t12red
                                : t12black,
                          ),
                        ),
                        onTap: () {
                          _searchModel.categoryId = item.id;
                          _showPopMenu = false;
                          _searchResult();
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(child: GestureDetector(
              onTap: () {
                setState(() {
                  _showPopMenu = false;
                  _descSorted = -1;
                });
              },
            ))
          ],
        ),
      );
    }
    return Container();
  }

  ///价格点击确定
  void setPriceSort() {
    if (_descSorted == -1) {
      _searchModel.descSorted = null;
    } else if (_descSorted == 1) {
      _searchModel.descSorted = false;
    } else if (_descSorted == 2) {
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
  }

  ///排序点击颜色
  Color _desSortColor(int type) {
    if (type == 1) {
      if (_descSorted == 1) {
        return textRed;
      } else {
        return textBlack;
      }
    } else if (type == 2) {
      if (_descSorted == 2) {
        return textRed;
      } else {
        return textBlack;
      }
    } else {
      return textBlack;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();

    _lowPriceController.dispose();
    _upPriceController.dispose();
    _scrollController.dispose();
    _streamController.close();
  }
}
