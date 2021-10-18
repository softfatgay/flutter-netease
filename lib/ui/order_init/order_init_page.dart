import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/slivers.dart';

class OrderInitPage extends StatefulWidget {
  final Map? params;

  const OrderInitPage({Key? key, this.params}) : super(key: key);

  @override
  _OrderInitPageState createState() => _OrderInitPageState();
}

class _OrderInitPageState extends State<OrderInitPage> {
  var _postdata;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _postdata = widget.params!['data'];
    });
    super.initState();
    _initData();
  }

  void _initData() async {
    var param = {
      'skuId': 0,
      'count': 0,
      'purchaseType': 1,
      'scene': 2,
      'orderId': 0,
      'layawayId': 0,
      'incognito': 0,
      // 'transactionId': '3_176309080_1623827671297_2865_0',
      'orderCart': _postdata
    };
    var responseData = await orderInit(param);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '提交订单',
      ).build(context),
      body: CustomScrollView(
        slivers: [singleSliverWidget(_buildBody())],
      ),
    );
  }

  _buildBody() {
    return Column(
        // children: [_buildAddressData()],
        );
  }

// _buildAddressData() {
//   Widget component = Container(
//     color: Colors.white,
//     padding: EdgeInsets.only(left: 15),
//     child: Container(
//       decoration: BoxDecoration(
//           border: Border(bottom: BorderSide(color: backGrey, width: 1))),
//       padding: EdgeInsets.fromLTRB(0, 20, 15, 20),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//               flex: 1,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(bottom: 6),
//                     child: Text(
//                       '${item['name']}',
//                       style: t16black,
//                     ),
//                   ),
//                   item['dft'] == true
//                       ? Container(
//                           margin: EdgeInsets.only(right: 10),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 5, vertical: 0),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: redColor),
//                               borderRadius: BorderRadius.circular(2)),
//                           child: Text(
//                             item['dft'] == true ? '默认' : '',
//                             style: t12red,
//                           ),
//                         )
//                       : Container(
//                           width: 45,
//                         )
//                 ],
//               )),
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(bottom: 6),
//                   child: Text(
//                     '${item['mobile']}',
//                     style: t16black,
//                   ),
//                 ),
//                 Text(
//                   '${item['fullAddress']}',
//                   style: t14grey,
//                 )
//               ],
//             ),
//           ),
//           IconButton(
//               icon: Image.asset(
//                 'assets/images/delete.png',
//                 width: 22,
//                 height: 22,
//               ),
//               onPressed: () {
//                 setState(() {
//                   addressId = item['id'];
//                 });
//                 _confimDialog(context);
//               })
//         ],
//       ),
//     ),
//   );
//
//   return Routers.link(component, Util.addAddress, context, item, () {
//     _getLocations();
//   });
// }
}
