import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/mine/components/open_vip_widget.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/sort/component/good_items.dart';
import 'package:flutter_app/utils/constans.dart';

class RewardNumPage extends StatefulWidget {
  final Map? params;

  const RewardNumPage({Key? key, this.params}) : super(key: key);

  @override
  _RewardNumPageState createState() => _RewardNumPageState();
}

class _RewardNumPageState extends State<RewardNumPage> {
  final _scrollController = new ScrollController();

  int? _page = 1;
  int _size = 20;

  var _hasMore = false;
  bool _isShowFloatBtn = false;
  var _pagination;

  List<ItemListItem> _dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(_scrollListener);
    _getRcmd();
  }

  void _scrollListener() {
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
  }

  void _getRcmd() async {
    Map<String, dynamic> params = {
      "_page": _page,
      "_size": _size,
    };

    await rewardRcmd(params).then((responseData) {
      if (mounted) {
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backWhite,
        appBar: TopAppBar(
          title: widget.params!['id'] == 4 ? '津贴' : '余额',
        ).build(context),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            singleSliverWidget(widget.params!['id'] == 4
                ? _buildjintieTop(context)
                : _buildBalanceTop(context)),
            singleSliverWidget(_buildRcmdTitle(context)),
            GoodItems(dataList: _dataList),
            SliverFooter(hasMore: _hasMore),
          ],
        ),
        floatingActionButton:
            !_isShowFloatBtn ? Container() : floatingAB(_scrollController));
  }

  ///https://yanxuan.nosdn.127.net/429ac440ce956e70752b6a249ddfe468.png
  _buildBalanceTop(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/balance_header_back.png'),
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
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '余额(元)',
                          style: t12white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/images/dec_icon.png',
                          width: 14,
                          height: 14,
                          color: backWhite,
                        ),
                      ],
                    ),
                    onTap: () {
                      Routers.push(Routers.webView, context,
                          {'url': '${NetConstants.baseUrl}help/new#/36/137'});
                    },
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      '¥${widget.params!['value']}',
                      style: num20WhiteBold,
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
                      if (widget.params!['id'] == 4) {
                        url = '${NetConstants.baseUrl}bonus/detail';
                      } else {
                        url = '${NetConstants.baseUrl}reward/detail';
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
                                  style:
                                      TextStyle(color: textWhite, fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '¥${widget.params!['value']}',
                                  style: num16WhiteBold,
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
                                  style:
                                      TextStyle(color: textWhite, fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '¥${widget.params!['value']}',
                                  style: num16WhiteBold,
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
                                style:
                                    TextStyle(color: textWhite, fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '¥${widget.params!['value']}',
                                style: num16WhiteBold,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        color: backWhite,
                        borderRadius: BorderRadius.circular(13)),
                    child: Image.asset('assets/images/kefu.png'),
                  ),
                  onTap: () {
                    Routers.push(Routers.webView, context, {'url': kefuUrl});
                  },
                ),
              )
            ],
          ),
        ),
        OpenVipWidget(),
        Container(
          height: 10,
          color: backColor,
        )
      ],
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
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/dec_icon.png',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '什么是购物津贴？',
                          style: t14white,
                        ),
                      ],
                    ),
                    onTap: () {
                      Routers.push(Routers.webView, context,
                          {'url': '${NetConstants.baseUrl}help/new#/36/119'});
                    },
                  ),
                ),
                GestureDetector(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/mine/kefu.png',
                        width: 18,
                        height: 18,
                        color: backWhite,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '有问题，找客服',
                        style: t14white,
                      )
                    ],
                  ),
                  onTap: () {
                    Routers.push(Routers.webView, context, {'url': kefuUrl});
                  },
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/jintie_header_back.png'))),
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
                          child: Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '¥',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xFFCCCCCC),
                                ),
                              ),
                              Text(
                                '${widget.params!['value']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30,
                                    color: Color(0xFFCCCCCC),
                                    fontFamily: 'DINAlternateBold'),
                              )
                            ],
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
                              Text('明细', style: t14grey),
                              Image.asset(
                                'assets/images/arrow_right.png',
                                color: textGrey,
                                width: 12,
                                height: 12,
                              )
                            ],
                          ),
                          onTap: () {
                            String url = '';
                            if (widget.params!['id'] == 4) {
                              url = '${NetConstants.baseUrl}bonus/detail';
                            } else {
                              url = '${NetConstants.baseUrl}reward/detail';
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
            style: t16black,
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
