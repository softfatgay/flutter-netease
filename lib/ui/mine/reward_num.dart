import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/sort/good_item.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/colors.dart';
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

  int page = 1;
  int size = 20;

  var dataList = List();

  var hasMore = false;
  bool isShowFloatBtn = false;
  var pagination;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.position.pixels > 500) {
          isShowFloatBtn = true;
        } else {
          isShowFloatBtn = false;
        }
      });

      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (hasMore) {
          _getRcmd();
        }
      }
    });
    _getRcmd();
  }

  void _getRcmd() async {
    Map<String, dynamic> header = {
      "Cookie": cookie,
      "csrf_token": csrf_token,
    };
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "page": page,
      "size": size,
    };

    await rewardRcmd(params, header: header).then((responseData) {
      var result = responseData.data['result'];
      setState(() {
        dataList.insertAll(dataList.length, result);
        pagination = responseData.data['pagination'];
        hasMore = !pagination['lastPage'];
        page = pagination['page']+1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        title: '回馈金',
      ).build(context),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          singleSliverWidget(_buildTop(context)),
          singleSliverWidget(_buildRcmdTitle(context)),
          GoodItemWidget(dataList: dataList),
          SliverFooter(hasMore: hasMore),
        ],
      ),
      floatingActionButton:  !isShowFloatBtn ? Container() : floatingAB(_scrollController)
    );
  }

  Widget _buildTop(BuildContext context) {
    return Container(
      color: backRed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text('回馈金余额（元）', style: TextStyle(color: textWhite, fontSize: 16)),
          SizedBox(
            height: 10,
          ),
          Text(
            '¥${widget.arguments['value']}',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textWhite),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('产看明细', style: TextStyle(color: textWhite, fontSize: 16)),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: textWhite,
                size: 14,
              )
            ],
          ),
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
    );
  }

  Widget _buildRcmdTitle(BuildContext context) {
    return Column(
      children: [
        Container(height: 10,color: backGrey,),
        Container(
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
