import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/sliver_footer.dart';
import 'package:flutter_app/widget/slivers.dart';

class RedPacketList extends StatefulWidget {
  final int searchType;

  const RedPacketList({Key key, this.searchType}) : super(key: key);

  @override
  _RedEnvelopeListState createState() => _RedEnvelopeListState();
}

class _RedEnvelopeListState extends State<RedPacketList> {
  int _page = 1;
  int _size = 20;

  bool hasMore = false;
  var dataList = List();


  ScrollController _scrollController = new ScrollController();
  bool isLoading = true;
var banner;
  var pagination;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : CustomScrollView(
            controller: _scrollController,
            slivers: [
             banner == null?singleSliverWidget(Container()) :_topBanner(context),
              _buildItems(context),
              SliverFooter(hasMore: hasMore),
            ],
          );
  }

  _buildItems(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      sliver: SliverGrid.count(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: dataList.map((item) {
          return Container(
            decoration: BoxDecoration(
                color: widget.searchType == 1 ? redColor : Color(0xFFA5AAB6),
                borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  item['name'],
                  style: TextStyle(color: textWhite),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${item['price']}',
                      style: TextStyle(
                          color: textWhite,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '元',
                      style: TextStyle(color: textWhite),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${Util.long2date(item['validStartTime'] * 1000)}\n-${Util.long2date(item['validEndTime'] * 1000)}',
                  style: TextStyle(color: textWhite, fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    '------------------------------------------------------',
                    style: TextStyle(color: textWhite),
                    maxLines: 1,
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Text(
                    '满${item['condition']}元可用：${item['rule']}',
                    style: TextStyle(color: textWhite),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (hasMore) {
          _getData();
        }
      }
    });

    _getData();
  }

  _getData() async {
    Map<String, dynamic> header = {
      "cookie": cookie,
    };
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "searchType": widget.searchType,
      "page": _page,
      "size": _size,
    };

    redPacket(params, header: header).then((responseData) {
      setState(() {
        setState(() {
          banner = responseData.data['banner'];
          dataList = responseData.data['searchResult']['result'];

          pagination = responseData.data['searchResult']['pagination'];
          hasMore = !pagination['lastPage'];
          _page = pagination['page'] + 1;
          isLoading = false;
        });
        print(responseData);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  _topBanner(BuildContext context) {
    return SliverPadding(padding: EdgeInsets.symmetric(horizontal: 10),sliver: SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        alignment: Alignment.centerLeft,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              height: 40,
              child: CachedNetworkImage(imageUrl: banner['backgroundPic'],fit: BoxFit.cover,),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFE55A61)
              ),
              height: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    child: CachedNetworkImage(imageUrl: banner['icon']),
                  ),
                  Text('${banner['title']}')
                ],
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
