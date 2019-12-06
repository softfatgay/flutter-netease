/*
 * @Description: 垂直切换的Tab
 * @Author: luoguoxiong
 * @Date: 2019-08-26 17:29:18
 */
import 'package:flutter/material.dart';

const double opWidth = 100.0;

const tabItemHeight = 50.0;

const indexColor = Colors.green;

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
                color: index == _currentIndex ? Colors.green : Colors.black87,
                letterSpacing: 2,
                fontSize: index == _currentIndex ? 16 : 14),
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
      width: opWidth,
      height: double.infinity,
      color: Colors.white,
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
                    top: -_scrollY + _currentIndex * 50,
                    child: Container(
                      height: tabItemHeight,
                      width: 4,
                      color: indexColor,
                    ))
              ],
            )
          : null,
    );
  }
}
