import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menu_items/models/data_model.dart';
import 'package:menu_items/services/database_services.dart';
import 'package:provider/provider.dart';

class ItemNotifier extends ChangeNotifier {
  List<ItemModel> itemData = [];
  DatabaseServices ds = DatabaseServices();

  getAllData() async {
    List<ItemModel> data = await ds.getAllItems();
    itemChange(data);
  }

  addProduct(ItemModel item, File image) {
    ds.addItem(item, image);
    notifyListeners();
  }

  getByCategory(String category) async {
    List<ItemModel> data = await ds.getItemsbyCategory(category);
    itemChange(data);
  }

  itemChange(List<ItemModel> data) {
    itemData = data;
    notifyListeners();
  }
}
