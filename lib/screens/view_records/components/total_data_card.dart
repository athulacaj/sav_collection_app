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

    return Container(
      color: Colors.blue.shade100,
      constraints: BoxConstraints(minHeight: 100),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text("Total : ${totalOrdersData['amount']}"),
          Divider(),
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
              ...totalOrdersData['keyList'].map((e) {
                Map returnData = totalOrdersData[e];
                totalMap['price'] += returnData['price'];
                totalMap['qty'] += returnData['qty'];
                return TableRow(children: [
                  Text(e),
                  Text("${returnData['qty']}", textAlign: TextAlign.end),
                  Text("${returnData['price']}", textAlign: TextAlign.end),
                ]);
              }).toList(),
              TableRow(children: [
                Text('total'),
                Text(totalMap['qty'].toStringAsFixed(1),
                    textAlign: TextAlign.end),
                Text(totalMap['price'].toStringAsFixed(1),
                    textAlign: TextAlign.end),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
