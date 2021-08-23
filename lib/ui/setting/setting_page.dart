import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/home/model/versionFirModel.dart';
import 'package:flutter_app/ui/mine/check_info.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/toast.dart';
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
                  border: index == 2
                      ? null
                      : Border(bottom: BorderSide(color: lineColor, width: 1)),
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
                    arrowRightIcon,
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
    // var packageInfo = await PackageInfo.fromPlatform();
    // var param = {
    //   '_api_key': pgy_api_key,
    //   'buildVersion': packageInfo.version,
    //   'appKey': pgy_appKey,
    // };
    //
    //
    //
    // var responseData = await checkVersion(param);
    // if (responseData.code == 0) {
    //   var data = responseData.data;
    //   var versionModel = VersionModel.fromJson(data);
    //   if (packageInfo.version != versionModel.buildVersion) {
    //   }
    // }
    var packageInfo = await PackageInfo.fromPlatform();
    var paramFir = {
      'api_token': '68c6b9bc36bc9cfd3572dd1c903cb176',
    };
    var responseData = await lastVersionFir(paramFir);
    try {
      var versionFirModel = VersionFirModel.fromJson(responseData.OData);
      if (packageInfo.version != versionFirModel.versionShort) {
        _versionDialog(versionFirModel);
      } else {
        Toast.show('已经是最新版本', context);
      }
    } catch (e) {}
  }

  void _versionDialog(VersionFirModel versionModel) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AppVersionChecker(
            versionFirModel: versionModel,
          );
        });
  }
}

class _ItemList {
  Icon icon;
  String name;
  int id;

  _ItemList(this.icon, this.name, this.id);
}
