import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/components/package_item_widget.dart';
import 'package:flutter_app/ui/mine/model/red_package_mode.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/sliver_footer.dart';
import 'package:flutter_app/widget/slivers.dart';

class RedPacketListPage extends StatefulWidget {
  final int searchType;

  const RedPacketListPage({Key key, this.searchType}) : super(key: key);

  @override
  _RedEnvelopeListState createState() => _RedEnvelopeListState();
}

class _RedEnvelopeListState extends State<RedPacketListPage> {
  int _page = 1;
  int _size = 20;

  bool _hasMore = false;
  List<PackageItem> _dataList = [];

  ScrollController _scrollController = new ScrollController();
  bool _isLoading = true;
  BannerData _banner;
  var _pagination;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container()
        : CustomScrollView(
            controller: _scrollController,
            slivers: [
              _banner == null
                  ? singleSliverWidget(Container())
                  : _topBanner(context),
              _buildItems(context),
              SliverFooter(hasMore: _hasMore),
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
        children: _dataList.map((item) {
          return PackageItemWidget(
              packageItem: item, searchType: widget.searchType);
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
        _dataList = redPackageMode.searchResult.result;
        _pagination = redPackageMode.searchResult.pagination;
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
                  imageUrl: _banner.backgroundPic,
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
                      child: CachedNetworkImage(imageUrl: _banner.icon),
                    ),
                    Text('${_banner.title}')
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
