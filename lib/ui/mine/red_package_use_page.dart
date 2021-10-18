import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';

class RedPackageUsePage extends StatefulWidget {
  final Map? params;

  const RedPackageUsePage({Key? key, this.params}) : super(key: key);

  @override
  _RedPackageUsePageState createState() => _RedPackageUsePageState();
}

class _RedPackageUsePageState extends State<RedPackageUsePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _redpackageItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [_buildGoods(context)],
      ),
    );
  }

  _buildGoods(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [],
    );
  }

  void _redpackageItems() async{
    var param = {
      'pageSize': 60,
      'pageNo': 1,
      'lowPrice': -1,
      'highPrice': -1,
      'itemCategoryId': -1,
      'showPromotion': true,
      'showTags': true,
      'id': '12b6659bdb584a328c131eae664d3e60',
      'type': 3

    };
    await redpackageItems(param);
  }
}
