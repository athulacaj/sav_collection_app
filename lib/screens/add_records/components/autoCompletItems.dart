import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sav_sales_app/widgets/AutoCompleteTextField.dart';

class AutoCompleteNameClass {
  late List itemsList;
  late List<ArbitraryNameSuggestionType> itemsArbitraryList = [];
  late FocusNode focusNode;
  late void Function(String name) showModalSheet;
  late GlobalKey<AutoCompleteTextFieldState<ArbitraryNameSuggestionType>> key;
  AutoCompleteNameClass(
      {required List itemList,
      var key,
      required void Function(String name) showModalSheet}) {
    this.itemsList = itemList;

    this.key = key;
    createDataList();
    focusNode = FocusNode();
    this.showModalSheet = showModalSheet;
  }

  void closeSuggestionWindow() {
    FocusScope.of(key.currentContext!).unfocus();
  }

  bool isSuggestionWindowFocused() {
    // focusNode.hasFocus;
    return (focusNode.hasFocus);
  }

  void createDataList() {
    for (var item in itemsList) {
      itemsArbitraryList.add(new ArbitraryNameSuggestionType(item['name']));
    }
  }

  Widget textField(
      {required TextEditingController nameController,
      required Function focusChange}) {
    return AutoCompleteTextField<ArbitraryNameSuggestionType>(
        decoration: new InputDecoration(
            hintText: "Enter item name",
            suffix: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        nameController.text = '';
                        FocusScope.of(key.currentContext!).unfocus();
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 10),
                        child: Icon(Icons.close),
                      )),
                ],
              ),
            )),
        itemSubmitted: (item) async {
          showModalSheet(item.name);
          // nameController.text = item.name;
        },
        onFocusChanged: (bool isFocusChanged) {
          focusChange(isFocusChanged);
        },
        focusNode: focusNode,
        key: key,
        controller: nameController,
        suggestionsAmount: 40,
        clearOnSubmit: true,
        // submitOnSuggestionTap: false,
        suggestions: itemsArbitraryList,
        itemBuilder: (context, suggestion) => new Padding(
            child: new ListTile(
                title: new Text(suggestion.name),
                trailing: new Text("area: ${suggestion.name}")),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2)),
        itemSorter: (a, b) => a.name == b.name ? 0 : 1,
        // : a.id > b.id
        //     ? -1
        //     : 1,

        itemFilter: (suggestion, input) {
          return suggestion.name
                  .toLowerCase()
                  .startsWith(input.toLowerCase()) ||
              suggestion.name.toLowerCase().startsWith(input.toLowerCase());
        });
  }
}

class ArbitraryNameSuggestionType {
  String name;
  ArbitraryNameSuggestionType(this.name);
}
