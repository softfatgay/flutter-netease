import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/goodsDetail/model/searchInitModel.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/ui/sort/model/searchResultModel.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/search_widget.dart';
import 'package:flutter_app/widget/sliver_footer.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchIndexPage extends StatefulWidget {
  final Map arguments;

  SearchIndexPage({this.arguments});

  @override
  _SearchIndexPageState createState() => _SearchIndexPageState();
}

class _SearchIndexPageState extends State<SearchIndexPage> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  String _textValue = '';

  var _keywordList = [];
  var _hotKeyWordList = [];

  ///搜索提示
  var _searchTipsData = [];

  var _serachResult = false;

  //初始化,状态
  var _isFirstLoading = true;
  var _bottomTipsText = '搜索更大的世界';

  //请求是以这个参数为加载更多
  var _paeSize = 40;
  var _itemId = 0;
  var _keyword = '';

  ///搜索结果
  List<ItemListItem> _directlyList = [];
  var _hasMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _textValue = widget.arguments['id'];
    });
    _getKeyword();
    _searchInit();
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasMore) {
          _getTipsResult(false);
        }
      }
    });
  }

  void _searchInit() async {
    var param = {
      'csrf_token': csrf_token,
    };
    var responseData = await searchInit(param);
    if (responseData.code == '200') {
      var searchInitModel = SearchInitModel.fromJson(responseData.data);
      setState(() {
        _hotKeyWordList = searchInitModel.hotKeywordVOList;
      });
    }
  }

  void _getTipsResult(bool showProgress) async {
    var params = {
      'csrf_token': csrf_token,
      '__timestamp': '${DateTime.now().millisecondsSinceEpoch}',
      '_stat_search': 'autoComplete',
      'keyword': _keyword,
      'sortType': '0',
      'descSorted': 'false',
      'categoryId': '0',
      'matchType': '0',
      'floorPrice': '-1',
      'upperPrice': '-1',
      'size': _paeSize,
      'itemId': _itemId,
      'stillSearch': 'false',
      'searchWordSource': '7',
      'needPopWindow': 'false'
    };
    if (!_hasMore) {
      params.addAll({'_stat_search': 'userhand'});
    } else {
      params.remove('_stat_search');
    }
    var responseData = await searchSearch(params, showProgress: showProgress);
    var data = responseData.data;
    var searchResultModel = SearchResultModel.fromJson(data);
    setState(() {
      var directlyList = searchResultModel.directlyList;
      _hasMore = searchResultModel.hasMore;
      if (directlyList == null || directlyList.isEmpty) {
        _isFirstLoading = true;
        _bottomTipsText = '没有找到您想要的内容';
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
    return Material(
      color: backColor,
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(height: 48),
              Container(
                color: backWhite,
                padding: EdgeInsets.fromLTRB(
                    10, MediaQuery.of(context).padding.top + 15, 10, 10),
                // padding: EdgeInsets.fromLTRB(10, MediaQuery.of(context).padding.top + 15), 10, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        '历史记录',
                        style: t14grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          _clearKeyword();
                        },
                        child: Image.asset(
                          'assets/images/delete.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                color: backWhite,
                alignment: Alignment.centerLeft,
                child: Wrap(
                  ///商品属性
                  spacing: 5,
                  runSpacing: 10,
                  children: _historyItem(context),
                ),
              ),
              Container(
                color: backWhite,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  '热门搜索',
                  style: t14grey,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                color: backWhite,
                alignment: Alignment.centerLeft,
                child: Wrap(
                  ///商品属性
                  spacing: 5,
                  runSpacing: 10,
                  children: _hotItem(context),
                ),
              ),
            ],
          ),
          _controller.text == null || _controller.text == ''
              ? Container()
              : _showPop(),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: SearchWidget(
              hintText: '请输入商品名称',
              controller: _controller,
              onValueChangedCallBack: (value) {
                setState(() {
                  _controller.text = value;
                });
                if (value == '' || value == null) {
                  _controller.text = '';
                } else {
                  _textValue = value;
                  _getSearchTips();
                }
              },
              onBtnClick: (value) {
                Navigator.pop(context);
                // _saveKey(value);
                // Util.hideKeyBord(context);
                // _textValue = value;
                // _getSearchTips();
              },
            ),
          ),
        ],
      ),
    );
  }

  _showPop() {
    return Container(
      color: backWhite,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          singleSliverWidget(
              Container(height: MediaQuery.of(context).padding.top + 50)),
          _serachResult
              ? GoodItemWidget(dataList: _directlyList)
              : _buildSearchTips(),
          SliverFooter(hasMore: _hasMore, tipsText: _bottomTipsText),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
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
                  child: Image.asset(
                    'assets/images/search_icon.png',
                    width: 12.0,
                    height: 12.0,
                  ),
                )
              ],
            ));
        return GestureDetector(
          child: widget,
          onTap: () {
            setState(() {
              _searchResult(_searchTipsData[index]);
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

  void _searchResult(String keyword) {
    _directlyList = [];
    Util.hideKeyBord(context);
    _keyword = keyword;
    _saveKey(keyword);
    _controller.text = keyword;
    _getTipsResult(true);
  }

  ///本地存储keyword
  void _saveKey(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var keywordStr = sharedPreferences.getString('keyword');
    if (keywordStr != null) {
      var split = keywordStr.split(';');
      if (split.indexOf(key) == -1) {
        sharedPreferences.setString('keyword', keywordStr + ';$key');
      }
    } else {
      sharedPreferences.setString('keyword', '$key');
    }
  }

  _clearKeyword() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('keyword', '');
    _getKeyword();
  }

  void _getKeyword() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var keyword = sharedPreferences.getString('keyword');
    if (keyword != null && keyword != '') {
      var split = keyword.split(';');
      split.removeAt(0);
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
                  _controller.text = value;
                  _textValue = value;
                  _getSearchTips();
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
              _searchResult(value.keyword);
            },
          ),
        )
        .toList();
  }
}
