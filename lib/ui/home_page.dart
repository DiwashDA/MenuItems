import 'package:flutter/material.dart';
import 'package:menu_items/constants/themes.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final List<String> menuItems = [
    "Main Page",
    "Snacks",
    "Dessert",
    "Drinks",
    "Food",
  ];
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  menu() {
    return SizedBox(
      height: 150,
      child: Center(
        child: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, gradient: Themes.menuGradient),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${menuItems[index]}",
                    style: Themes.menuLabelStyle,
                  )
                ],
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
      child: ListView.builder(
          padding: EdgeInsets.all(20),
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (context, index) {
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
                          padding: const EdgeInsets.only(
                              top: 80, left: 20, right: 20),
                          height: 200,
                          decoration: BoxDecoration(
                              color: Themes.menuItemBg,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.white, width: 4)),
                          child: const Center(
                            child: Text(
                              "Burger And Fries",
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
            );
          }),
    );
  }
}
