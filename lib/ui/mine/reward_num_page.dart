import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/floatingActionButton.dart';
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
      "csrf_token": csrf_token,
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
        appBar: TabAppBar(
          title: widget.arguments['id'] == 4 ? '津贴' : '回馈金',
        ).build(context),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            singleSliverWidget(_buildTop(context)),
            singleSliverWidget(_buildRcmdTitle(context)),
            GoodItemWidget(dataList: _dataList),
            SliverFooter(hasMore: _hasMore),
          ],
        ),
        floatingActionButton:
            !_isShowFloatBtn ? Container() : floatingAB(_scrollController));
  }

  Widget _buildTop(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      color: redLightColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.arguments['id'] == 4 ? '津贴（元）' : '回馈金余额（元）',
              style: t14white),
          SizedBox(
            height: 10,
          ),
          Text(
            '¥${widget.arguments['value']}',
            style: t20whitebold,
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('明细', style: t14white),
                Icon(
                  Icons.arrow_forward_ios,
                  color: textWhite,
                  size: 14,
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
              Routers.push(Routers.webViewPageAPP, context, {'url': url});
            },
          ),
          widget.arguments['id'] == 4
              ? Container()
              : Row(
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
                                style:
                                    TextStyle(color: textWhite, fontSize: 12),
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
                                style:
                                    TextStyle(color: textWhite, fontSize: 12),
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
    );
  }

  Widget _buildRcmdTitle(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10,
          color: backGrey,
        ),
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
