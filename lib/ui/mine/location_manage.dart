import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

///地址管理
class LocationManage extends StatefulWidget {
  @override
  _LocationManageState createState() => _LocationManageState();
}

class _LocationManageState extends State<LocationManage> {
  var _locationList = List();
  int addressId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        controller: null,
        tabs: [],
        title: '地址管理',
      ).build(context),
      body: Column(
        children: [
          Expanded(
            child: _locations(context),
          ),
          _addAddress(context)
        ],
      ),
    );
  }

  _locations(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildItem(context, index);
      },
      itemCount: _locationList.length,
    );
  }

  _buildItem(BuildContext context, int index) {
    var item = _locationList[index];

    Widget widget = Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: backGrey, width: 1))),
        padding: EdgeInsets.fromLTRB(0, 20, 15, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        '${item['name']}',
                        style: t16black,
                      ),
                    ),
                    item['dft'] == true
                        ? Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: redColor),
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              item['dft'] == true ? '默认' : '',
                              style: t12red,
                            ),
                          )
                        : Container(
                            width: 45,
                          )
                  ],
                )),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 6),
                    child: Text(
                      '${item['mobile']}',
                      style: t16black,
                    ),
                  ),
                  Text(
                    '${item['fullAddress']}',
                    style: t14grey,
                  )
                ],
              ),
            ),
            IconButton(
                icon: Image.asset(
                  'assets/images/delete.png',
                  width: 22,
                  height: 22,
                ),
                onPressed: () {
                  setState(() {
                    addressId = item['id'];
                  });
                  _confimDialog(context);
                })
          ],
        ),
      ),
    );

    return Routers.link(widget, Routers.addAddress, context, item, () {
      _getLocations();
    });
  }

  void _getLocations() async {
    Map<String, dynamic> params = {"csrf_token": csrf_token};
    Map<String, dynamic> header = {"Cookie": cookie};

    var responseData = await getLocationList(params, header: header);
    setState(() {
      _locationList = responseData.data;
    });
  }

  void _deleteAddress() async {
    Map<String, dynamic> params = {"csrf_token": csrf_token, 'id': addressId};
    Map<String, dynamic> header = {"Cookie": cookie};

    await deleteAddress(params, header: header).then((value) {
      _getLocations();
    });
  }

  _confimDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(('确定删除该地址？')),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("取消"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("确定"),
                  onPressed: () {
                    _deleteAddress();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  _addAddress(BuildContext context) {
    Widget widget = Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: backGrey,
          border: Border.all(color: redColor, width: 0.5),
          borderRadius: BorderRadius.circular(2)),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: redColor,
            size: 14,
          ),
          Text(
            '新建地址',
            style: t16red,
          )
        ],
      ),
    );
    return Routers.link(widget, Routers.addAddress, context, null, () {
      _getLocations();
    });
  }
}
