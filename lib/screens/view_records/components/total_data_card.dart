import 'package:flutter/material.dart';
import 'package:sav_sales_app/constants/tableConstants.dart';

class TotalDataCard extends StatelessWidget {
  const TotalDataCard({
    Key? key,
    required this.totalOrdersData,
  }) : super(key: key);

  final Map totalOrdersData;

  @override
  Widget build(BuildContext context) {
    Map totalMap = {'price': 0.0, 'qty': 0};
    // function return a widget list and calculate the total price,qty of items
    List itemRowList = totalOrdersData['keyList'].map((e) {
      Map returnData = totalOrdersData[e];
      totalMap['price'] += returnData['price'];
      totalMap['qty'] += returnData['qty'];
      return TableRow(children: [
        Text(e),
        Text("${returnData['qty']}", textAlign: TextAlign.end),
        Text("${returnData['price']}₹", textAlign: TextAlign.end),
      ]);
    }).toList();
    return Theme(
      data: ThemeData.light(),
      child: Container(
        constraints: BoxConstraints(minHeight: 100),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.blue.shade100.withOpacity(.5),
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text("Total Cash"),
            SizedBox(height: 10),
            Table(
              border: KTableBorder,
              children: [
                TableRow(children: [
                  Text('As cash', textAlign: TextAlign.end),
                  Text('As Items', textAlign: TextAlign.end),
                  Text('Total', textAlign: TextAlign.end),
                ]),
                TableRow(children: [
                  Text('${totalOrdersData['amount']}₹',
                      textAlign: TextAlign.end),
                  Text('${totalMap['price'].toStringAsFixed(1)}₹',
                      textAlign: TextAlign.end),
                  Text(
                      '${(totalOrdersData['amount'] + totalMap['price']).toStringAsFixed(1)}₹',
                      textAlign: TextAlign.end),
                ]),
              ],
            ),
            SizedBox(height: 20),
            Text("Total Return Items"),
            SizedBox(height: 8),
            Table(
              border: KTableBorder,
              columnWidths: {
                0: FlexColumnWidth(5),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(3),
              },
              children: [
                TableRow(children: [
                  Text('name'),
                  Text('qty', textAlign: TextAlign.end),
                  Text('price', textAlign: TextAlign.end),
                ]),
                ...itemRowList,
                TableRow(children: [
                  Text('total'),
                  Text(totalMap['qty'].toStringAsFixed(1),
                      textAlign: TextAlign.end),
                  Text("${totalMap['price'].toStringAsFixed(1)}₹",
                      textAlign: TextAlign.end),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
