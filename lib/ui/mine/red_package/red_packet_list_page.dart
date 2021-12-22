import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/mine/red_package/model/red_package_mode.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RedPacketListPage extends StatefulWidget {
  final int searchType;

  const RedPacketListPage({Key? key, this.searchType = 1}) : super(key: key);

  @override
  _RedEnvelopeListState createState() => _RedEnvelopeListState();
}

class _RedEnvelopeListState extends State<RedPacketListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  int? _page = 1;
  int _size = 20;

  bool _hasMore = false;
  List<PackageItem> _dataList = [];

  final _scrollController = new ScrollController();
  bool _isLoading = true;
  BannerData? _banner;
  var _pagination;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _isLoading
        ? Container()
        : CustomScrollView(
            controller: _scrollController,
            slivers: [
              if (widget.searchType != 3) singleSliverWidget(_useDec()),
              if (_banner != null) _topBanner(context),
              _buildList(context),
              SliverFooter(hasMore: _hasMore),
            ],
          );
  }

  _useDec() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: GestureDetector(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/dec_icon.png',
              width: 16,
              height: 16,
            ),
            SizedBox(width: 5),
            Text(
              '使用说明',
              style: TextStyle(fontSize: 12, color: textLightGrey, height: 1),
            )
          ],
        ),
        onTap: () {
          Routers.push(Routers.webView, context,
              {'url': '${NetConstants.baseUrl}help/new#/36/62'});
        },
      ),
    );
  }

  _buildList(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverStaggeredGrid.countBuilder(
          itemCount: _dataList.length,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          staggeredTileBuilder: (index) =>
              StaggeredTile.count(1, _crossAxis(_dataList[index])),
          itemBuilder: (context, index) {
            return _buildItem(context, _dataList[index], index);
          }),
    );
  }

  _crossAxis(PackageItem item) {
    if (item.isSelected == null || !item.isSelected!) {
      return 1.3;
    }
    return 1.5;
  }

  _buildItem(BuildContext context, PackageItem item, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xFFf5948b),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.searchType == 1 ? Color(0xFFf5948b) : Color(0xFFB8BCC3),
            widget.searchType == 1 ? Color(0xFFec6f73) : Color(0xFFB8BCC3),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              image: widget.searchType == 1
                  ? DecorationImage(
                      image: AssetImage(
                        'assets/images/redpackage_top.png',
                      ),
                      fit: BoxFit.fill,
                    )
                  : null,
            ),
          ),
          SizedBox(height: 5),
          (item.tagList == null || item.tagList!.isEmpty)
              ? Container(height: 12)
              : _buildTagItems(item.tagList!),
          SizedBox(height: 5),
          Text(
            '${item.name}',
            style: t14white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${item.price}',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                    color: textWhite,
                    height: 1),
              ),
              Text(
                '元',
                style: TextStyle(color: textWhite),
              ),
            ],
          ),
          Container(
            child: Text(
              '${Util.long2dateSecond(item.validStartTime! * 1000 as int)}-\n${Util.long2dateSecond(item.validEndTime! * 1000 as int)}',
              style: t10white,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '--------------------------------------------------------',
                      style: t12white,
                      maxLines: 1,
                    ),
                  ),
                  item.schemeUrl == null
                      ? Container(height: 26)
                      : Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: backWhite,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '去使用',
                            style: t12red,
                          ),
                        ),
                ],
              ),
              onTap: () {
                Routers.push(Routers.webView, context, {'url': item.schemeUrl});
              },
            ),
          ),
          Expanded(
              child: GestureDetector(
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${item.rule ?? ''}',
                        style: t12white,
                        maxLines: item.isSelected == null
                            ? 2
                            : (item.isSelected! ? 15 : 2),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Icon(
                    _returnIcon(item),
                    color: Colors.white,
                    size: 26,
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
              setState(() {});
            },
          )),
        ],
      ),
    );
  }

  _buildTagItems(List<TagListItem> list) {
    return SingleChildScrollView(
      child: Row(
        children: list
            .map(
              (item) => Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: _tagDecoration(item),
                child: Text(
                  '${item.tagName}',
                  style: TextStyle(
                      color: item.tagStyle == 1 ? textRed : textWhite,
                      fontSize: 12,
                      height: 1.1),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  _tagDecoration(TagListItem item) {
    if (item.tagStyle == 1) {
      return BoxDecoration(
          color: Color(0xFFFBE8E8),
          borderRadius: BorderRadius.horizontal(right: Radius.circular(10)));
    } else {
      return BoxDecoration(
          color: backRed, borderRadius: BorderRadius.circular(10));
    }
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
    _scrollController.addListener(_scrollListener);
    _getData();
  }

  void _scrollListener() {
    // 如果下拉的当前位置到scroll的最下面
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_hasMore) {
        _getData();
      }
    }
  }

  _getData() async {
    Map<String, dynamic> params = {
      "searchType": widget.searchType,
      "page": _page,
      "size": _size,
    };

    var responseData = await redPacket(params);
    if (mounted) {
      var data = responseData.data;
      var redPackageMode = RedPackageMode.fromJson(data);
      setState(() {
        _banner = redPackageMode.banner;
        _dataList = redPackageMode.searchResult!.result ?? [];
        _pagination = redPackageMode.searchResult!.pagination;
        _hasMore = !_pagination.lastPage;
        _page = _pagination.page + 1;
        _isLoading = false;
      });
    }
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
