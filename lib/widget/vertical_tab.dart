import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

const double opWidth = 90;

const tabItemHeight = 45.0;

const indexColor = textRed;

class VerticalTab extends StatefulWidget {
  VerticalTab({Key key, this.tabs, this.onTabChange, this.activeIndex});

  final List<String> tabs;

  final ValueChanged<int> onTabChange;

  final int activeIndex;

  @override
  State<StatefulWidget> createState() {
    return _VerticalTab();
  }
}

class _VerticalTab extends State<VerticalTab> {
  double _scrollY = 0;

  int _currentIndex = 0;
  ScrollController _controller = new ScrollController();

  bool isTap = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (isTap) {
        setState(() {
          isTap = false;
          _scrollY = _controller.offset;
        });
      } else {
        setState(() {
          _scrollY = _controller.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildTabItem(item, index) {
    return InkResponse(
      onTap: () {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
            isTap = true;
            widget.onTabChange(index);
          });
        }
      },
      child: Container(
        width: opWidth,
        height: tabItemHeight,
        child: Center(
          child: Text(
            '$item',
            style: TextStyle(
                color: index == _currentIndex ? textRed : textBlack,
                letterSpacing: 1,
                fontSize: index == _currentIndex ? 14 : 14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabList = List<Widget>(widget.tabs.length);
    for (var i = 0; i < widget.tabs.length; i++) {
      tabList[i] = buildTabItem(widget.tabs[i], i);
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: splitLineColor),
        color: Colors.white,
      ),
      width: opWidth,
      height: double.infinity,
      child: tabList.isNotEmpty
          ? Stack(
              children: <Widget>[
                Positioned(
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      children: tabList,
                    ),
                  ),
                ),
                AnimatedPositioned(
                    duration: Duration(milliseconds: isTap ? 100 : 0),
                    top: -_scrollY +
                        _currentIndex * tabItemHeight +
                        tabItemHeight / 4,
                    child: Container(
                      alignment: Alignment.center,
                      height: tabItemHeight / 2,
                      width: 2,
                      color: indexColor,
                    ))
              ],
            )
          : null,
    );
  }
}
