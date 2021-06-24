import 'package:flutter/material.dart';
import 'package:flutter_app/ui/setting/about_page.dart';
import 'package:flutter_app/utils/flutter_activity.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:package_info/package_info.dart';

class Setting extends StatefulWidget {
  Map arguments;

  Setting({this.arguments});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String appName;
  String packageName;
  String version;
  String buildNumber;

  final List itemList = [
    _ItemList(Icon(Icons.android, color: Colors.blue), '版本', 0),
    _ItemList(Icon(Icons.info_outline, color: Colors.blue), '关于', 1),
//    _ItemList(Icon(Icons.favorite, color: Colors.blue), '给我点赞', 2),
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
        tabs: [],
        title: '设置',
      ).build(context),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  itemList[index].icon,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
//                Flutter2Activity.toActivity(Flutter2Activity.webView,arguments: {'url':})
              } else if (index == 2) {}
            },
          );
        },
        itemCount: itemList.length,
        separatorBuilder: (BuildContext context, int index) => index % 2 == 0
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  height: 1,
                  color: Colors.blue,
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  height: 1,
                  color: Colors.green,
                ),
              ),
      ),
    );
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
