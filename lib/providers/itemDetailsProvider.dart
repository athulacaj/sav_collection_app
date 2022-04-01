import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemDetailsProvider extends ChangeNotifier {
  static List _itemsList = [];
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List> getData() async {
    if (_itemsList.isEmpty) {
      await getDataFromDatabase();
      return _itemsList;
    }
    return _itemsList;
  }

  static Future<void> getDataFromDatabase() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("items").doc("vegetables").get();
    _itemsList = snapshot.data()!['allInfo'];
    _itemsList.insert(0, {"name": "Chack"});
    _itemsList.insert(0, {"name": "K. Box"});
    _itemsList.insert(0, {"name": "Tray"});
    // snapshot = await _firestore.collection("items").doc("driedFish").get();
    // _itemsList += snapshot.data()!['allInfo'];
  }
}
