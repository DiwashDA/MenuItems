import 'package:flutter/material.dart';
import 'package:menu_items/models/data_model.dart';
import 'package:provider/provider.dart';

class ItemNotifier extends ChangeNotifier {
  List<ItemModel> itemData = [];

  itemChange(List<ItemModel> data) {
    itemData = data;
    notifyListeners();
  }
}
