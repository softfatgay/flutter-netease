import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/slivers.dart';

class RedPacketList extends StatefulWidget {

  final int searchType;

  const RedPacketList({Key key, this.searchType}) : super(key: key);

  @override
  _RedEnvelopeListState createState() => _RedEnvelopeListState();
}

class _RedEnvelopeListState extends State<RedPacketList> {

  int _page = 1;
  int _size = 20;


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildItems(context)
      ],
    );
  }

  Widget _buildItems(BuildContext context) {
    return SliverPadding(padding: EdgeInsets.all(10),
      sliver: SliverGrid.count(crossAxisCount: 2,children: [],),);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }
   _getData() async{

     Map<String, dynamic> header = {
       "Cookie": cookie,
       "csrf_token": csrf_token,
     };
     Map<String, dynamic> params = {
       "searchType": widget.searchType,
       "page": _page,
       "size": _size,
     };

     redPacket(params, header: header).then((responseData) {
       setState(() {
         print(responseData.data);
       });
     });
  }
}
