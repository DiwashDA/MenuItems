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
    await Firebase.initializeApp();
    CollectionReference items = FirebaseFirestore.instance.collection('data');
    var url = await uploadFile(image);
    Map<String, dynamic> data = {
      "name": "${item.name}",
      "description": "${item.description}",
      "image": "$url",
      "category": "${item.category}",
      "price": "${item.price}"
    };
    return items.add(data).then((value) => print(value));
  }

  Future<List<ItemModel>> getAllItems() async {
    try {
      await Firebase.initializeApp();
      CollectionReference items = await FirebaseFirestore.instance
          .collection('data')
          .withConverter<ItemModel>(
              fromFirestore: (snapshots, _) =>
                  ItemModel.fromJson(snapshots.data()!),
              toFirestore: (snapshots, _) => ItemModel().toJson());
      var value = await items.get();
      print(value.docs[0]);
      return value.docs;
    } catch (e) {
      throw "ERROR";
    }
    throw "ERROR";
  }

  Future<List<ItemModel>> getItemsbyCategory(category) async {
    await Firebase.initializeApp();

    CollectionReference items = FirebaseFirestore.instance.collection('data');

    items.where('category', isEqualTo: "$category").get().then((value) {
      List<Map> data = [];
      for (var i = 0; i < value.docs.length; i++) {
        data.add(jsonDecode(value.docs[i].data().toString()));
      }
      print("DATA $data");
      return data;
    });
    return [];
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
