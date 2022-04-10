import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sav_sales_app/constants/textFieldDecoration.dart';

import 'manageEmployees.dart';

class ViewEmployees extends StatefulWidget {
  const ViewEmployees({Key? key}) : super(key: key);

  @override
  State<ViewEmployees> createState() => _ViewEmployeesState();
}

class _ViewEmployeesState extends State<ViewEmployees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mange Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('employees')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  print(snapshot.data?.docs[0].data());
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                      employeesList = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: employeesList == null ? 0 : employeesList.length,
                    itemBuilder: (BuildContext context, int i) {
                      Map emp = employeesList![i].data();
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(emp['name']),
                                Text(emp['role']),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            MaterialButton(
              color: Colors.deepPurpleAccent,
              onPressed: () {
                TextEditingController nameController =
                    new TextEditingController();
                showModalBottomSheet(
                    builder: (BuildContext ctx) {
                      return ManageEmployees(nameController: nameController);
                    },
                    context: context);
              },
              child: Text("Add", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
