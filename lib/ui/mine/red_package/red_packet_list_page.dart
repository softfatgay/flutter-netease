import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/red_package/model/red_package_mode.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/slivers.dart';

class RedPacketListPage extends StatefulWidget {
  final int searchType;

  const RedPacketListPage({Key? key, this.searchType = 1}) : super(key: key);

  @override
  _RedEnvelopeListState createState() => _RedEnvelopeListState();
}

class _RedEnvelopeListState extends State<RedPacketListPage> {
  int? _page = 1;
  int _size = 20;

  bool _hasMore = false;
  List<PackageItem>? _dataList = [];

  final _scrollController = new ScrollController();
  bool _isLoading = true;
  BannerData? _banner;
  var _pagination;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container()
        : CustomScrollView(
            controller: _scrollController,
            slivers: [
              singleSliverWidget(_useDec()),
              if (_banner != null) _topBanner(context),
              _buildItems(context),
              SliverFooter(hasMore: _hasMore),
            ],
          );
  }

  _useDec() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: GestureDetector(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/dec_icon.png',
              width: 18,
              height: 18,
            ),
            SizedBox(width: 5),
            Text(
              '使用说明',
              style: t14grey,
            )
          ],
        ),
        onTap: () {
          Routers.push(Routers.webView, context,
              {'url': 'https://m.you.163.com/help/new#/36/62'});
        },
      ),
    );
  }

  _buildItems(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        return _buildItem(context, _dataList![index], index);
      }, childCount: _dataList!.length)),
    );
  }

  _buildItem(BuildContext context, PackageItem item, int index) {
    var backColor =
        widget.searchType == 1 ? Color(0xFFE8837F) : Color(0xFFAFB4BC);
    var bottomColor =
        widget.searchType == 1 ? Color(0xFFE8837F) : Color(0xFFA3A5AE);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: backColor, borderRadius: BorderRadius.circular(4)),
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(color: backColor),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${item.price}',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w300,
                                color: textWhite),
                          ),
                          Text(
                            '元',
                            style: TextStyle(color: textWhite),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text('${item.name ?? ''}', style: t14white),
                              Text(
                                '${Util.long2date(item.validStartTime! * 1000 as int)}-${Util.long2date(item.validEndTime! * 1000 as int)}',
                                style:
                                    TextStyle(color: textWhite, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                widget.searchType == 1
                    ? GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(top: 15, left: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: backWhite,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '去使用',
                            style: t14red,
                          ),
                        ),
                        onTap: () {
                          Routers.push(Routers.webView, context,
                              {'url': item.schemeUrl});
                        },
                      )
                    : Container(height: 15),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                        color: bottomColor,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(4))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${item.rule ?? ''}',
                            style: t12white,
                            maxLines: item.isSelected == null
                                ? 1
                                : (item.isSelected! ? 15 : 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          _returnIcon(item),
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (item.isSelected == null) {
                        item.isSelected = true;
                      } else {
                        item.isSelected = !item.isSelected!;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          if (item.tagList != null && item.tagList!.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 10, left: 5),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                  color: Color(0xFFFBE8E8),
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(10))),
              child: Text(
                '${item.tagList![0].tagName}',
                style: t12red,
              ),
            ),
        ],
      ),
    );
  }

  _returnIcon(PackageItem item) {
    if (item.isSelected == null) {
      return Icons.keyboard_arrow_down_rounded;
    } else {
      if (item.isSelected!) {
        return Icons.keyboard_arrow_up_rounded;
      } else {
        return Icons.keyboard_arrow_down_rounded;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasMore) {
          _getData();
        }
      }
    });

    _getData();
  }

  _getData() async {
    Map<String, dynamic> params = {
      "searchType": widget.searchType,
      "page": _page,
      "size": _size,
    };

    redPacket(params).then((responseData) {
      var data = responseData.data;
      var redPackageMode = RedPackageMode.fromJson(data);
      setState(() {
        _banner = redPackageMode.banner;
        _dataList = redPackageMode.searchResult!.result;
        _pagination = redPackageMode.searchResult!.pagination;
        _hasMore = !_pagination.lastPage;
        _page = _pagination.page + 1;
        _isLoading = false;
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
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                height: 40,
                child: CachedNetworkImage(
                  imageUrl: _banner!.backgroundPic!,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xFFE55A61)),
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      child: CachedNetworkImage(imageUrl: _banner!.icon!),
                    ),
                    Text('${_banner!.title}')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
