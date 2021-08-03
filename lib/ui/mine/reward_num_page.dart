import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/floating_action_button.dart';
import 'package:flutter_app/widget/sliver_footer.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class RewardNumPage extends StatefulWidget {
  final Map arguments;

  const RewardNumPage({Key key, this.arguments}) : super(key: key);

  @override
  _RewardNumPageState createState() => _RewardNumPageState();
}

class _RewardNumPageState extends State<RewardNumPage> {
  ScrollController _scrollController = new ScrollController();

  int _page = 1;
  int _size = 20;

  var _hasMore = false;
  bool _isShowFloatBtn = false;
  var _pagination;

  List<ItemListItem> _dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 500) {
        if (!_isShowFloatBtn) {
          setState(() {
            _isShowFloatBtn = true;
          });
        }
      } else {
        if (_isShowFloatBtn) {
          setState(() {
            _isShowFloatBtn = false;
          });
        }
      }
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasMore) {
          _getRcmd();
        }
      }
    });
    _getRcmd();
  }

  void _getRcmd() async {
    Map<String, dynamic> params = {
      "_page": _page,
      "_size": _size,
    };

    await rewardRcmd(params).then((responseData) {
      List result = responseData.data['result'];
      List<ItemListItem> dataList = [];

      result.forEach((element) {
        dataList.add(ItemListItem.fromJson(element));
      });

      setState(() {
        _dataList.addAll(dataList);
        _pagination = responseData.data['pagination'];
        _hasMore = !_pagination['lastPage'];
        _page = _pagination['page'] + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: TopAppBar(
          title: widget.arguments['id'] == 4 ? '津贴' : '余额',
        ).build(context),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            singleSliverWidget(widget.arguments['id'] == 4
                ? _buildjintieTop(context)
                : _buildBalanceTop(context)),
            singleSliverWidget(_buildRcmdTitle(context)),
            GoodItemWidget(dataList: _dataList),
            SliverFooter(hasMore: _hasMore),
          ],
        ),
        floatingActionButton:
            !_isShowFloatBtn ? Container() : floatingAB(_scrollController));
  }

  ///https://yanxuan.nosdn.127.net/429ac440ce956e70752b6a249ddfe468.png
  _buildBalanceTop(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              'https://yanxuan.nosdn.127.net/429ac440ce956e70752b6a249ddfe468.png'),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '余额(元)',
                    style: t12white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                          border: Border.all(color: backWhite, width: 0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        '?',
                        textAlign: TextAlign.center,
                        style: t10white,
                      ),
                    ),
                    onTap: () {
                      Routers.push(Routers.webView, context,
                          {'url': 'https://m.you.163.com/help/new#/36/137'});
                    },
                  )
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  '¥${widget.arguments['value']}',
                  style: t20whitebold,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('查看明细', style: t14white),
                    Image.asset(
                      'assets/images/arrow_right.png',
                      color: backWhite,
                      width: 12,
                      height: 12,
                    )
                  ],
                ),
                onTap: () {
                  String url = '';
                  if (widget.arguments['id'] == 4) {
                    url = 'https://m.you.163.com/bonus/detail';
                  } else {
                    url = 'https://m.you.163.com/reward/detail';
                  }
                  Routers.push(Routers.webView, context, {'url': url});
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '即将过期',
                              style: TextStyle(color: textWhite, fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '¥${widget.arguments['value']}',
                              style: TextStyle(
                                  color: textWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      )),
                  Container(
                    height: 20,
                    width: 1,
                    color: backWhite,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '待发放',
                              style: TextStyle(color: textWhite, fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '¥${widget.arguments['value']}',
                              style: TextStyle(
                                  color: textWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      )),
                  Container(
                    height: 20,
                    width: 1,
                    color: backWhite,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '累计获得',
                              style: TextStyle(color: textWhite, fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '¥${widget.arguments['value']}',
                              style: TextStyle(
                                  color: textWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
          Positioned(
            right: 20,
            top: 0,
            child: GestureDetector(
              child: Container(
                height: 26,
                padding: EdgeInsets.all(3),
                width: 26,
                decoration: BoxDecoration(
                    color: backWhite, borderRadius: BorderRadius.circular(13)),
                child: Image.asset('assets/images/kefu.png'),
              ),
              onTap: () {
                Routers.push(Routers.webView, context,
                    {'url': 'https://cs.you.163.com/client?k=$kefuKey'});
              },
            ),
          )
        ],
      ),
    );
  }

  _buildjintieTop(BuildContext context) {
    return Container(
      color: backRed,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Text(
                      '什么是购物津贴？',
                      style: t14white,
                    ),
                    onTap: () {
                      Routers.push(Routers.webView, context,
                          {'url': 'https://m.you.163.com/help/new#/36/119'});
                    },
                  ),
                ),
                GestureDetector(
                  child: Text(
                    '有问题，找客服',
                    style: t14white,
                  ),
                  onTap: () {
                    Routers.push(Routers.webView, context,
                        {'url': 'https://cs.you.163.com/client?k=$kefuKey'});
                  },
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://yanxuan.nosdn.127.net/a67070542644056fda9f691238c7d9de.png'))),
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 05,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: Text(
                            '¥${widget.arguments['value']}',
                            style: t20black,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 0,
                        bottom: 0,
                        child: GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('明细', style: t14black),
                              Image.asset(
                                'assets/images/arrow_right.png',
                                color: textBlack,
                                width: 12,
                                height: 12,
                              )
                            ],
                          ),
                          onTap: () {
                            String url = '';
                            if (widget.arguments['id'] == 4) {
                              url = 'https://m.you.163.com/bonus/detail';
                            } else {
                              url = 'https://m.you.163.com/reward/detail';
                            }
                            Routers.push(
                                Routers.webView, context, {'url': url});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildRcmdTitle(BuildContext context) {
    return Column(
      children: [
        Container(
          color: backWhite,
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          child: Text(
            '热销好物推荐',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}
