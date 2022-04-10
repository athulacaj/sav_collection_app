import 'package:flutter/material.dart';
import 'package:sav_sales_app/constants/textFieldDecoration.dart';

class ManageEmployees extends StatelessWidget {
  final TextEditingController nameController;
  const ManageEmployees({required this.nameController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String role = 'admin';
    print("called");

    return StatefulBuilder(builder: (context, setState) {
      return Container(
        height: 700,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              EmployeeTextField(
                textEditingController: nameController,
                type: "Name",
              ),
              Row(
                children: [
                  Text("role : "),
                  DropdownButton<String>(
                      value: role,
                      items: <String>["admin", "sales"]
                          .map((String e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onChanged: (String? item) {
                        role = item!;
                        setState(() {});
                      }),
                ],
              ),
              MaterialButton(
                child: Text("Save", style: TextStyle(color: Colors.white)),
                color: Colors.blueAccent,
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    });
  }
}

class EmployeeTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String type;
  const EmployeeTextField(
      {required this.textEditingController, required this.type, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: TextField(
        controller: textEditingController,
        decoration: textFieldBorderedDecoration.copyWith(helperText: type),
      ),
    );
  }
}
