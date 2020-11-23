import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/sort/good_item.dart';
import 'package:flutter_app/ui/sort/good_item_new.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_custom_header_delegate.dart';
import 'package:flutter_app/widget/slivers.dart';

class KingKongPage extends StatefulWidget {
  final Map arguments;

  const KingKongPage({Key key, this.arguments}) : super(key: key);

  @override
  _KingKongPageState createState() => _KingKongPageState();
}

class _KingKongPageState extends State<KingKongPage> {
  var banner, dataList = List();
  bool initLoading = true;
  var currentCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getInitData();

  }

  // https://m.you.163.com/item/list.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603334436519&style=pd&categoryId=1005002

  // https://m.you.163.com/item/list?categoryId=1013001&style=pd
  //https://m.you.163.com/item/newItem.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603348965153&

  // https://m.you.163.com/xhr/item/getPreNewItem.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603348965388&

  void _getInitData() async {
    var categoryId;

    String schemeUrl = widget.arguments["schemeUrl"];
    print("////////////////////////////////////");
    print(schemeUrl);


    if (schemeUrl.contains("categoryId")) {
      var split = schemeUrl.split("?");
      var params = split[1];

      List split2 = params.split("&");
      for (var value in split2) {
        if (value.contains("categoryId")) {
          var split3 = value.split("=");
          var split32 = split3[1];
          categoryId = split32;
        }
      }
    } else {
      _getNewData();
      // var responseData = await kingKongDataNoId({
      //   "csrf_token": "61f57b79a343933be0cb10aa37a51cc8",
      //   "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
      // });
      //
      // setState(() {
      //   noIdData = responseData.data;
      // });
    }

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
      currentCategory = data["currentCategory"];
      banner = bannerList.map((item) => item['picUrl']).toList();
      initLoading = false;
    });

    print(responseData.data);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [_buildTitle(context)];
    for (var value in dataList) {
      slivers.add(_bodyTitle(value));
      slivers.add(GoodItemNewWidget(dataList: value["itemList"]));
    }
    return Scaffold(
      backgroundColor: backColor,
      body: initLoading
          ? Loading()
          : CustomScrollView(
              slivers: slivers,
            ),
    );
  }

  _buildTitle(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverCustomHeaderDelegate(
        title: initLoading ? 'loading...' : '${currentCategory['name']}',
        collapsedHeight: 50,
        expandedHeight: 200,
        paddingTop: MediaQuery.of(context).padding.top,
        child: _buildSwiper(context),
      ),
    );
  }

  //轮播图
  _buildSwiper(BuildContext context) {
    return BannerCacheImg(
      imageList: banner,
      onTap: (index) {
        Routers.push(Util.image, context, {'id': '${banner[index]}'});
      },
    );
  }

  _bodyTitle(value) {
    var category = value["category"];
    return singleSliverWidget(Container(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 10,
              color: backGrey,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              category["name"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              category["frontName"],
              style: TextStyle(color: textGrey),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }

  void _getNewData() async{
    var responseData = await kingKongNewItemData({
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    });



    print(responseData.newItems);
  }
}
