import 'package:flutter/material.dart';

Future<Null> selectDate(BuildContext context, DateTime selectedDate,
    Function onDateSelected) async {
  DateTime now = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(now.year, now.month + 1, now.day - 1));
  if (picked != null && picked != selectedDate) selectedDate = picked;
  print('date changed');
  onDateSelected(selectedDate);
}
