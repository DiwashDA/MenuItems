import 'package:flutter/material.dart';
import 'package:menu_items/constants/constants.dart';
import 'package:menu_items/constants/themes.dart';
import 'package:menu_items/models/data_model.dart';
import 'package:menu_items/providers/item_notifier.dart';
import 'package:menu_items/services/database_services.dart';
import 'package:menu_items/ui/item_form.dart';
import 'package:menu_items/ui/widgets/menu_widget.dart';
import 'package:menu_items/ui/widgets/menu_items_widget.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addItemButton(context),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 15),
        //width: double.infinity,
        decoration: const BoxDecoration(
          gradient: Themes.gradientBackground,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Welcome,",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Scroll & choose a category to explore the menu",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(
                height: 25,
              ),
              menu(),
              menuItemsBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  addItemButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/addItem');
      },
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Themes.menuItemBg,
          ),
          child: const Icon(
            Icons.add,
            size: 50,
          )),
    );
  }

  menu() {
    return SizedBox(
      height: 150,
      child: Center(
        child: ListView.builder(
          itemCount: Constants.menuItems.length,
          itemBuilder: (context, index) {
            return MenuCategory(
                index, Constants.menuItems[index], currentIndex == index, (i) {
              setState(() {
                currentIndex = i;
              });
            });
          },
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
        ),
      ),
    );
  }

  Future<void> showPrice(price) async {
    print(price);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Themes.menuItemBg,
          content: Text("The item is priced for Rs $price"),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  menuItemsBuilder() {
    return Expanded(
      child: Consumer<ItemNotifier>(builder: (context, itemNotifier, _) {
        return ListView.builder(
            padding: EdgeInsets.all(20),
            shrinkWrap: true,
            itemCount: itemNotifier.itemData.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    showPrice(itemNotifier.itemData[index].price);
                  },
                  child: MenuItem(itemNotifier.itemData[index]));
            });
      }),
    );
  }
}
