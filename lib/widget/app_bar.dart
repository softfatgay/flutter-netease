import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  final String title;
  final Color backcolor;

  const Appbar({Key key, this.title, this.backcolor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new Container(
        child: Row(
          children: <Widget>[
            InkResponse(
              child: Container(
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: backcolor ?? Colors.black,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Container(
              width: 50,
            ),
          ],
        ),
        height: 50,
      ),
    );
  }
}
