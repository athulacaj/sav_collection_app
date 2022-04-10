import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'manageCustomersCategory.dart';

class CustomersCategory extends StatefulWidget {
  const CustomersCategory({Key? key}) : super(key: key);

  @override
  State<CustomersCategory> createState() => _CustomersCategoryState();
}

class _CustomersCategoryState extends State<CustomersCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('customersCategory')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  print(snapshot.data?.docs[0].data());
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                      customersCategoryList = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: customersCategoryList == null
                        ? 0
                        : customersCategoryList.length,
                    itemBuilder: (BuildContext context, int i) {
                      Map categoryData = customersCategoryList![i].data();
                      String id = customersCategoryList[i].id;
                      categoryData['id'] = id;
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(categoryData['name']),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManageCustomersCategory(
                                              categoryData: categoryData)),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
