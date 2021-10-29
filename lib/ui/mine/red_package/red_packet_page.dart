import 'package:flutter/material.dart';
import 'package:flutter_app/ui/mine/red_package/red_packet_list_page.dart';
import 'package:flutter_app/component/tab_app_bar.dart';

class RedPacketPage extends StatefulWidget {
  @override
  _RedEnvelopeState createState() => _RedEnvelopeState();
}

class _RedEnvelopeState extends State<RedPacketPage>
    with TickerProviderStateMixin {
  late TabController _controller;

  List _tabs = [
    {
      'name': '未使用',
      'searchType': 1,
    },
    {
      'name': '已使用',
      'searchType': 2,
    },
    {
      'name': '已失效',
      'searchType': 3,
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: _tabs.length, vsync: this);
  }

  _buildBody(BuildContext context) {
    return TabBarView(
      children: _tabs.map((item) {
        return RedPacketListPage(
          searchType: item['searchType'],
        );
      }).toList(),
      controller: _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        tabs: _tabs.map<String?>((e) => e['name']).toList(),
        title: '红包',
        scrollable: false,
        controller: _controller,
      ).build(context),
      body: _buildBody(context),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
