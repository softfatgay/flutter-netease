import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/ui/mine/model/orderListModel.dart';
import 'package:flutter_app/ui/mine/order_list_item_page.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class OrderListPage extends StatefulWidget {
  final Map arguments;

  const OrderListPage({Key key, this.arguments}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with TickerProviderStateMixin {
  TabController _mController;

  var _tabItem = [
    {
      "name": "全部",
      "status": 0,
    },
    {
      "name": "待付款",
      "status": 1,
    },
    {
      "name": "待发货",
      "status": 3,
    },
    {
      "name": "已发货",
      "status": 4,
    },
    {
      "name": "已评价",
      "status": 5,
    }
  ];

  int _activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    var title = _tabItem.map<String>((e) => e["name"]).toList();
    return Scaffold(
      backgroundColor: backColor,
      appBar: TabAppBar(
        controller: _mController,
        tabs: title,
        title: '${title.length > 0 ? title[_activeIndex] : ''}',
      ).build(context),
      body: _buildBody(context),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mController = TabController(
        length: _tabItem.length, vsync: this, initialIndex: _activeIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mController.dispose();
  }

  _buildBody(BuildContext context) {
    return Container(
      child: TabBarView(
        children: _tabItem.map<Widget>((item) {
          return OrderListItemPage(arguments: item);
        }).toList(),
        controller: _mController,
      ),
    );
  }
}
