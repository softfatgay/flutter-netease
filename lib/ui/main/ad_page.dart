import 'package:flutter/material.dart';

class AdPage extends StatefulWidget {
  @override
  _AState createState() => _AState();

  AdPage(this.time);

  final int time;
}

class _AState extends State<AdPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image/timg.jpg'),
        fit: BoxFit.cover,
      )),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 30,
              right: 10,
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                    color: Color.fromARGB(100, 59, 70, 88),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Center(
                  child: Text(
                    '${widget.time}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
