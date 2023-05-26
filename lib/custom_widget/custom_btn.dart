import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  CustomBtn({
    required this.text,
    required this.voidCallback,
    required this.color,
    required this.txtColor,
  });
  var text;
  VoidCallback voidCallback;
  Color color;
  Color txtColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: color,
        onPressed: voidCallback,
        child: Text(
          text,
          style: mTextStyle16(mColor: txtColor),
        ),
      ),
    );
  }
}
