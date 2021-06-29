import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/mine/model/red_package_mode.dart';
import 'package:flutter_app/utils/util_mine.dart';

class PackageItemWidget extends StatefulWidget {
  final PackageItem packageItem;
  final int searchType;

  const PackageItemWidget({Key key, this.packageItem, this.searchType})
      : super(key: key);

  @override
  _PackageItemWidgetState createState() => _PackageItemWidgetState();
}

class _PackageItemWidgetState extends State<PackageItemWidget> {
  PackageItem _packageItem;
  bool _isScroll = false;
  int _searchType = 1;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _packageItem = widget.packageItem;
      _searchType = widget.searchType;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: _searchType == 1 ? Color(0xFFF08884) : Color(0xFFA5AAB6),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            _packageItem.name,
            style: t14white,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_packageItem.price}',
                style: TextStyle(color: textWhite, fontSize: 28, height: 1.1),
              ),
              Text(
                '元',
                style: TextStyle(color: textWhite, fontSize: 14, height: 1.1),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${Util.long2date(_packageItem.validStartTime * 1000)}-${Util.long2date(_packageItem.validEndTime * 1000)}',
            style: TextStyle(color: textWhite, fontSize: 10),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
              style: TextStyle(color: textWhite),
              maxLines: 1,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '满${_packageItem.condition}元可用：${_packageItem.rule}',
                style: TextStyle(color: textWhite),
                maxLines: _isScroll ? 10 : 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // GestureDetector(
          //   child: Icon(Icons.keyboard_arrow_down_sharp),
          //   onTap: () {
          //     setState(() {
          //       this._isScroll = !_isScroll;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
