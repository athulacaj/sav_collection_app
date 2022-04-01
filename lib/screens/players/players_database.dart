import 'package:cloud_firestore/cloud_firestore.dart';

class PlayersDatabase {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List> getPlayersData() async {
    DocumentSnapshot<Map> snap =
        await _firestore.collection("records").doc('players').get();
    return snap.data()!['players'];
  }
}
