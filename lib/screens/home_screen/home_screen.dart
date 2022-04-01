import 'package:flutter/material.dart';
import 'package:sav_sales_app/providers/itemDetailsProvider.dart';
import 'package:sav_sales_app/screens/addExcelPrice/excel_convertor.dart';
import 'package:sav_sales_app/screens/players/manage_players.dart';
import 'package:sav_sales_app/screens/players/players_database.dart';
import 'package:sav_sales_app/screens/players/reset-or%20_add_palyers.dart';
import 'package:sav_sales_app/screens/view_records/daily_stastics.dart';
import 'package:sav_sales_app/widgets/ModalProgressHudWidget.dart';

import '../add_records/select_shops.dart';
import '../RecordsDatabase.dart';
import 'HomeButton.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showSpinner = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ItemDetailsProvider.getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sales App"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeButton(
                    title: "Add Data",
                    iconData: Icons.add,
                    onClick: () async {
                      _showSpinner = true;
                      _showSpinner = true;
                      setState(() {});
                      try {
                        // List<Map> shopsList =
                        //     await RecordDatabase.getOrdersShops();
                        //
                        List<Map> customersList =
                            await RecordDatabase.getCustomersList();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectShops(
                                      customersList: customersList,
                                    )));
                      } catch (e) {
                        print("exception : " + e.toString());
                      }
                      _showSpinner = false;
                      setState(() {});
                    },
                  ),
                  HomeButton(
                    title: "View Data",
                    iconData: Icons.list,
                    onClick: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DailyStatistics()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              HomeButton(
                title: "Read Excel",
                iconData: Icons.mark_email_read,
                onClick: () async {
                  List excelList = await excelToJson();
                  customersDataGenerator(excelList);
                },
              ),
              // TextButton(
              //     onPressed: () {
              //       savePlayerOrReset();
              //     },
              //     child: Text("Reset")),
              TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagePlayers()));
                  },
                  child: Text("Players")),
            ],
          ),
        ),
      ),
    );
  }
}
