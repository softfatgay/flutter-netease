import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/widget/swiper.dart';

class KingKongPage extends StatefulWidget {
  final Map arguments;

  const KingKongPage({Key key, this.arguments}) : super(key: key);

  @override
  _KingKongPageState createState() => _KingKongPageState();
}

class _KingKongPageState extends State<KingKongPage> {
  var banner, dataList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getInitData();
  }

  // https://m.you.163.com/item/list.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603334436519&style=pd&categoryId=1005002

  // https://m.you.163.com/item/list?categoryId=1013001&style=pd

  void _getInitData() async {
    var categoryId;

    String schemeUrl = widget.arguments["schemeUrl"];
    var split = schemeUrl.split("?");
    var params = split[1];

    if (params.contains("categoryId")) {
      List split2 = params.split("&");
      for (var value in split2) {
        if (value.contains("categoryId")) {
          var split3 = value.split("=");
          var split32 = split3[1];
          categoryId = split32;
        }
      }
    } else {}

    var responseData = await kingKongData({
      "csrf_token": "61f57b79a343933be0cb10aa37a51cc8",
      "style": "pd",
      "categoryId": categoryId,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    });

    var data = responseData.data;
    setState(() {
      var bannerList = data["currentCategory"]["bannerList"];
      dataList = data["categoryItemList"];
      banner = bannerList
          .map((item) => CachedNetworkImage(
                imageUrl: item['picUrl'],
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ))
          .toList();
    });

    print(responseData.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSwiper(context),
        ],
      ),
    );
  }

  //轮播图
  _buildSwiper(BuildContext context) {
    return SliverToBoxAdapter(
      child: banner == null ? Container() : SwiperView(banner),
    );
  }
}
