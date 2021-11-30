import 'package:flutter/material.dart';
import 'package:menu_items/constants/themes.dart';
import 'package:menu_items/models/data_model.dart';
import 'package:menu_items/providers/item_notifier.dart';
import 'package:menu_items/services/database_services.dart';
import 'package:menu_items/ui/item_form.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<String> menuItems = [
    "Main Page",
    "Snacks",
    "Dessert",
    "Drinks",
    "Food",
  ];

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
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  currentIndex = index;
                  List<ItemModel> data = index == 0
                      ? await DatabaseServices().getAllItems()
                      : await DatabaseServices()
                          .getItemsbyCategory(menuItems[index]);
                  Provider.of<ItemNotifier>(context, listen: false)
                      .itemChange(data);
                },
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          border: currentIndex == index
                              ? Border.all(color: Colors.white, width: 3)
                              : Border.all(color: Colors.transparent),
                          shape: BoxShape.circle,
                          gradient: Themes.menuGradient),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menuItems[index],
                      style: Themes.menuLabelStyle,
                    )
                  ],
                ),
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
        ),
      ),
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
                onTap: () {},
                child: Padding(
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
                              padding: const EdgeInsets.only(
                                  top: 80, left: 20, right: 20),
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Themes.menuItemBg,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white, width: 4)),
                              child: Center(
                                child: Text(
                                  itemNotifier.itemData[index].name??"",
                                  style: Themes.menuItemsTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 1,
                            right: 1,
                            top: 0,
                            child: Center(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(
                                    "https://www.teenaagnel.com/wp-content/uploads/2019/12/food-photography-in-dubai.jpg"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
