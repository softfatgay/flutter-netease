import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/net_image.dart';
import 'package:flutter_app/component/sliver_custom_header_delegate.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/model/layawayModel.dart';
import 'package:flutter_app/ui/router/router.dart';

class LayawayPage extends StatefulWidget {
  const LayawayPage({Key? key}) : super(key: key);

  @override
  _LayawayPageState createState() => _LayawayPageState();
}

class _LayawayPageState extends State<LayawayPage> {
  List<LayawayModel> _dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _layaway();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return CustomScrollView(
      slivers: [
        _buildTitle(context),
        _buildItems(),
      ],
    );
  }

  _buildTitle(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverCustomHeaderDelegate(
        title: '超值年购',
        expandedHeight: 160,
        paddingTop: MediaQuery.of(context).padding.top,
        child: NetImage(
          fit: BoxFit.cover,
          imageUrl:
              'https://yanxuan.nosdn.127.net/f4ab9f19bc7298bd5293d93cd94cee44.jpg?imageView&type=webp',
        ),
      ),
    );
  }

  _buildItems() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      var item = _dataList[index];
      var itemWidget = GestureDetector(
        child: _buildItem(item),
        onTap: () {
          Routers.push(Routers.layawayDetail, context, {'id': item.id});
        },
      );
      return itemWidget;
    }, childCount: _dataList.length));
  }

  void _layaway() async {
    var responseData = await layaway();
    if (mounted) {
      if (responseData.OData != null) {
        List layawayList = responseData.OData['layawayIndex']['layawayList'];

        List<LayawayModel> data = [];
        layawayList.forEach((element) {
          data.add(LayawayModel.fromJson(element));
        });
        setState(() {
          _dataList = data;
        });
      }
    }
  }

  _buildItem(LayawayModel item) {
    return Container(
      color: backWhite,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NetImage(
            height: 220,
            imageUrl: '${item.listPicUrl}',
            fit: BoxFit.cover,
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${item.name}',
              style: t18black,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${item.title}',
              style: t14grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '¥${item.retailPrice}',
                  style: num20RedBold,
                ),
                SizedBox(width: 5),
                Text(
                  '¥${_countPrice(item)}',
                  style: TextStyle(
                      fontSize: 15,
                      color: textLightGrey,
                      decoration: TextDecoration.lineThrough,
                      fontFamily: 'DINAlternateBold'),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            return backRed;
                          }),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0))),
                      child: Text(
                        '立即购买',
                        style: t14white,
                      ),
                      onPressed: () {
                        Routers.push(
                            Routers.layawayDetail, context, {'id': item.id});
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _countPrice(LayawayModel item) {
    return (item.retailPrice ?? 0) + (item.favorPrice ?? 0);
  }
}
