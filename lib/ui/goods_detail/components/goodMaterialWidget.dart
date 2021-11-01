import 'package:flutter/material.dart';
import 'package:flutter_app/component/dashed_decoration.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';

class GoodMaterialWidget extends StatelessWidget {
  final List<AttrListItem>? attrList;

  const GoodMaterialWidget({Key? key, this.attrList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return attrList == null
        ? Container()
        : Column(
            children: attrList!
                .map((item) => Container(
                      color: backWhite,
                      child: Container(
                        decoration: DashedDecoration(
                            dashedColor: textGrey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0))),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text('${item.attrName}'),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '${item.attrValue}',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          );
  }
}
