import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sav_sales_app/providers/admin_data_provider.dart';

import 'customers_category/customersCategory.dart';
import 'employess/viewEmployees.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewEmployees()));
                },
                child: Text("Manage Employees")),
            TextButton(
                onPressed: () {
                  Provider.of<AdminDataProvider>(context, listen: false)
                      .getCustomersData();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomersCategory()));
                },
                child: Text("customers category")),
          ],
        ),
      ),
    );
  }
}
