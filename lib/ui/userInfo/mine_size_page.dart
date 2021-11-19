import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/userInfo/model/sizeItemModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/button_widget.dart';

class MineSizePage extends StatefulWidget {
  final Map? params;

  const MineSizePage({Key? key, this.params}) : super(key: key);

  @override
  _MineSizePageState createState() => _MineSizePageState();
}

class _MineSizePageState extends State<MineSizePage> {
  List<SizeItemModel> _dataList = [];

  String? _from;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.params != null) {
      _from = widget.params!['from'];
    }
    super.initState();
    _mineSizeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backWhite,
      appBar: TopAppBar(
        title: '我的尺码',
      ).build(context),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 65 + MediaQuery.of(context).padding.bottom,
            child: _buildList(),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 0,
            right: 0,
            child: Container(
              color: backWhite,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: NormalBtn('新增', backRed, () {
                Routers.push(Routers.addNewSize, context);
              }, corner: 4),
            ),
          ),
        ],
      ),
    );
  }

  _buildList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildSizeItem(index);
      },
      itemCount: _dataList.length,
    );
  }

  void _mineSizeList() async {
    var responseData = await mineSize();
    if (mounted) {
      var data = responseData.data;
      List<SizeItemModel> dataList = [];
      data.forEach((element) {
        dataList.add(SizeItemModel.fromJson(element));
      });
      setState(() {
        _dataList = dataList;
      });
    }
  }

  _buildSizeItem(int index) {
    var item = _dataList[index];
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: item.dft!
              ? Border(left: BorderSide(color: backRed, width: 3))
              : null,
          color: item.dft! ? Color(0xFFFFFCED) : backWhite,
        ),
        padding: EdgeInsets.only(left: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: lineColor, width: 1)),
          ),
          padding: EdgeInsets.fromLTRB(0, 15, 10, 15),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Text('${item.roleName}', style: t16black),
                    _isDrf(item),
                    Expanded(child: Container()),
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/edit_icon.png',
                        width: 20,
                        height: 20,
                      ),
                      onTap: () {
                        Routers.push(
                            Routers.addNewSize, context, {'id': item.id},
                            (valueBack) {
                          _mineSizeList();
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text('性别', style: t12black),
                  SizedBox(width: 40),
                  Text('${_sex(item.gender)}', style: t12black),
                ],
              ),
              _rowItem('身高(cm)', '${_reSize(item.height)}', '体重(kg)',
                  '${_reSize(item.bodyWeight)}'),
              _rowItem('腰围(cm)', '${_reSize(item.waistCircumference)}',
                  '臀围(cm)', '${_reSize(item.hipCircumference)}'),
              _rowItem('脚长(cm)', '${_reSize(item.footLength)}', '脚围(cm)',
                  '${_reSize(item.footCircumference)}'),
              _rowItem('肩宽(cm)', '${_reSize(item.shoulderBreadth)}', '胸围(cm)',
                  '${_reSize(item.bust)}'),
              item.underBust == -1
                  ? Container()
                  : _rowItem('下胸围(cm)', '${_reSize(item.underBust)}', '', ''),
            ],
          ),
        ),
      ),
      onTap: () {
        if (_from != null) {
          Navigator.pop(context, item);
        }
      },
    );
  }

  _sex(num? type) {
    if (type == 2) {
      return '女';
    } else if (type == 1) {
      return '男';
    } else {
      return '儿童';
    }
  }

  _reSize(num? size) {
    if (size == -1 || size == null) {
      return '--';
    }
    return size;
  }

  _rowItem(String lTitle, String lValue, String rTitle, String rValue) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _item('$lTitle'),
          ),
          Expanded(
            flex: 2,
            child: _item('$lValue'),
          ),
          Expanded(
            flex: 1,
            child: _item('$rTitle'),
          ),
          Expanded(
            flex: 2,
            child: _item('$rValue'),
          ),
        ],
      ),
    );
  }

  _isDrf(item) {
    return item.dft
        ? Container(
            margin: EdgeInsets.only(left: 5),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            decoration: BoxDecoration(
                border: Border.all(color: redColor),
                borderRadius: BorderRadius.circular(2)),
            child: Text(
              item.dft ? '默认' : '',
              style: t12red,
            ),
          )
        : Container();
  }

  _item(String tabTitle) {
    return Text(
      '$tabTitle',
      style: t12black,
    );
  }
}
