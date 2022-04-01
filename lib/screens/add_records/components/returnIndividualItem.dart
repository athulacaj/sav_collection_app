// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget ReturnItemsHeader() {
  return Row(
    children: [
      Expanded(
        child: Text(' name',
            style: TextStyle(fontSize: 16, color: Colors.blueAccent.shade700)),
      ),
      SizedBox(width: 12),
      Container(
          width: 40,
          child: Text(
            "qty",
            style: TextStyle(color: Colors.yellow.shade700),
          )),
      SizedBox(width: 10),
      Container(
          width: 40,
          child: Text(
            "price",
            style: TextStyle(color: Colors.greenAccent.shade700),
          )),
      SizedBox(width: 50),
    ],
  );
}

class ReturnIndividualItem extends StatelessWidget {
  final Map returnItem;
  final returnItemEnteringModelClass;
  const ReturnIndividualItem(
      {Key? key,
      required this.returnItem,
      required this.returnItemEnteringModelClass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(2),
            color: Colors.blueAccent.withOpacity(.5),
            child: Text(returnItem['name'], style: TextStyle(fontSize: 16)),
          ),
        ),
        SizedBox(width: 10),
        Container(
            width: 40,
            padding: EdgeInsets.all(2),
            color: Colors.yellow.withOpacity(.5),
            child: Text("${returnItem['qty']}")),
        SizedBox(width: 10),
        Container(
            width: 40,
            padding: EdgeInsets.all(2),
            color: Colors.greenAccent.withOpacity(.5),
            child: Text("${returnItem['price']}")),
        IconButton(
          onPressed: () {
            returnItemEnteringModelClass
                .showEnterItemDetailsSheet(returnItem['name']);
          },
          icon: Icon(Icons.edit),
          // padding: EdgeInsets.all(0),
          // splashRadius: 2,
        )
      ],
    );
  }
}
