import 'package:flutter/material.dart';
import 'package:flutter_app/utils/flutter_activity.dart';

class ShoppingMarket extends StatefulWidget {
  @override
  _ShoppingMarketState createState() => _ShoppingMarketState();
}

class _ShoppingMarketState extends State<ShoppingMarket> {
  String dialog = "dialog";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      child: Center(
        child: Column(
          children: <Widget>[
             RaisedButton(
              child: Text('跳转原生activity'),
              onPressed: () {
            Flutter2Activity.toActivity(Flutter2Activity.webView,
                arguments: {'url': 'https://flutterchina.club/widgets-intro/'});
              },
            ),
             RaisedButton(
              child: Text(dialog),
              onPressed: () {
                showMySimpleDialog(context);
              },
            ),
          ],
        ),
      ),
    );
    return widget;
  }

  void showMySimpleDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              new SimpleDialogOption(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Text("第一个按钮",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontSize: 18)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    dialog = '第一个按钮';

                  });
                },
              ),
              new SimpleDialogOption(
                child: Container(
                padding: EdgeInsets.all(10),
                  child: new Text("第二个按钮",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontSize: 18)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    dialog = '第二个按钮';

                  });
                },
              ),
              new SimpleDialogOption(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Text("第三个按钮",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontSize: 18),),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    dialog = '第三个按钮';
                  });
                },
              ),
            ],
          );
        });
  }

}
