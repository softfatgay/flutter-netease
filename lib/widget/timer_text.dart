import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constant/fonts.dart';

class TimerText extends StatefulWidget {
  final int time;

  const TimerText({Key key, this.time = 0}) : super(key: key);

  @override
  _TimerTextState createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  int data = 0;
  Timer _timer;
  String dataTime = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.time;

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (data > 0) {
          data -= 1;
          dataTime = _durationTransform(data);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '付款$dataTime',
        style: t14white,
      ),
    );
  }

  //时间转换 将秒转换为小时分钟
  String _durationTransform(int seconds) {
    if (seconds == 0) {
      return '';
    }
    var d = Duration(seconds: seconds);
    print(d.toString());
    String timeStr = d.toString();
    List<String> timeArr = timeStr.split('.');
    List<String> parts = timeArr[0].split(':');
    if (seconds >= 3600) {
      return '${parts[0]}:${parts[1]}:${parts[2]}';
    } else if (seconds < 3600 && seconds >= 60) {
      return '${parts[1]}:${parts[2]}';
    } else {
      return '${parts[2]}';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }
}
