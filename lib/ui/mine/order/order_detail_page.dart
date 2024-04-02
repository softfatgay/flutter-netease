import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/model/orderDetailModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/slivers.dart';

class OrderDetailPage extends StatefulWidget {
  final Map? params;

  const OrderDetailPage({Key? key, this.params}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String? _no = '';
  late OrderDetailModel _detailModel;

  bool _firstLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      var no = widget.params!['no'];
      _no = no;
    });
    super.initState();
    _orderDetail();
  }

  void _orderDetail() async {
    Map<String, dynamic> params = {'orderId': _no};
    var responseData = await orderDetail(params);
    if (mounted) {
      if (responseData.code == '200') {
        var orderDetailModel = OrderDetailModel.fromJson(responseData.data);
        setState(() {
          _detailModel = orderDetailModel;
          _firstLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '订单详情',
      ).build(context),
      body: _firstLoading ? Loading() : _buildBody(),
    );
  }

  _buildBody() {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            singleSliverWidget(_address()),
            singleSliverWidget(_divider()),
            _goods(),
            singleSliverWidget(_orderInfo()),
            singleSliverWidget(_divider()),
            singleSliverWidget(_price()),
            singleSliverWidget(_serve()),
            singleSliverWidget(Container(height: 60)),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: backWhite,
                border: Border(top: BorderSide(color: lineColor, width: 1))),
            height: 50,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: textBlack, width: 0.5)),
                child: Text(
                  '删除订单',
                  style: t14black,
                ),
              ),
              onTap: () {
                _deleteConfig(context);
              },
            ),
          ),
        )
      ],
    );
  }

  void _deleteConfig(BuildContext context) {
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
                  _deleteOrder(context);
                },
                child: Text('确定', style: t14red),
              ),
            ],
          );
        });
  }

  void _deleteOrder(BuildContext context) async {
    var params = {"orderId": _no};
    await deleteOrder(params).then((value) {
      if (value.code == '200') {
        Toast.show('删除完成', context);
        Navigator.pop(context);
      }
    });
  }

  _divider({double height = 10.0}) {
    return Container(
      height: height,
      color: backColor,
    );
  }

  _address() {
    var address = _detailModel.address!;
    return Container(
      color: Color(0XFFFFFCED),
      child: Column(
        children: [
          Image.asset('assets/images/address_line.png'),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text('${address.name}'),
                ),
                Expanded(
                  flex: 3,
                  child: Text('${address.mobile}'),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(top: 6, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text('${address.fullAddress}'),
          )
        ],
      ),
    );
  }

  _goods() {
    var packageList = _detailModel.packageList!;
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _buildPackageItem(packageList, index);
    }, childCount: packageList.length));
  }

  _buildPackageItem(List<PackageListItem> packageList, int index) {
    var packageListItem = packageList[index];
    List<Widget> items = [];
    var packageName = _packageName(packageListItem, index);
    items.add(packageName);

    var buildGoods = _buildGoods(packageListItem);
    items.addAll(buildGoods);
    items.add(_divider());
    return Container(
      child: Column(
        children: items,
      ),
    );
  }

  Widget _packageName(PackageListItem packageListItem, int index) {
    var orderStatus = _orderStatus(packageListItem);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '包裹${index + 1}',
              style: t14black,
            ),
          ),
          Text(
            '$orderStatus',
            style: t12red,
          ),
        ],
      ),
    );
  }

  String _orderStatus(PackageListItem packageListItem) {
    var status = packageListItem.status;
    if (status == 2) {
      return '已取消';
    }
    return '';
  }

  List<Widget> _buildGoods(PackageListItem packageListItem) {
    List<SkuListItem> skuList = packageListItem.skuList!;
    var list = skuList.map<Widget>((element) {
      return GestureDetector(
        child: _goodItem(element),
        onTap: () {
          Routers.push(
              Routers.goodDetail, context, {'id': '${element.itemId}'});
        },
      );
    }).toList();
    return list;
  }

  _goodItem(SkuListItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: lineColor, width: 0.5),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundNetImage(
            backColor: backColor,
            height: 80,
            width: 80,
            corner: 3,
            url: '${item.picUrl}',
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: t14black,
                            children: [
                              TextSpan(
                                  text: '${item.isAddBuy! ? '换购' : ''}',
                                  style: t14Yellow),
                              TextSpan(text: '${item.name ?? ''}'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'X${item.count}',
                        style: t14black,
                      )
                    ],
                  ),
                  Row(
                    children: item.specValueList!
                        .map((element) => Container(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                '$element',
                                style: t12grey,
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 10),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        '¥${item.subtotalPrice}',
                        style: t14black,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '¥${item.originPrice}',
                        style: TextStyle(
                          fontSize: 12,
                          color: textGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
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

  _orderInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Row(
            children: [
              Text(
                '订单编号:',
                style: t12grey,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  '${_detailModel.no}',
                  style: t14black,
                ),
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: textBlack, width: 0.5),
                      borderRadius: BorderRadius.circular(2)),
                  child: Text(
                    '复制',
                    style: t12black,
                  ),
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: '${_detailModel.no}'));
                  Toast.show('已复制到剪贴板', context);
                },
              )
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Text(
                '下单时间:',
                style: t12grey,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  '${Util.temFormat(_detailModel.createTime! * 1000 as int)}',
                  style: t14black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _divider(height: 1),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                'assets/images/bar_code.png',
                width: 25,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  '条形码',
                  style: t14black,
                ),
              ),
              arrowRightIcon
            ],
          )
        ],
      ),
    );
  }

  _price() {
    var redPacketVO = _detailModel.redPacketVO;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '商品合计:',
                style: t12darkGrey,
              ),
              Text(
                ' ¥${_detailModel.itemPrice}',
                style: t14black,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '邮费        :',
                style: t12darkGrey,
              ),
              Text(
                ' ¥${_detailModel.freightPrice}',
                style: t14black,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '活动优惠:',
                style: t12darkGrey,
              ),
              Text(
                ' -¥${_detailModel.activityCouponPrice}',
                style: t14black,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '优惠券    :',
                style: t12darkGrey,
              ),
              Text(
                ' -¥${_detailModel.couponPrice}',
                style: t14black,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          redPacketVO == null
              ? Container()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${redPacketVO.name}:',
                      style: t12darkGrey,
                    ),
                    Text(
                      ' -¥${redPacketVO.price}',
                      style: t14black,
                    ),
                  ],
                ),
          SizedBox(height: 10),
          _divider(height: 1),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '应付合计: ¥${_detailModel.realPrice}',
              style: t14red,
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0XFFFFFCF3),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: lineColor, width: 1)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('确认收货', style: t14black),
                  Text('${_detailModel.points}', style: t14red),
                  Text('积分', style: t14black),
                  Expanded(
                    child: Text(
                      '积分兑好礼>',
                      style: t14black,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Routers.push(Routers.mineItems, context, {'id': 6});
            },
          )
        ],
      ),
    );
  }

  _serve() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: textGrey, width: 0.5),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/kefu.png',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          '在线客服',
                          style: t14black,
                        ),
                        Text(
                          '9:00-24:00',
                          style: t12grey,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              onTap: () {
                Routers.push(Routers.webView, context, {'url': kefuUrl});
              },
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: textGrey, width: 0.5),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/call_phone_icon.png',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          '客服电话',
                          style: t14black,
                        ),
                        Text(
                          '9:00-22:00',
                          style: t12grey,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              onTap: () {
                // launch("tel://400-0368-163");
              },
            ),
          ),
        ],
      ),
    );
  }
}
