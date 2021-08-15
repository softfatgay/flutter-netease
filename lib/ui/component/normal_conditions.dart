import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/component/model/normalSearchModel.dart';

typedef void PressChange(NormalSearchModel searchModel);

class NormalConditionsBar extends StatefulWidget {
  final PressChange pressChange;
  final NormalSearchModel searchModel;

  final double height;

  const NormalConditionsBar(
      {Key key, this.height = 40, this.pressChange, this.searchModel})
      : super(key: key);

  @override
  _NormalConditionsBarState createState() => _NormalConditionsBarState();
}

class _NormalConditionsBarState extends State<NormalConditionsBar> {
  int _index = 0;
  var _normalSearchModel = NormalSearchModel();
  bool _descSorted;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.searchModel != null) {
      setState(() {
        _normalSearchModel = widget.searchModel;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: lineColor, width: 0.5)),
        color: backWhite,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                color: backWhite,
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  '综合',
                  style: _textTtyle(0),
                ),
              ),
              onTap: () {
                _pressIndex(0);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                color: backWhite,
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '价格',
                      style: _textTtyle(1),
                    ),
                    _descSorted == null
                        ? _dftSort()
                        : (_descSorted ? _dftSortDown() : _dftSortUp())
                  ],
                ),
              ),
              onTap: () {
                _pressIndex(1);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                color: backWhite,
                alignment: Alignment.center,
                child: Text(
                  '销量',
                  style: _textTtyle(5),
                ),
              ),
              onTap: () {
                _pressIndex(5);
              },
            ),
          ),
        ],
      ),
    );
  }

  _textTtyle(int index) {
    if (index == 0) {
      return _index == 0 ? t14red : t14black;
    } else if (index == 1) {
      return _index == 1 ? t14red : t14black;
    } else if (index == 5) {
      return _index == 5 ? t14red : t14black;
    }
  }

  void _pressIndex(int index) {
    if (index == 0 || index == 5) {
      if (index == _index) {
        return;
      }
    }

    setState(() {
      _index = index;
      _normalSearchModel.sortType = index;
      if (index == 0 || index == 5) {
        _descSorted = null;
      }
      if (index == 1) {
        if (_descSorted == null) {
          _descSorted = true;
        } else {
          _descSorted = !_descSorted;
        }
      }
      _normalSearchModel.descSorted = _descSorted;
    });

    if (widget.pressChange != null) {
      widget.pressChange(_normalSearchModel);
    }
  }
}

_dftSort() => Image.asset('assets/images/sort_dft.png', width: 14);

_dftSortUp() => Image.asset('assets/images/sort_up.png', width: 14);

_dftSortDown() => Image.asset('assets/images/sort_down.png', width: 14);
