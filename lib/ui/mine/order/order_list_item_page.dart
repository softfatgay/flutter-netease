import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/model/orderListModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/round_net_image.dart';
import 'package:flutter_app/widget/timer_text.dart';

class OrderListItemPage extends StatefulWidget {
  final Map arguments;

  const OrderListItemPage({Key key, this.arguments}) : super(key: key);

  @override
  _OrderListItemPageState createState() => _OrderListItemPageState();
}

class _OrderListItemPageState extends State<OrderListItemPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  OrderListModel _data;
  List<OrderListItem> _orderList;
  bool _isLoading = true;
  int _status = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getOrderList(false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Loading() : _buildOrderList();
  }

  void _getOrderList(bool isDelete) async {
    setState(() {
      if (!isDelete) {
        _isLoading = true;
      }
    });
    Map<String, dynamic> params = {
      "size": 20,
      "status": widget.arguments['status']
    };
    var responseData = await getOrderList(params);

    setState(() {
      _data = OrderListModel.fromJson(responseData.data);
      _orderList = _data.list;
      _isLoading = false;
    });
  }

  _buildOrderList({Map<String, Object> arguments}) {
    return _orderList == null || _orderList.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/no_order.png",
                  width: 120,
                  height: 120,
                ),
                Text(
                  "还没有任何订单呢",
                  style: t14grey,
                )
              ],
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            itemBuilder: (context, index) => _buildItem(context, index),
            itemCount: _orderList.length,
          );
  }

  _buildItem(BuildContext context, int index) {
    OrderListItem item = _orderList[index];
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderNum(context, item),
            _buildPackageItems(context, item, index),
            _buildPayOption(context, item)
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.orderDetailPage, context, {'no': item.no});
      },
    );
  }

  _buildPackageItems(BuildContext context, OrderListItem item, int index) {
    List<PackageListItem> packageList = item.packageList;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: packageList.map<Widget>((package) {
          List picUrlList = package.picUrlList;
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
                          .map<Widget>(
                            (item) => Container(
                              decoration: BoxDecoration(
                                  color: Color(0x33CECEC8),
                                  borderRadius: BorderRadius.circular(5)),
                              margin: EdgeInsets.only(right: 8),
                              width: 80,
                              height: 80,
                              child: RoundNetImage(
                                url: item,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("包裹${package.sequence}"),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${item.payOption == true ? "待付款" : "已取消"}",
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
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0x33CECEC8),
                        borderRadius: BorderRadius.circular(5)),
                    width: 80,
                    height: 80,
                    child: RoundNetImage(
                      url: picUrlList[0],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "${package.name}",
                                  style: t14black,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                "包裹${package.sequence}",
                                style: t14black,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${package.specDesc}",
                                  style: t12grey,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                "${item.payOption == true ? "待付款" : "已取消"}",
                                style: TextStyle(color: redColor, fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }).toList(),
      ),
    );
  }

  _buildPayOption(BuildContext context, OrderListItem item) {
    return (item.payOption && item.remainTime > 0)
        ? Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                children: [
                  Text("应付:  "),
                  Expanded(
                      child: Text(
                    "¥${item.actualPrice}",
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
                        child: TimerText(
                          time: item.remainTime ~/ 1000,
                          tips: '付款:',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  _buildOrderNum(BuildContext context, OrderListItem item) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "订单编号：${item.no}",
              style: t14black,
            ),
          ),
          item.deleteOption
              ? Container(
                  padding: EdgeInsets.only(right: 10),
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

  void _deleteConfig(BuildContext context, OrderListItem item) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('要删除此订单?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消', style: t14grey),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _deleteOrder(context, item);
                },
                child: Text('确定', style: t14red),
              ),
            ],
          );
        });
  }

  void _deleteOrder(BuildContext context, OrderListItem item) async {
    var params = {"orderId": item.no};
    await deleteOrder(params).then((value) {
      if (value.code == '200') {
        _getOrderList(true);
      }
    });
  }
}
