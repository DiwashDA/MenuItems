import 'package:flutter/material.dart';
import 'package:menu_items/constants/themes.dart';
import 'package:menu_items/providers/item_notifier.dart';
import 'package:provider/provider.dart';

class MenuCategory extends StatelessWidget {
  MenuCategory(this.index, this.menuItem, this.hasBorder, this.onSelect) : super();
  var index;
  String menuItem;
  bool hasBorder;
  Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          onSelect(index);
          print(menuItem);
          index == 0
              ? Provider.of<ItemNotifier>(context, listen: false).getAllData()
              : Provider.of<ItemNotifier>(context, listen: false)
                  .getByCategory(menuItem);
        },
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  border: hasBorder
                      ? Border.all(color: Colors.white, width: 3)
                      : Border.all(color: Colors.transparent),
                  shape: BoxShape.circle,
                  gradient: Themes.menuGradient),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              menuItem,
              style: Themes.menuLabelStyle,
            )
          ],
        ),
      ),
    );
  }
}
