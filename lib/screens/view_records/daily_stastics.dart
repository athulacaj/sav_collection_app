import 'package:flutter/material.dart';
import 'package:sav_sales_app/widgets/ModalProgressHudWidget.dart';
import 'components/date_button.dart';
import 'components/returnItemsAndAmountDate_table.dart';
import 'components/total_data_card.dart';
import 'components/widget_full_screen_view.dart';
import 'viewRecordDatabaseClass.dart';

class DailyStatistics extends StatefulWidget {
  const DailyStatistics({Key? key}) : super(key: key);

  @override
  State<DailyStatistics> createState() => _DailyStatisticsState();
}

class _DailyStatisticsState extends State<DailyStatistics> {
  DateTime _selectedDate = DateTime.now();
  late List<Map<String, dynamic>> allOrdersList = [];
  bool _isLoading = true;
  int selectedCustomer = -1;
  Map? totalOrdersData = {};
  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  void initFunctions() async {
    // total orders and calculate total amount and items
    totalOrdersData = await ViewRecordDatabase.rangeData();
    // all orders in the specific date
    allOrdersList =
        totalOrdersData!.isNotEmpty ? totalOrdersData!['ordersList'] : [];
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Daily View"),
            actions: <Widget>[
              DateButton(
                selectedDate: _selectedDate,
                onclick: (var dateSelected) {
                  _selectedDate = dateSelected;
                  setState(() {});
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      totalOrdersData != null &&
                              totalOrdersData!.isNotEmpty &&
                              allOrdersList.isNotEmpty
                          ? WidgetViewFullScreen(
                              child: TotalDataCard(
                                  totalOrdersData: totalOrdersData!))
                          : Container(),
                      Divider(),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 10000),
                        child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int i) {
                              Map data = allOrdersList[i];

                              // function to make total of individual customer
                              Map totalOfData =
                                  data['amountReturnItemAmountList'].reduce(
                                      (Map<String, dynamic> first,
                                          Map<String, dynamic> second) {
                                Map<String, dynamic> temp = {...first};
                                temp['amount'] += second['amount'];
                                temp['returnItemAmount'] +=
                                    temp['returnItemAmount'];
                                return temp;
                              });
                              print(totalOfData);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCustomer =
                                        selectedCustomer == i ? -1 : i;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      selectedCustomer == i
                                          ? Container()
                                          : Container(
                                              padding: EdgeInsets.only(
                                                  top: 13,
                                                  bottom: 13,
                                                  left: 4,
                                                  right: 4),
                                              color: selectedCustomer == i
                                                  ? Colors.greenAccent
                                                      .withOpacity(.5)
                                                  : null,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child:
                                                          Text(data['name'])),
                                                  Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5.0,
                                                                right: 4),
                                                        child: Text(
                                                            "₹ ${totalOfData['amount']}"),
                                                      ),
                                                      Positioned(
                                                          bottom: -9,
                                                          right: -5,
                                                          child: selectedCustomer !=
                                                                  i
                                                              ? Icon(Icons
                                                                  .arrow_drop_down)
                                                              : Icon(Icons
                                                                  .arrow_drop_up)),
                                                    ],
                                                  ),
                                                  // Text(data['price']),
                                                ],
                                              ),
                                            ),
                                      selectedCustomer == i
                                          ? WidgetViewFullScreen(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 13,
                                                        bottom: 13,
                                                        left: 4,
                                                        right: 4),
                                                    color: selectedCustomer == i
                                                        ? Colors.greenAccent
                                                            .withOpacity(.5)
                                                        : null,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                data['name'])),
                                                        Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          5.0,
                                                                      right: 4),
                                                              child: Text(
                                                                  "₹ ${totalOfData['amount']}"),
                                                            ),
                                                            Positioned(
                                                                bottom: -9,
                                                                right: -5,
                                                                child: selectedCustomer !=
                                                                        i
                                                                    ? Icon(Icons
                                                                        .arrow_drop_down)
                                                                    : Icon(Icons
                                                                        .arrow_drop_up)),
                                                          ],
                                                        ),
                                                        // Text(data['price']),
                                                      ],
                                                    ),
                                                  ),
                                                  ReturnItemsAndAmountDateTable(
                                                      allOrdersList[i]
                                                          ['itemList'],
                                                      amountReturnItemAmountList:
                                                          data[
                                                              'amountReturnItemAmountList']),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int i) {
                              return Container(height: 1, color: Colors.grey);
                            },
                            itemCount: allOrdersList.length),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            selectedCustomer = -1;
                            setState(() {});
                          },
                          child: Text("clear")),
                      TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        ...["All"].map((e) {
                                          return TextButton(
                                            child: Text(e),
                                            onPressed: () {},
                                          );
                                        }).toList()
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text("export")),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
