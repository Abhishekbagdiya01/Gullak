import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  CustomLogo(
      {required this.mSize, required this.bgColor, required this.iconColor});
  var mSize;
  Color iconColor;
  Color bgColor;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return CircleAvatar(
      radius: mSize,
      backgroundColor: bgColor,
      child: ImageIcon(
          AssetImage(
            "assets/images/expenses.png",
          ),
          color: iconColor,
          size: mSize),
    );
  }
}
