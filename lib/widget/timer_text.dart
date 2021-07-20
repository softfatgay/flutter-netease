import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constant/fonts.dart';

class TimerText extends StatefulWidget {
  final int time;
  final String tips;
  final TextStyle textStyle;

  const TimerText(
      {Key key, this.time = 0, this.tips = '', this.textStyle = t14white})
      : super(key: key);

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
        '${widget.tips}$dataTime',
        style: widget.textStyle,
      ),
    );
  }

  //时间转换 将秒转换为小时分钟
  String _durationTransform(int seconds) {
    if (seconds == 0) {
      return '';
    }
    var d = Duration(seconds: seconds);
    String timeStr = d.toString();
    List<String> timeArr = timeStr.split('.');
    List<String> parts = timeArr[0].split(':');
    print(timeStr);

    if (seconds >= 86400) {
      return '${num.parse(parts[0]) ~/ 24}天${num.parse(parts[0]) % 24}小时';
    } else if (seconds > 3600 && seconds < 86400) {
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
