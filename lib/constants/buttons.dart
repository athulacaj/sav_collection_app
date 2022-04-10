import 'package:flutter/material.dart';

class MyButton1 extends StatelessWidget {
  final String title;
  final Function onClick;
  final Color btnColor, textColor;
  MyButton1(
      {required this.title,
      required this.onClick,
      this.btnColor = Colors.blueAccent,
      this.textColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: btnColor,
        onPressed: () {
          onClick();
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ));
  }
}
