import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';

class QRCodeResultPage extends StatefulWidget {
  final Map? param;

  const QRCodeResultPage({Key? key, this.param}) : super(key: key);

  @override
  _QRCodeResultPageState createState() => _QRCodeResultPageState();
}

class _QRCodeResultPageState extends State<QRCodeResultPage> {
  var result;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      result = widget.param!['result'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '扫描结果',
      ).build(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Text('${result.code.toString()}'),
        ),
      ),
    );
  }
}
