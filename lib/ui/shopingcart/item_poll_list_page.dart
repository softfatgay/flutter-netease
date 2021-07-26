import 'package:flutter/material.dart';

class ItemPollListPage extends StatefulWidget {
  const ItemPollListPage({Key key}) : super(key: key);

  @override
  _ItemPollListPageState createState() => _ItemPollListPageState();
}

class _ItemPollListPageState extends State<ItemPollListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [],
      ),
    );
  }
}
