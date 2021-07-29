import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/widget/my_under_line_tabindicator.dart';

typedef void BackPress();

class TopAppBar extends StatelessWidget {
  final String title;
  final bool closeIcon;
  final BackPress backPress;

  const TopAppBar({Key key, this.title, this.closeIcon = false, this.backPress})
      : super(key: key);

  Widget buildAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
        child: Row(
          children: <Widget>[
            InkResponse(
              child: Container(
                width: 50,
                child: Image.asset(
                  'assets/images/back.png',
                  height: 25,
                ),
              ),
              onTap: () {
                if (backPress != null) {
                  backPress();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            closeIcon
                ? InkResponse(
                    child: Container(
                      child: Center(
                        child:
                            Image.asset('assets/images/close.png', width: 20),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                : Container(),
            Expanded(
              child: Center(
                child: Text(
                  title == null ? '' : title,
                  style: t16black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: 50,
            ),
          ],
        ),
      ),
    );
  }

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      child: buildAppBar(context),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        50,
      ),
    );
  }
}
