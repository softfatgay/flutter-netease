import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/net/DioManager.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/search_widget.dart';

class SearchGoods extends StatefulWidget {
  final Map arguments;

  SearchGoods({this.arguments});

  @override
  _SearchGoodsState createState() => _SearchGoodsState();
}

class _SearchGoodsState extends State<SearchGoods> {
  TextEditingController controller = TextEditingController();
  bool isSearch = false;
  Timer timer;
  String textValue = '';
  var searchTipsData = [];
  var searchTipsresultData = [];

  var serachResult = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSearchTips();

    _getTipsResult('休闲零食');
  }

  void _getSearchTips() async {
    var params = {'keywordPrefix': textValue};
    DioManager.post(
      'xhr/search/searchAutoComplete.json',
      params,
      (data) {
        setState(() {
          searchTipsData = data['data'];
          serachResult = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
//          _showPop(),
          !isSearch ? Container() : _showPop(),
          SearchWidget(
            hintText: '输入搜索',
            controller: controller,
            onValueChangedCallBack: (value) {
              _startTimer(value);
            },
            onSearchBtnClick: (value) {
              setState(() {
                textValue = value;
                isSearch = true;
                _getSearchTips();
              });
            },
          ),
        ],
      ),
    );
  }

  _startTimer(String value) {
    isSearch = false;
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer(Duration(seconds: 1), () {
      setState(() {
        textValue = value;
        isSearch = true;
        _getSearchTips();
      });
    });
  }

  Widget _showPop() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).padding.top + 50,
            );
          }, childCount: 1),
        ),
        SliverGrid(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            Widget widget = Container(
                margin: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: index == searchTipsData.length - 1
                        ? BorderSide(width: 0, color: Colors.transparent)
                        : BorderSide(width: 0.5, color: Colors.grey[200]),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Text(
                          searchTipsData[index],
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ));
            return GestureDetector(
              child: widget,
              onTap: () {
                _getTipsResult(searchTipsData[index]);
              },
            );
          }, childCount: searchTipsData.length),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 8,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0
          ),
        ),
        SliverGrid(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            Widget widget = Container(
              decoration: BoxDecoration(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: searchTipsresultData[index]['primaryPicUrl'],
                        fit: BoxFit.cover,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200]
                      ),
                    ),
                  )
                ],
              ),
            );
            return GestureDetector(child: widget,onTap: (){
              Toast.show('$index', context);
            },);
          }, childCount: searchTipsresultData.length),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

//  http://m.you.163.com/xhr/search/search.json?keyword=%E4%BC%91%E9%97%B2%E9%9B%B6%E9%A3%9F&sortType=0&descSorted=false&categoryId=0&matchType=0&floorPrice=-1&upperPrice=-1&size=40&itemId=0&stillSearch=false&searchWordSource=7&needPopWindow=true&_stat_search=autoComplete
  void _getTipsResult(String searchTipsData) {
    var params = {
      'keyword': searchTipsData,
      'sortType': '0',
      'descSorted': 'false',
      'categoryId': '0',
      'matchType': '0',
      'floorPrice': '-1',
      'upperPrice': '-1',
      'size': '40',
      'itemId': '0',
      'stillSearch': 'false',
      'searchWordSource': '7',
      'needPopWindow': 'true',
      '_stat_search': 'autoComplete',
    };
    DioManager.get('xhr/search/search.json', params, (data) {
      setState(() {
        searchTipsresultData = data['data']['directlyList'];
        serachResult = true;
      });
    });
  }
}
