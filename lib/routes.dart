import 'package:flutter/material.dart';
import 'package:menu_items/ui/home_page.dart';
import 'package:menu_items/ui/item_form.dart';

class Routes {
  static const String home = '/home';
  static const String addItem = '/addItem';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomePage(),
    addItem: (BuildContext context) => ItemForm('Add Item'),
  };
}
