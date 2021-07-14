import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/ui/sort/model/searchResultModel.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/search_widget.dart';
import 'package:flutter_app/widget/sliver_footer.dart';

@Deprecated('使用SearchIndexPage代替')
class SearchGoodsPage extends StatefulWidget {
  final Map arguments;

  SearchGoodsPage({this.arguments});

  @override
  _SearchGoodsPageState createState() => _SearchGoodsPageState();
}

class _SearchGoodsPageState extends State<SearchGoodsPage> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;
  String _textValue = '';

  ///搜索提示
  var _searchTipsData = [];

  var _serachResult = false;

  //初始化,状态
  var isFirstLoading = true;
  var _bottomTipsText = '搜索更大的世界';

  //请求是以这个参数为加载更多
  var paeSize = 40;
  var itemId = 0;
  var keyword = '';

  ///搜索结果
  List<ItemListItem> _directlyList = [];
  // var _itemId = 0;
  var _hasMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _textValue = widget.arguments['id'];
    });

    _getSearchTips();
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasMore) {
          _isLoading = true;
          _getTipsResult();
        }
      }
    });
  }

//  http://m.you.163.com/xhr/search/search.json?keyword=%E9%9B%B6%E9%A3%9F&sortType=0&descSorted=false&categoryId=0&matchType=0&floorPrice=-1&upperPrice=-1&size=40&itemId=0&stillSearch=false&searchWordSource=1&needPopWindow=true&_stat_search=userhand
//  http://m.you.163.com/xhr/search/search.json?keyword=%E9%9B%B6%E9%A3%9F&sortType=0&descSorted=false&categoryId=0&matchType=1&floorPrice=-1&upperPrice=-1&size=40&itemId=3827056&stillSearch=false&searchWordSource=1&needPopWindow=false
  void _getTipsResult() async {
    var params = {
      'csrf_token': csrf_token,
      '__timestamp': '${DateTime.now().millisecondsSinceEpoch}',
      '_stat_search': 'autoComplete',
      'keyword': keyword,
      'sortType': '0',
      'descSorted': 'false',
      'categoryId': '0',
      'matchType': '0',
      'floorPrice': '-1',
      'upperPrice': '-1',
      'size': paeSize,
      'itemId': itemId,
      'stillSearch': 'false',
      'searchWordSource': '7',
      'needPopWindow': 'false'
    };
    if (!_hasMore) {
      params.addAll({'_stat_search': 'userhand'});
    } else {
      params.remove('_stat_search');
    }
    var responseData = await searchSearch(params);
    var data = responseData.data;
    var searchResultModel = SearchResultModel.fromJson(data);
    setState(() {
      var directlyList = searchResultModel.directlyList;
      _hasMore = searchResultModel.hasMore;
      if (directlyList == null || directlyList.isEmpty) {
        isFirstLoading = true;
        _bottomTipsText = '没有找到您想要的内容';
      } else {
        _directlyList.addAll(directlyList);
        // _itemId = _directlyList[_directlyList.length - 1].itemTagList[0].itemId;
        if (!_hasMore) {
          _bottomTipsText = '没有更多了';
        }
        _isLoading = false;
        _serachResult = true;
      }
    });
  }

  void _getSearchTips() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> params = {'keywordPrefix': _textValue};
    var responseData = await searchTips(params);
    setState(() {
      _isLoading = false;
      _searchTipsData = responseData.data;
      _serachResult = false;
      _hasMore = false;
      if (_searchTipsData.length == 0) {
        _bottomTipsText = '暂时没有您想要的内容';
      } else {
        _bottomTipsText = '搜索更大的世界';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backColor,
      child: Stack(
        children: <Widget>[
//          _showPop(),
          _isLoading ? Loading() : _showPop(),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: SearchWidget(
              textValue: _textValue,
              hintText: '请输入商品名称',
              controller: _controller,
              onValueChangedCallBack: (value) {
                _textValue = value;
                _getSearchTips();
              },
              onBtnClick: (value) {
                Util.hideKeyBord(context);
                _textValue = value;
                _getSearchTips();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _showPop() {
    return Container(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                height: MediaQuery.of(context).padding.top + 50,
              );
            }, childCount: 1),
          ),
          _serachResult ? buildNullSliver() : buildSearchTips(),
          !_serachResult
              ? buildNullSliver()
              : GoodItemWidget(dataList: _directlyList),
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

//  http://m.you.163.com/xhr/search/search.json?keyword=%E4%BC%91%E9%97%B2%E9%9B%B6%E9%A3%9F&sortType=0&descSorted=false&categoryId=0&matchType=0&floorPrice=-1&upperPrice=-1&size=40&itemId=0&stillSearch=false&searchWordSource=7&needPopWindow=true&_stat_search=auto
//  http://m.you.163.com/xhr/search/search.json?keyword=%E4%BC%91%E9%97%B2%E9%9B%B6%E9%A3%9F&sortType=0&descSorted=false&categoryId=0&matchType=0&floorPrice=-1&upperPrice=-1&size=40&itemId=1056006&stillSearch=false&searchWordSource=7&needPopWindow=false
  buildImage(int index) {
    return Container(
      child: Stack(
        alignment: const FractionalOffset(0.0, 1), //方法一
        children: <Widget>[
          Container(
            height: 30,
            child: CachedNetworkImage(
              imageUrl:
                  _directlyList[index].listPromBanner.bannerContentUrl ?? '',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: 70,
            height: 35,
            child: CachedNetworkImage(
              imageUrl:
                  _directlyList[index].listPromBanner.bannerTitleUrl ?? '',
              fit: BoxFit.fill,
            ),
          ),
          Container(
              width: 70,
              height: 35,
              child: Center(
                child: Stack(
                  alignment: const FractionalOffset(0.5, 0.5),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _directlyList[index].listPromBanner.promoTitle ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          _directlyList[index].listPromBanner.promoSubTitle ??
                              '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          Positioned(
            left: 75,
            height: 30,
            child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Center(
                  child: Text(_directlyList[index].listPromBanner.content,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                )),
          ),
        ],
      ),
    );
  }

  buildBottomText(int index) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFF1ECE2)),
      padding: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.centerLeft,
      child: Text(
        _directlyList[index].simpleDesc,
        style: TextStyle(color: Color(0XFF875D2A), fontSize: 14),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  SliverList buildNullSliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container();
      }, childCount: 1),
    );
  }

  SliverGrid buildSearchTips() {
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
              _directlyList = [];
              Util.hideKeyBord(context);
              keyword = _searchTipsData[index];
              _isLoading = true;
              _getTipsResult();
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
}
