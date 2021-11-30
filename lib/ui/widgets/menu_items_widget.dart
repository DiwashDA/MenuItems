import 'package:flutter/material.dart';
import 'package:menu_items/constants/themes.dart';
import 'package:menu_items/models/data_model.dart';

class MenuItem extends StatelessWidget {
  MenuItem(this.item, {Key? key}) : super(key: key);
  ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          width: 300,
          height: 250,
          child: Stack(
            children: [
              Positioned(
                left: 50,
                right: 50,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                  height: 200,
                  decoration: BoxDecoration(
                      color: Themes.menuItemBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 4)),
                  child: Center(
                    child: Text(
                      item.name ?? "",
                      style: Themes.menuItemsTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1,
                right: 1,
                top: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(item.image ?? ""),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
