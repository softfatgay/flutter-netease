/*
 * @Description: 广告页
 * @Author: luoguoxiong
 * @Date: 2019-08-26 17:29:18
 */
import 'package:flutter/material.dart';

class OpenAd extends StatelessWidget {
  OpenAd(this.time);

  final int time;

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/launch.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 30,
            right: 10,
            child: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 59, 70, 88),
                borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
              ),
              child: Center(
                child: Text(
                  '$time S',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
