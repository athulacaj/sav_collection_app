import 'package:flutter/material.dart';
import 'package:sav_sales_app/constants/constants.dart';

class ReturnItemEnteringModelClass {
  final BuildContext context;
  final List<Map> returnItemsList;
  final TextEditingController priceController, qtyController;
  final Function setState;

  ReturnItemEnteringModelClass(
      {required this.context,
      required this.returnItemsList,
      required this.priceController,
      required this.qtyController,
      required this.setState});

  void showEnterItemDetailsSheet(
    String name,
  ) {
    final _formKey = GlobalKey<FormState>();
    int i = 0;
    int productIndex = -1;
    for (Map e in returnItemsList) {
      if (e['name'] == name) {
        priceController.text = e['price'].toString();
        qtyController.text = e['qty'].toString();
        productIndex = i;
        break;
      }
      i++;
    }
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Container(
              height: 500,
              padding: EdgeInsets.all(12),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(name),
                  TextFormField(
                      controller: qtyController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null) {
                          return 'Please enter a valid quantity';
                        }
                        print(double.tryParse(value));
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: textFieldDecoration.copyWith(
                          labelText: "Enter quantity")),
                  TextFormField(
                      controller: priceController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: textFieldDecoration.copyWith(
                          labelText: "Enter price")),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          child: const Text(' Add '),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Map data = {
                                "name": name,
                                "qty": double.parse(qtyController.text),
                                "price": double.parse(priceController.text),
                              };
                              if (productIndex != -1) {
                                returnItemsList[i] = data;
                              } else {
                                returnItemsList.add(data);
                              }
                              Navigator.pop(context);
                              setState();
                            }
                          }),
                      SizedBox(width: 15),
                      ElevatedButton(
                        child: const Text('Remove'),
                        onPressed: () {
                          if (productIndex != -1) {
                            returnItemsList.removeAt(productIndex);
                          }
                          Navigator.pop(context);
                          setState();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
