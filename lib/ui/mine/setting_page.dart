import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/button_widget.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:package_info/package_info.dart';

class SettingPage extends StatefulWidget {
  Map arguments;

  SettingPage({this.arguments});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String appName;
  String packageName;
  String version;
  String buildNumber;

  final List itemList = [
    _ItemList(Icon(Icons.android, color: Colors.blue), '版本', 0),
    _ItemList(Icon(Icons.info_outline, color: Colors.blue), '关于', 1),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appName = packageInfo.appName;
        packageName = packageInfo.packageName;
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TabAppBar(
          title: '关于',
        ).build(context),
        body: Container(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: lineColor, width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: index == 0
                              ? Text('${itemList[index].name + version}')
                              : Text('${itemList[index].name}'),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  if (index == 0) {
                    _showPackInfo(context);
                  } else if (index == 1) {
                    Routers.push(Routers.setting, context, {'id': 0});
                  }
                },
              );
            },
            itemCount: itemList.length,
          ),
        ));
  }

  _showPackInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('app名称：  $appName'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('包名：        $packageName'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('构建版本： $buildNumber'),
                ),
              ],
            ));
  }
}

class _ItemList {
  Icon icon;
  String name;
  int id;

  _ItemList(this.icon, this.name, this.id);
}
