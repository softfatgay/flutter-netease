import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:flutter_app/widget/timer_text.dart';

class OrderList extends StatefulWidget {
  final Map arguments;

  const OrderList({Key key, this.arguments}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with TickerProviderStateMixin {
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
  bool _isLoading = true;

  var _data;
  List _orderList = [];
  int status = 0;

  @override
  Widget build(BuildContext context) {
    var title = _tabItem.map<String>((e) => e["name"]).toList();
    return Scaffold(
      appBar: TabAppBar(
        controller: _mController,
        tabs: title,
        title: '${title.length > 0 ? title[_activeIndex] : ''}',
      ).build(context),
      body: _buildBody(context),
    );
  }

  // https://m.you.163.com/xhr/order/getList.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&size=10&lastOrderId=0&status=0

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mController = TabController(
        length: _tabItem.length, vsync: this, initialIndex: _activeIndex);
    _mController.addListener(() {
      setState(() {
        ///防止点击走两次回调
        if (_mController.index == _mController.animation.value) {
          _activeIndex = _mController.index;
          status = _tabItem[_activeIndex]["status"];
          _getorderList(false);
        }
      });
    });

    _getorderList(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mController.dispose();
  }

  _buildBody(BuildContext context) {
    return Container(
      child: _isLoading
          ? Loading()
          : TabBarView(
              children: _tabItem.map<Widget>((item) {
                return _buildOrderList(arguments: item);
              }).toList(),
              controller: _mController,
            ),
    );
  }

  void _getorderList(bool isdelete) async {
    setState(() {
      if (!isdelete) {
        _isLoading = true;
      }
    });
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "size": 20,
      "status": status
    };

    Map<String, dynamic> header = {"Cookie": cookie};
    var responseData = await getOrderList(params, header: header);

    setState(() {
      _data = responseData.data;
      _orderList = _data["list"];
      _isLoading = false;
    });
  }

  _buildOrderList({Map<String, Object> arguments}) {
    return _orderList == null || _orderList.length == 0
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/images/order.png")),
                Text(
                  "暂无订单",
                  style: TextStyle(color: redColor),
                )
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) => _buildItem(context, index),
            itemCount: _orderList.length,
          );
  }

  _buildItem(BuildContext context, int index) {
    var item = _orderList[index];
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderNum(context, item),
          _buildPackageItems(context, item, index),
          _buildPayOption(context, item)
        ],
      ),
    );
  }

  _buildPackageItems(BuildContext context, var item, int index) {
    List packageList = item["packageList"];
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: packageList.map<Widget>((package) {
          List picUrlList = package["picUrlList"];
          if (picUrlList.length > 1) {
            ///包裹多个
            return Container(
              padding: EdgeInsets.fromLTRB(0, 15, 15, 10),
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: backGrey, width: 1))),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: picUrlList
                          .map<Widget>((item) => Container(
                                child: CachedNetworkImage(
                                  imageUrl: item,
                                  width: 80,
                                  height: 80,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("包裹${package["sequence"]}"),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        item["payOption"] == true ? "待付款" : "已取消",
                        style: TextStyle(color: redColor, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container(
              padding: EdgeInsets.fromLTRB(0, 15, 15, 10),
              margin: EdgeInsets.only(left: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: backGrey, width: 1))),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: picUrlList[0],
                    width: 80,
                    height: 80,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 30, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            package["name"],
                            style: t14black,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            package["specDesc"],
                            style: t12grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "包裹${package["sequence"]}",
                        style: t14black,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        item["payOption"] == true ? "待付款" : "已取消",
                        style: TextStyle(color: redColor, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }).toList(),
      ),
    );
  }

  _buildPayOption(BuildContext context, item) {
    return (item["payOption"] == true && item['remainTime'] > 0)
        ? Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                children: [
                  Text("应付:  "),
                  Expanded(
                      child: Text(
                    "¥${item["actualPrice"]}",
                    style: t14black,
                  )),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {},
                        child: TimerText(time: item['remainTime'] ~/ 1000),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  _buildOrderNum(BuildContext context, var item) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
      child: Row(
        children: [
          Expanded(
              child: Text(
            "订单编号：${item["no"]}",
            style: t14black,
          )),
          item['deleteOption']
              ? Container(
                  child: GestureDetector(
                    onTap: () {
                      _deleteConfig(context, item);
                    },
                    child: Image.asset(
                      'assets/images/delete.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _deleteConfig(BuildContext context, item) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('要删除此订单?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  _deleteOrder(context, item);
                },
                textColor: textRed,
                child: Text('确定'),
              ),
            ],
          );
        });
  }

  void _deleteOrder(BuildContext context, item) async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "orderId": item['no']
    };

    Map<String, dynamic> header = {"Cookie": cookie};

    await deleteOrder(params, header: header).then((value) {
      if (value.code == '200') {
        _getorderList(true);
      }
    });
  }
}
