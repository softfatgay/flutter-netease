import 'package:flutter/material.dart';
import 'package:flutter_app/ui/mine/red_packet_list.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class RedPacket extends StatefulWidget {
  @override
  _RedEnvelopeState createState() => _RedEnvelopeState();
}

class _RedEnvelopeState extends State<RedPacket> with TickerProviderStateMixin {
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
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: _tabs.length, vsync: this);
  }

  _buildBody(BuildContext context) {
    return TabBarView(
      children: _tabs.map((item) {
        return RedPacketList(
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
        tabs: _tabs.map<String>((e) => e['name']).toList(),
        title: '红包',
        controller: _controller,
      ).build(context),
      body: _buildBody(context),
    );
  }
}
