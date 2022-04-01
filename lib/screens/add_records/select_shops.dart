import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sav_sales_app/constants/constants.dart';
import 'package:sav_sales_app/providers/itemDetailsProvider.dart';
import 'package:sav_sales_app/screens/RecordsDatabase.dart';
import 'package:sav_sales_app/widgets/ModalProgressHudWidget.dart';

import 'add_records.dart';

class SelectShops extends StatefulWidget {
  final List<Map> customersList;
  SelectShops({required this.customersList});

  @override
  _SelectShopsState createState() => _SelectShopsState();
}

class _SelectShopsState extends State<SelectShops> {
  bool _showSpinner = false;
  List<Map> customersList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showSpinner = false;
    customersList = widget.customersList;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Record"),
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
                    Map customerData = customersList[i];
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Material(
                        elevation: 4,
                        child: InkWell(
                          onTap: () async {
                            _showSpinner = true;
                            setState(() {});
                            try {
                              List _itemsList = [];
                              _itemsList =
                                  await Provider.of<ItemDetailsProvider>(
                                          context,
                                          listen: false)
                                      .getData();
                              // List prvsRecordList = await RecordDatabase
                              //     .getCustomerPrvsRecordData('100');
                              // print(prvsRecordList);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddRecords(
                                            userData: customerData,
                                            itemsList: _itemsList,
                                          )));
                            } catch (e) {
                              print(e);
                            }
                            _showSpinner = false;
                            setState(() {});
                          },
                          child: Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
