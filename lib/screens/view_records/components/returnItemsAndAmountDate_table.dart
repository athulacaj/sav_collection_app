import 'package:flutter/material.dart';
import 'package:sav_sales_app/constants/tableConstants.dart';

class ReturnItemsAndAmountDateTable extends StatelessWidget {
  final List itemsList;
  final List amountReturnItemAmountList;
  const ReturnItemsAndAmountDateTable(this.itemsList,
      {Key? key, required this.amountReturnItemAmountList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> itemTableRowList = [];
    List<TableRow> amountReturnItemTableRowList = [];
    createAmountReturnItemTable(
        amountReturnItemAmountList, amountReturnItemTableRowList);
    createReturnTable(itemsList, itemTableRowList);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 10),
          amountReturnItemAmountList.length > -1
              ? Table(
                  border: KTableBorder,
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(children: [
                      Text('Date'),
                      Text('amount', textAlign: TextAlign.end),
                      Text('return items', textAlign: TextAlign.end),
                    ]),
                    ...amountReturnItemTableRowList,
                  ],
                )
              : Container(),
          SizedBox(height: 10),
          Table(
            border: KTableBorder,
            columnWidths: {
              0: FlexColumnWidth(4),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(children: [
                Text('name'),
                Text('qty', textAlign: TextAlign.end),
                Text('price', textAlign: TextAlign.end),
              ]),
              ...itemTableRowList,
            ],
          ),
        ],
      ),
    );
  }
}

void createReturnTable(itemsList, itemTableRowList) {
  Map totalMap = {'price': 0.0, 'qty': 0};
  for (int j = 0; j < itemsList.length; j++) {
    Map item = itemsList[j];
    TableRow row = TableRow(children: [
      Text(item['name']),
      Text(item['qty'].toString(), textAlign: TextAlign.end),
      Text("₹ " + item['price'].toString(), textAlign: TextAlign.end),
    ]);
    totalMap['price'] += item['price'];
    totalMap['qty'] += item['qty'];
    itemTableRowList.add(row);
  }
  TableRow totalRow = TableRow(children: [
    Text('total'),
    Text(totalMap['qty'].toString(), textAlign: TextAlign.end),
    Text("₹ " + totalMap['price'].toString(), textAlign: TextAlign.end),
  ]);
  itemTableRowList.add(totalRow);
}

void createAmountReturnItemTable(
    amountReturnItemAmountList, amountReturnItemTableRowList) {
  Map totalMap = {'price': 0.0, 'qty': 0};
  for (int j = 0; j < amountReturnItemAmountList.length; j++) {
    Map item = amountReturnItemAmountList[j];
    TableRow row = TableRow(children: [
      Text("${item['date']}".substring(8)),
      Text("₹ " + item['amount'].toString(), textAlign: TextAlign.end),
      Text("₹ " + (item['returnItemAmount'] ?? 0).toString(),
          textAlign: TextAlign.end),
    ]);
    // totalMap['price'] += item['price'];
    // totalMap['qty'] += item['qty'];
    amountReturnItemTableRowList.add(row);
  }
  // TableRow totalRow = TableRow(children: [
  //   Text('total'),
  //   Text(totalMap['qty'].toString(), textAlign: TextAlign.end),
  //   Text("₹ " + totalMap['price'].toString(), textAlign: TextAlign.end),
  // ]);
  // amountReturnItemTableRowList.add(totalRow);
}
