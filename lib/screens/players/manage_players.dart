import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManagePlayers extends StatefulWidget {
  const ManagePlayers({Key? key}) : super(key: key);

  @override
  State<ManagePlayers> createState() => _ManagePlayersState();
}

class _ManagePlayersState extends State<ManagePlayers> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List playersList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<DocumentSnapshot<Map>>(
                stream:
                    _firestore.collection("records").doc('players').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map>> snapshot) {
                  if (snapshot.data == null && snapshot.data?.exists == false)
                    return CircularProgressIndicator();
                  playersList = snapshot.data!.data()!['players'];
                  return ListView.builder(
                      itemCount: playersList.length,
                      itemBuilder: (BuildContext context, int i) {
                        Map player = playersList[i];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 4,
                            child: Container(
                              // color: Colors.greenAccent.shade100,
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${i + 1} ${player['name']}"),
                                      SizedBox(width: 10),
                                      Text(player['role']),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(player['current team']),
                                      SizedBox(width: 10),
                                      Text(player['hand']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("clear"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Filter"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
