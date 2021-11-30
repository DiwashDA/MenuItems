import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:menu_items/models/data_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DatabaseServices {
  addItem(ItemModel item, image) async {
    CollectionReference items = FirebaseFirestore.instance.collection('data');
    var url = await uploadFile(image);
    Map<String, dynamic> data = {
      "name": "${item.name}",
      "description": "${item.description}",
      "image": "$url",
      "category": "${item.category}",
      "price": "${item.price}"
    };
    var res = await items.add(data);
  }

  Future<List<ItemModel>> getAllItems() async {
    List<ItemModel> itemList = [];
    try {
      await Firebase.initializeApp();
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('data').get();
      itemList = querySnapshot.docs.map<ItemModel>((doc) {
        return ItemModel(
            name: doc["name"],
            category: doc["category"],
            description: doc["description"],
            image: doc["image"],
            price: doc["price"]);
      }).toList();
      return itemList;
    } catch (e) {
      throw "ERROR";
    }
  }

  Future<List<ItemModel>> getItemsbyCategory(category) async {
    List<ItemModel> itemList = [];
    try {
      await Firebase.initializeApp();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('data')
          .where("category", isEqualTo: category)
          .get();
      itemList = querySnapshot.docs.map<ItemModel>((doc) {
        return ItemModel(
            name: doc["name"],
            category: doc["category"],
            description: doc["description"],
            image: doc["image"],
            price: doc["price"]);
      }).toList();
      return itemList;
    } catch (e) {
      throw "ERROR";
    }
  }

  // updateItems(id) async {
  //   await Firebase.initializeApp();
  //
  //   CollectionReference items = FirebaseFirestore.instance.collection('data');
  //   items.doc(id).update({});
  // }
  //
  // deleteItems(id) async {
  //   CollectionReference items = FirebaseFirestore.instance.collection('data');
  //   items.doc(id).delete();
  // }

  Future<String> uploadFile(File _image) async {
    await Firebase.initializeApp();

    firebase_storage.Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('itemsImages/${basename(_image.path)}');
    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.then((p0) => print('File Uploaded'));
    String returnURL = "";
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }
// Future<String> uploadFile(File _image) async {
//   StorageReference storageReference = FirebaseStorage.instance
//       .ref()
//       .child('sightings/${Path.basename(_image.path)}');
//   StorageUploadTask uploadTask = storageReference.putFile(_image);
//   await uploadTask.onComplete;
//   print('File Uploaded');
//   String returnURL;
//   await storageReference.getDownloadURL().then((fileURL) {
//     returnURL =  fileURL;
//   });
//   return returnURL;
// }
}
