import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.controller,
    this.icon,
    this.fillColor,
    required this.obscureText,
    this.labelText,
    this.suffixIcon,
    this.voidCallback,
  });
  TextEditingController controller = TextEditingController();
  IconData? icon;
  Color? fillColor;
  bool obscureText;
  IconData? suffixIcon;
  VoidCallback? voidCallback;
  String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          fillColor: fillColor,
          filled: true,
          prefixIcon: Icon(
            icon,
          ),
          suffixIcon: InkWell(onTap: voidCallback, child: Icon(suffixIcon)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(),
          )),
    );
  }
}

/*    ****    Custom TextFIeld V2      ****   */
class CustomTextFieldV2 extends StatelessWidget {
  CustomTextFieldV2(
      {required this.controller,
      required this.color,
      this.hintText,
      this.icon,
      this.textInputType});

  final TextEditingController controller;
  IconData? icon;
  String? hintText;
  Color color;
  TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: mTextStyle25(),
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: mTextStyle16(mColor: color.withOpacity(.5)),
        prefixIcon: Icon(
          icon,
          color: color,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
        focusedBorder: UnderlineInputBorder(),
      ),
    );
  }
}
