import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sav_sales_app/constants/constants.dart';
import 'package:sav_sales_app/providers/admin_data_provider.dart';

import 'add_shops.dart';

class ManageCustomersCategory extends StatefulWidget {
  final Map categoryData;
  const ManageCustomersCategory({required this.categoryData, Key? key})
      : super(key: key);

  @override
  State<ManageCustomersCategory> createState() =>
      _ManageCustomersCategoryState();
}

class _ManageCustomersCategoryState extends State<ManageCustomersCategory> {
  List customersDataList = [];
  List customersDataListCopy = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> customersList = [];
  List customersNewAddedList = [];
  List customersNewAddedIdList = [];
  late TextEditingController _searchController;
  late FocusNode focusNode;
  @override
  void initState() {
    _searchController = new TextEditingController();
    focusNode = FocusNode();
    super.initState();
    getCustomersList();
  }

  void getCustomersList() async {
    customersList = await Provider.of<AdminDataProvider>(context, listen: false)
        .getCustomersData();
    findCustomerNameFromCode();
    setState(() {});
  }

  void findCustomerNameFromCode() {
    for (String code in widget.categoryData['customers'])
      for (QueryDocumentSnapshot<Map> cust in customersList) {
        if (cust.id == code) {
          customersDataList.add(cust.data());
          customersDataListCopy.add(cust.data());
        }
      }
  }

  void deleteCustomer(int i, String code) {
    int j = 0;
    for (var e in customersDataListCopy) {
      if (e['code'] == code) break;
      j++;
    }
    customersDataListCopy.removeAt(j);
    customersDataList = List.from(customersDataListCopy);
    _searchController.clear();
    setState(() {});
  }

  void clear(isKeyboardShowing) {
    // special condition bcz when clicking back button in the keyboard the focusNode not changes it still in focus
    if (!isKeyboardShowing && focusNode.hasFocus) {
      customersDataList = List.from(customersDataListCopy);
      _searchController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    clear(isKeyboardShowing);
    print("is keybopar showing $isKeyboardShowing");
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Customer Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(widget.categoryData['name']),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: focusNode,
                    decoration:
                        textFieldDecoration.copyWith(labelText: "Enter Name"),
                    onChanged: (String value) {
                      print(value);
                      customersDataList = customersDataListCopy.where((e) {
                        return ((e['name'])
                            .toLowerCase()
                            .contains(value.toLowerCase()));
                      }).toList();
                      print(customersList);
                      setState(() {});
                    },
                    // onEditingComplete: () {
                    //   print('value');
                    // },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _searchController.text = '';
                      customersDataList = List.from(customersDataListCopy);
                      setState(() {});
                      focusNode.unfocus();
                      // _searchController.
                    },
                    icon: Icon(Icons.clear))
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: customersDataList.length,
              itemBuilder: (BuildContext context, int i) {
                Map aboutCust = customersDataList[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // padding: EdgeInsets.symmetric(vertical: 1),
                    decoration: BoxDecoration(
                      color: customersNewAddedIdList.contains(aboutCust['code'])
                          ? Colors.yellowAccent.withOpacity(.2)
                          : null,
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(aboutCust['code']),
                        Text(aboutCust['name']),
                        IconButton(
                            onPressed: () {
                              deleteCustomer(i, aboutCust['code']);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              },
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () async {
                    customersNewAddedList = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddShops(customersList: customersList)));
                    // customersList += customersAddedList;

                    for (var cust in customersNewAddedList) {
                      customersNewAddedIdList.add(cust.id);
                      customersDataList.add(cust.data());
                      customersDataListCopy.add(cust.data());
                    }
                    setState(() {});
                  },
                  child: Text("Add"),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text("Save"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    customersNewAddedList = [];
  }
}
