import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final Function onClick;
  final String title;
  final IconData iconData;
  HomeButton(
      {required this.onClick, required this.title, required this.iconData});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        // margin: EdgeInsets.only(right: 16),
        width: size.width / 2 - 24,
        height: 200,
        color: Colors.grey.withOpacity(.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 30,
            ),
            SizedBox(height: 20),
            Text(title),
          ],
        ),
      ),
    );
  }
}
