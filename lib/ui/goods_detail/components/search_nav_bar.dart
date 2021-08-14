import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

typedef void PressIndex(int index);

class SearchNavBar extends StatelessWidget {
  final double height;
  final int index;
  final PressIndex pressIndex;
  final bool descSorted;

  const SearchNavBar(
      {Key key,
      this.height,
      this.index,
      this.pressIndex,
      this.descSorted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTops(context);
  }

  _buildTops(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
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
                  style: index == 0 ? t14red : t14black,
                ),
              ),
              onTap: () {
                if (pressIndex != null) {
                  pressIndex(0);
                }
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
                      style: index == 1 ? t14red : t14black,
                    ),
                    descSorted == null
                        ? _dftSort()
                        : (descSorted ? _dftSortDown() : _dftSortUp())
                  ],
                ),
              ),
              onTap: () {
                if (pressIndex != null) {
                  pressIndex(1);
                }
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
                  '分类',
                  style: index == 2 ? t14red : t14black,
                ),
              ),
              onTap: () {
                if (pressIndex != null) {
                  pressIndex(2);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

_dftSort() => Image.asset('assets/images/sort_dft.png', width: 14);

_dftSortUp() => Image.asset('assets/images/sort_up.png', width: 14);

_dftSortDown() => Image.asset('assets/images/sort_down.png', width: 14);
