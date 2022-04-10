import 'package:flutter/material.dart';
import 'package:sav_sales_app/constants/constants.dart';
import 'package:sav_sales_app/functions/selectDate.dart';
import 'package:sav_sales_app/functions/showToastFunction.dart';
import 'package:sav_sales_app/screens/RecordsDatabase.dart';
import 'package:sav_sales_app/widgets/AutoCompleteTextField.dart';
import 'package:sav_sales_app/widgets/ModalProgressHudWidget.dart';

import 'components/autoCompletItems.dart';
import 'components/returnIndividualItem.dart';
import 'components/return_item_enter_modal_sheet.dart';

class AddRecords extends StatefulWidget {
  final Map userData;
  final List itemsList;
  final Map? alreadyAdded;
  AddRecords(
      {required this.userData,
      required this.itemsList,
      required this.alreadyAdded});
  @override
  _AddRecordsState createState() => _AddRecordsState();
}

class _AddRecordsState extends State<AddRecords> {
  List<Map> returnItemsList = [];
  List orderItems = [];
  late TextEditingController _cashTextController,
      _priceController,
      _nameController,
      _qtyController;
  bool _showSpinner = false;
  GlobalKey<AutoCompleteTextFieldState<ArbitraryNameSuggestionType>> _key =
      new GlobalKey<AutoCompleteTextFieldState<ArbitraryNameSuggestionType>>();
  late AutoCompleteNameClass autoCompleteNameClass;
  bool _isNameTextFieldClicked = false;
  late ReturnItemEnteringModelClass returnItemEnteringModelClass;
  @override
  void initState() {
    super.initState();
    returnItemsList = [];
    // orderItems = List.from(widget.orderData["details"]);
    orderItems.insert(0, {"name": "Chack"});
    orderItems.insert(0, {"name": "K. Box"});
    orderItems.insert(0, {"name": "Tray"});
    _cashTextController = new TextEditingController();
    _priceController = new TextEditingController();
    _nameController = new TextEditingController();
    _qtyController = new TextEditingController();
    returnItemEnteringModelClass = ReturnItemEnteringModelClass(
        context: context,
        priceController: _priceController,
        qtyController: _qtyController,
        returnItemsList: returnItemsList,
        setState: () {
          setState(() {});
        });
    autoCompleteNameClass = new AutoCompleteNameClass(
        itemList: widget.itemsList,
        key: _key,
        showModalSheet: returnItemEnteringModelClass.showEnterItemDetailsSheet);
    addedPreviousData();
  }

  void addedPreviousData() {
    if (widget.alreadyAdded != null) {
      _cashTextController.text = widget.alreadyAdded!['amount'].toString();
      returnItemsList = widget.alreadyAdded!['itemList'].cast<Map>();
    }
  }

  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        print(autoCompleteNameClass.isSuggestionWindowFocused());
        if (autoCompleteNameClass.isSuggestionWindowFocused()) {
          autoCompleteNameClass.closeSuggestionWindow();
        } else {
          // show the confirm dialog
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Are you sure want to leave?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            willLeave = true;
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes')),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('No'))
                    ],
                  ));
        }
        return willLeave;
      },
      child: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Scaffold(
          appBar: _isNameTextFieldClicked
              ? null
              : AppBar(
                  title: Text(widget.userData["name"]),
                  actions: <Widget>[
                    GestureDetector(
                      onTap: () =>
                          selectDate(context, _selectedDate, (selectedDate) {
                        _selectedDate = selectedDate;
                      }),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "${_selectedDate.toLocal()}".split(' ')[0],
                          textAlign: TextAlign.center,
                        ),
                        alignment: Alignment.center,
                        height: double.infinity,
                      ),
                    ),
                  ],
                ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                !_isNameTextFieldClicked
                    ? Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: TextField(
                            autofocus: false,
                            controller: _cashTextController,
                            keyboardType: TextInputType.number,
                            decoration: textFieldDecoration.copyWith(
                                labelText: "Enter the cash received")),
                      )
                    : Container(),
                autoCompleteNameClass.textField(
                    nameController: _nameController,
                    focusChange: (bool isFocusChanged) {
                      _isNameTextFieldClicked = isFocusChanged;
                      setState(() {});
                    }),
                SizedBox(height: 10),
                SizedBox(height: 10),
                Text("Return Items"),
                Divider(),
                ReturnItemsHeader(), // for show the table column name
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: returnItemsList.length,
                    itemBuilder: (BuildContext context, int i) {
                      // table individual row
                      return ReturnIndividualItem(
                        returnItem: returnItemsList[i],
                        returnItemEnteringModelClass:
                            returnItemEnteringModelClass,
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      _showSpinner = true;
                      setState(() {});
                      Map<String, dynamic> data = {
                        "name": widget.userData["name"],
                        "code": widget.userData['code'],
                        "amount":
                            double.tryParse(_cashTextController.text) ?? 0,
                        "itemList": returnItemsList,
                        'date': _selectedDate.toString().substring(0, 10),
                        'dateMs': _selectedDate.millisecondsSinceEpoch
                      };
                      try {
                        await RecordDatabase.saveRecord(data)
                            .then((value) => showToast("Saved Successfully"));
                        showToast("Saved Successfully");
                      } catch (e) {
                        print("exception : " + e.toString());
                      }
                      _showSpinner = false;
                      setState(() {});
                    },
                    child: Container(
                        width: size.width,
                        height: 50,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "Return items: ${returnItemsList.length} | amount : ${getAmountOfItems()}"),
                                SizedBox(height: 3),
                                Text(
                                    "cash received: ${_cashTextController.text} ₹"),
                              ],
                            ),
                            Text("Save", style: TextStyle(fontSize: 18)),
                          ],
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getAmountOfItems() {
    double sum = 0;
    for (Map e in returnItemsList) {
      sum += e['price'];
    }
    return sum;
  }

  @override
  void dispose() {
    super.dispose();
    orderItems = [];
  }

  @override
  void deactivate() {
    super.deactivate();
    orderItems = [];
  }
}
