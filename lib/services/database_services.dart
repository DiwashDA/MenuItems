import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  CollectionReference items = FirebaseFirestore.instance.collection('data');

  addItem(){
    return items.add({}).then((value) => null);
  }
}
