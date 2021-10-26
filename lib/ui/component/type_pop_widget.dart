import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';

typedef void SelectedIndex(int index);

class TypePopWidget extends StatelessWidget {
  final List<CategoryL1Item?> categoryList;
  final int selectIndex;
  final SelectedIndex selectedIndex;

  const TypePopWidget(
      {Key? key,
      this.categoryList = const [],
      this.selectIndex = 0,
      required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: double.infinity,
      color: backWhite,
      child: Wrap(
        children: categoryList
            .map(
              (item) => GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selectIndex == categoryList.indexOf(item)
                              ? textRed
                              : textGrey,
                          width: 1),
                      borderRadius: BorderRadius.circular(3)),
                  child: Text(
                    '${item!.name}',
                    style: selectIndex == categoryList.indexOf(item)
                        ? t12red
                        : t12black,
                  ),
                ),
                onTap: () {
                  selectedIndex(categoryList.indexOf(item));
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
