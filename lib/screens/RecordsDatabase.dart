import 'package:cloud_firestore/cloud_firestore.dart';

class RecordDatabase {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static DateTime now = DateTime.now();
  // read orders by reading the daily orders now its changed we select customer from customer list

  // static Future<List<Map>> getOrdersShops() async {
  //   print("orders/byTime/${now.toString().substring(0, 10)}");
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
  //       .collection("orders/byTime/${now.toString().substring(0, 10)}")
  //       // .where("uid", isEqualTo: "yMSCNtL2cFRSs5VvxGEPnKIesjZ2")
  //       .get();
  //   print(snapshot.docs);
  //   return snapshot.docs.map((e) => e.data()).toList();
  // }
  // static Future<List<Map>> getCustomerPrvsRecordData(String code) async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
  //       .collection("records/account/records")
  //       .where('code', isEqualTo: code)
  //       .orderBy('dateMs', descending: true)
  //       .limit(2)
  //       .get();
  //   return snapshot.docs.map((e) => e.data()).toList();
  // }
  static Future<Map?> getDataIfAlreadyAdded(String code) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection("records/account/records")
        .where('code', isEqualTo: code)
        .where('date', isEqualTo: DateTime.now().toString().substring(0, 10))
        .get();
    List alreadyAddedSnap = snapshot.docs.map((e) => e.data()).toList();
    return alreadyAddedSnap.length > 0 ? alreadyAddedSnap[0] : null;
  }

  static Future<List<Map>> getCustomersList() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("excelCustomers").get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static Future saveRecord(Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection("records/account/records")
          .doc(data['date'] + ":" + data['code'])
          .set(data);
      // .timeout(
      //   Duration(seconds: 20),
      //   onTimeout: () => throw Exception('Can\'t connect in 10 seconds.'),
      // );
    } catch (e) {
      print(e.toString());
      throw Exception("failed to save to db check connection");
    }
  }
}
