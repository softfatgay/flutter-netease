import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/channel/installPlugin.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/home/model/versionFirModel.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:package_info/package_info.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AppVersionChecker extends StatefulWidget {
  final VersionFirModel versionFirModel;

  const AppVersionChecker({Key key, this.versionFirModel}) : super(key: key);

  @override
  _AppVersionCheckerState createState() => _AppVersionCheckerState();
}

enum VersionState { none, loading, shouldUpdate, downloading }

class _AppVersionCheckerState extends State<AppVersionChecker> {
  final TextStyle labelStyle = TextStyle(fontSize: 13);
  String oldVersion = '';
  String newVersion = '';
  int totalSize = 0;
  ValueNotifier<VersionState> versionState =
      ValueNotifier<VersionState>(VersionState.none);

  ValueNotifier<double> progress = ValueNotifier<double>(0);

  VersionFirModel versionModel;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      versionModel = widget.versionFirModel;
    });
    super.initState();
  }

  void _onReceiveProgress(int count, int total) {
    totalSize = total;
    progress.value = count / total;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${versionModel.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('有新版本(${versionModel.versionShort})更新，是否更新?'),
          SizedBox(
            height: 20,
          ),
          ValueListenableBuilder(
            valueListenable: versionState,
            builder: _buildTrailByState,
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('取消', style: t14grey),
        ),
        TextButton(
          onPressed: () {
            // Navigator.pop(context);
            checkPermission(versionModel.installUrl);
          },
          child: Text('确定', style: t14red),
        ),
      ],
    );
  }

  checkPermission(String url) async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
    ].request();
    if (permissions.values.first.isGranted) {
      _doDownload(url);
    } else {
      Toast.show('permissions denied', context);
    }
  }

  _doDownload(String url) async {
    Directory dir = await getExternalStorageDirectory();
    String dstPath =
        path.join(dir.path, 'FlutterWant-${versionModel.version}.apk');

    if (File(dstPath).existsSync()) {
      _installApk(dstPath);
      return;
    }
    versionState.value = VersionState.downloading;

    await Dio().download(url, dstPath,
        onReceiveProgress: _onReceiveProgress,
        options: Options(receiveTimeout: 24 * 60 * 60 * 1000));
    // versionState.value = VersionState.none;
    _installApk(dstPath);
  }

  _installApk(String dstPath) {
    if (Platform.isIOS) {
      InstallPlugin.gotoAppStore(dstPath);
    } else {
      InstallPlugin.installApk(dstPath, 'com.example.want');
    }
  }

  Widget _buildTrailByState(
      BuildContext context, VersionState value, Widget child) {
    switch (value) {
      case VersionState.none:
        return const SizedBox();
      case VersionState.loading:
        return const CupertinoActivityIndicator();
      case VersionState.shouldUpdate:
        return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '',
                style: TextStyle(height: 1, fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.update,
                color: Colors.green,
              )
            ]);
      case VersionState.downloading:
        return ValueListenableBuilder(
            valueListenable: progress, builder: _buildProgress);
    }
    return const SizedBox();
  }

  Widget _buildProgress(BuildContext context, double value, Widget child) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              minHeight: 10,
              backgroundColor: Colors.grey,
              value: value,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${convertFileSize((totalSize * value).floor())}/${convertFileSize(totalSize)}',
            style: t12grey,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${(value * 100).toStringAsFixed(0)} %',
            style: t14blackBold,
          ),
          const SizedBox(
            width: 15,
          ),
        ]);
  }

  static String convertFileSize(int size) {
    if (size == null) return '0 kb';
    double result = size / 1024.0;
    if (result < 1024) {
      return "${result.toStringAsFixed(2)}Kb";
    } else if (result > 1024 && result < 1024 * 1024) {
      return "${(result / 1024).toStringAsFixed(2)}Mb";
    } else {
      return "${(result / 1024 / 1024).toStringAsFixed(2)}Gb";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    versionState.dispose();
    progress.dispose();
    super.dispose();
  }
}
