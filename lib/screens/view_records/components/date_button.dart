import 'package:flutter/material.dart';
import 'package:sav_sales_app/functions/selectDate.dart';

class DateButton extends StatelessWidget {
  final Function onclick;
  final DateTime selectedDate;
  const DateButton(
      {required this.onclick, required this.selectedDate, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectDate(context, selectedDate, (_selectedDate) {
        // selectedDate = _selectedDate;
        onclick(_selectedDate);
      }),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          "${selectedDate.toLocal()}".split(' ')[0],
          textAlign: TextAlign.center,
        ),
        alignment: Alignment.center,
        height: double.infinity,
      ),
    );
  }
}
