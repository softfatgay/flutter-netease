import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/slivers.dart';

class PaymentPage extends StatefulWidget {
  final Map params;

  const PaymentPage({Key key, this.params}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isLoading = true;
  var _data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    List list = [];
    list.add(widget.params);

    Map<String, dynamic> cartGroupList = {'cartGroupList': list};

    Map<String, dynamic> params = {
      'count': 0,
      'purchaseType': 1,
      'scene': 1,
      'orderId': 0,
      'layawayId': 0,
      "orderCart": cartGroupList,
      "incognito": false,
    };
    var responseData = await orderInit(params);
    setState(() {
      _isLoading = false;
      _data = responseData.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '确认订单',
      ).build(context),
      body: CustomScrollView(
        slivers: [singleSliverWidget(_buildTopTips())],
      ),
    );
  }

  _buildTopTips() {}
}
