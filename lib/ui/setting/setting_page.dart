import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/home/model/versionModel.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/arrow_icon.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  Map arguments;

  SettingPage({this.arguments});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String appName;
  String packageName;
  String version = '';
  String buildNumber;

  final List itemList = [
    _ItemList(Icon(Icons.android, color: Colors.blue), '版本', 0),
    _ItemList(Icon(Icons.info_outline, color: Colors.blue), '关于', 1),
    _ItemList(Icon(Icons.info_outline, color: Colors.blue), '检查更新', 2),
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
      appBar: TopAppBar(
        title: '关于',
      ).build(context),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 15),
              color: backWhite,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: lineColor, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: index == 0
                            ? Text('${itemList[index].name} $version')
                            : Text('${itemList[index].name}'),
                      ),
                    ),
                    arrowRight,
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              if (index == 0) {
                _showPackInfo(context);
              } else if (index == 1) {
                Routers.push(Routers.setting, context, {'id': 0});
              } else if (index == 2) {
                _checkVersion();
              }
            },
          );
        },
        itemCount: itemList.length,
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
                  child: Text('版本：        $version'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('版本号：    $buildNumber'),
                ),
              ],
            ));
  }

  void _checkVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    var param = {
      '_api_key': '5fd74f41bc1842bb97b3f62859937b34',
      'buildVersion': packageInfo.version,
      'appKey': '86f30c074e0db173411dfe6369ba818b',
    };

    var responseData = await checkVersion(param);
    if (responseData.code == 0) {
      var data = responseData.data;
      var versionModel = VersionModel.fromJson(data);
      if (packageInfo.version != versionModel.buildVersion) {
        _versionDialog(versionModel);
      } else {
        Toast.show('已是最新版本', context);
      }
    }
  }

  void _versionDialog(VersionModel versionModel) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${versionModel.buildName}'),
            content: Text('有新版本更新，是否更新?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消', style: t14grey),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  _launchURL(versionModel.downloadURL);
                },
                child: Text('确定', style: t14red),
              ),
            ],
          );
        });
  }

  _launchURL(apkUrl) async {
    if (await canLaunch(apkUrl)) {
      await launch(apkUrl);
    } else {
      throw 'Could not launch $apkUrl';
    }
  }
}

class _ItemList {
  Icon icon;
  String name;
  int id;

  _ItemList(this.icon, this.name, this.id);
}
