import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/sort/model/currentCategory.dart';
import 'package:flutter_app/component/my_under_line_tabindicator.dart';

typedef void IndexChange(int index);
typedef void ScrollPress(bool isScroll);

class CartTabLayout extends StatelessWidget {
  final bool isTabScroll;
  final List<CurrentCategory> subCateList;
  final IndexChange indexChange;
  final ScrollPress scrollPress;
  final TabController tabController;

  const CartTabLayout(
      {Key key,
      this.isTabScroll,
      this.subCateList,
      this.indexChange,
      this.scrollPress,
      this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTabLayout();
  }

  _buildTabLayout() {
    return Container(
      // height: 45,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: backWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: isTabScroll
          ? Container(
              decoration: BoxDecoration(
                color: backWhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x99F2F4F9),
                    blurRadius: 0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: lineColor, width: 1))),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            '全部类目',
                            style: t14blackBold,
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: Icon(Icons.keyboard_arrow_up),
                          ),
                          onTap: () {
                            if (scrollPress != null) {
                              scrollPress(!isTabScroll);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: _item(),
                  )
                ],
              ),
            )
          : Container(
              height: 45,
              width: double.infinity,
              child: Stack(
                children: [
                  _tab(),
                  Positioned(
                    width: 20,
                    right: 60,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xB3FFFFFF),
                            backWhite,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: 60,
                    child: GestureDetector(
                      child: isTabScroll
                          ? Icon(Icons.keyboard_arrow_up)
                          : Icon(Icons.keyboard_arrow_down),
                      onTap: () {
                        if (scrollPress != null) {
                          scrollPress(!isTabScroll);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Container _tab() {
    return Container(
      margin: EdgeInsets.only(right: 70),
      child: TabBar(
        controller: tabController,
        tabs: subCateList
            .map(
              (f) => Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: subCateList[tabController.index].name == f.name
                        ? backRed
                        : backWhite,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  '${f.name}',
                  style: subCateList[tabController.index].name == f.name
                      ? t14white
                      : t14black,
                ),
              ),
            )
            .toList(),
        indicator: MyUnderlineTabIndicator(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 5),
        indicatorColor: Colors.red,
        unselectedLabelColor: Colors.black,
        labelColor: Colors.red,
        isScrollable: true,
      ),
    );
  }

  // Wrap _item() {
  //   return Wrap(
  //     spacing: 20,
  //     runSpacing: 10,
  //     children: subCateList
  //         .map(
  //           (e) =>
  //           GestureDetector(
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   color: subCateList[tabController.index].id == e.id
  //                       ? backRed
  //                       : backWhite,
  //                   borderRadius: BorderRadius.circular(12)),
  //               padding: EdgeInsets.symmetric(horizontal: 10),
  //               child: Text(
  //                 '${e.name}',
  //                 style: subCateList[tabController.index].id == e.id
  //                     ? t14white
  //                     : t14black,
  //               ),
  //             ),
  //             onTap: () {
  //               if (indexChange != null) {
  //                 scrollPress(!isTabScroll);
  //                 indexChange(subCateList.indexOf(e));
  //               }
  //             },
  //           ),
  //     )
  //         .toList(),
  //   );
  // }

  _item() {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),

      ///这两个属性起关键性作用，列表嵌套列表一定要有Container
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      childAspectRatio: 3.3,
      children: subCateList
          .map(
            (e) => GestureDetector(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: subCateList[tabController.index].id == e.id
                      ? backRed
                      : backWhite,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${e.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: subCateList[tabController.index].id == e.id
                      ? t14white
                      : t14black,
                ),
              ),
              onTap: () {
                if (indexChange != null) {
                  scrollPress(!isTabScroll);
                  indexChange(subCateList.indexOf(e));
                }
              },
            ),
          )
          .toList(),
    );
  }
}
