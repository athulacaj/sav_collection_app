import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDataProvider extends ChangeNotifier {
  static List<QueryDocumentSnapshot<Map<String, dynamic>>> _customersList = [];
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getCustomersData() async {
    if (_customersList.isEmpty) {
      print("loading from db");
      await getCustomersDataFromDB();
      return _customersList;
    }
    print("loading from local");
    return _customersList;
  }

  static Future<void> getCustomersDataFromDB() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("excelCustomers").get();
    if (snapshot.docs.isNotEmpty) _customersList = snapshot.docs;
  }
}
