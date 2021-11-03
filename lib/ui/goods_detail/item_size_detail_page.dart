import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/goods_detail/model/itemSizeDetailModel.dart';
import 'package:flutter_app/ui/router/router.dart';

class ItemSizeDetailPage extends StatefulWidget {
  final Map? params;

  const ItemSizeDetailPage({Key? key, this.params}) : super(key: key);

  @override
  _ItemSizeDetailPageState createState() => _ItemSizeDetailPageState();
}

class _ItemSizeDetailPageState extends State<ItemSizeDetailPage> {
  late num _itemId;

  late ItemSizeDetailModel _detailModel;
  bool _isLoading = true;

  String _mineSizeTitle = '';
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _itemId = widget.params!['id'] ?? 0;
    });
    super.initState();

    _querySizeList(null);
  }

  _querySizeList(num? roleId) async {
    var responseData =
        await getSizeDetail({'itemId': _itemId, 'roleId': roleId});
    if (responseData.code == '200') {
      setState(() {
        _detailModel = ItemSizeDetailModel.fromJson(responseData.data);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '尺码详情',
      ).build(context),
      body: _isLoading ? Loading() : _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _switchSize(),
          _mineSize(),
          _goodSizeTitle(),
          _goodDetailSize(),
        ],
      ),
    );
  }

  _switchSize() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 20,
        left: 15,
      ),
      child: GestureDetector(
        child: Text(
          '切换角色>>',
          style: t14black,
        ),
        onTap: () {
          Routers.push(Routers.userInfoPageIndex, context,
              {'id': 2, 'from': Routers.itemSizeDetailPage}, (value) {
            if (value != null) {
              _querySizeList(value.id);
            }
          });
        },
      ),
    );
  }

  _mineSize() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 75,
            decoration: BoxDecoration(
                color: Color(0xFFFFFCED),
                border: Border.all(color: lineColor, width: 0.5)),
            alignment: Alignment.center,
            child: Text(
              '${_detailModel.roleName}',
              style: t14black,
            ),
          ),
          Expanded(
            child: Column(
              children: _detailModel.roleSizeValueList!
                  .map<Widget>((e) => _mineSizeColumn(e))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  _mineSizeColumn(List<String> list) {
    return Container(
      height: 40,
      child: Row(
        children: list
            .map((e) => Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: lineColor, width: 0.5)),
                    alignment: Alignment.center,
                    child: Text('$e'),
                  ),
                ))
            .toList(),
      ),
    );
  }

  _goodSizeTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 15, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text('${_detailModel.name}'),
    );
  }

  _goodDetailSize() {
    return Column(
      children: _detailModel.itemSizeValueList!
          .map<Widget>(
            (e) => Container(
              height: 50,
              child: Row(
                children: e
                    .map<Widget>((item) => Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: lineColor, width: 0.5)),
                            alignment: Alignment.center,
                            child: Text(
                              '${item.replaceAll('<br/>', '\n')}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }
}
