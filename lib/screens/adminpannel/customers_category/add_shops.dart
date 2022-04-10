import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sav_sales_app/constants/buttons.dart';
import 'package:sav_sales_app/constants/constants.dart';
import 'package:sav_sales_app/providers/itemDetailsProvider.dart';
import 'package:sav_sales_app/screens/RecordsDatabase.dart';
import 'package:sav_sales_app/widgets/ModalProgressHudWidget.dart';

class AddShops extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> customersList;
  AddShops({required this.customersList});

  @override
  _AddShopsState createState() => _AddShopsState();
}

class _AddShopsState extends State<AddShops> {
  bool _showSpinner = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> selectedShopsList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> customersList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showSpinner = false;
    customersList = widget.customersList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Shops"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                decoration:
                    textFieldDecoration.copyWith(labelText: "Enter Name"),
                onChanged: (String value) {
                  print(value);
                  customersList = widget.customersList.where((e) {
                    return ((e['name'])
                        .toLowerCase()
                        .contains(value.toLowerCase()));
                  }).toList();
                  print(customersList);
                  setState(() {});
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: customersList.length,
                  itemBuilder: (BuildContext context, int i) {
                    QueryDocumentSnapshot<Map<String, dynamic>> customerData =
                        customersList[i];
                    int selectedIndex = getSelectedIndex(customerData.id);
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Material(
                        elevation: 4,
                        child: InkWell(
                          onTap: () async {
                            if (selectedIndex != -1)
                              selectedShopsList.removeAt(selectedIndex);
                            else
                              selectedShopsList.add(customerData);
                            setState(() {});
                          },
                          child: Container(
                              color: selectedIndex != -1
                                  ? Colors.yellowAccent.withOpacity(.5)
                                  : null,
                              child: Container(
                                  padding: EdgeInsets.all(6),
                                  height: 50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(customerData["name"]),
                                    ],
                                  ))),
                        ),
                      ),
                    );
                  },
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selected ${selectedShopsList.length}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text("Add", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) {
                        return Container(
                          height: size.height * .8,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: selectedShopsList.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${i + 1} ) " +
                                                  selectedShopsList[i]
                                                      .data()['name']),
                                              IconButton(
                                                  onPressed: () {
                                                    selectedShopsList
                                                        .removeAt(i);
                                                    Navigator.pop(ctx);
                                                    setState(() {});
                                                  },
                                                  icon: Icon(Icons.delete))
                                            ],
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    );
                                  },
                                )),
                                SizedBox(height: 12),
                                MyButton1(
                                    title: 'Confirm',
                                    onClick: () {
                                      Navigator.pop(ctx);
                                      Navigator.pop(context, selectedShopsList);
                                    }),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    selectedShopsList = [];
    super.deactivate();
  }

  int getSelectedIndex(code) {
    int i = 0;
    for (QueryDocumentSnapshot<Map> cust in selectedShopsList) {
      if (cust.id == code) {
        return i;
      }
      i++;
    }
    return -1;
  }
}
